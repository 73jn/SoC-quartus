
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DMA_LCD_ctrl is
	port (
		signalsClk               : in    std_logic                    ;
		nReset             : in    std_logic                    ;
		-- master interface
 		master_address	  : out  std_logic_vector(31 downto 0);
		master_read	  : out std_logic;
		master_readdata	  : in std_logic_vector(15 downto 0) ;
		master_waitrequest : in std_logic;
		-- IRQ generation
		end_of_transaction_irq : out std_logic;
		-- slave interface
		avalon_address    : in    std_logic_vector(2 downto 0) ;
		avalon_cs         : in    std_logic                   ;
		avalon_wr         : in    std_logic                    ;
		avalon_write_data : in    std_logic_vector(31 downto 0);
		avalon_rd         : in    std_logic                    ;
		avalon_read_data  : out    std_logic_vector(31 downto 0);
		avalon_waitrequest : out std_logic;
		-- LCD interface
		LCD_data          : out std_logic_vector(15 downto 0) ;
		LCD_CS_n	  : out    std_logic ;
		LCD_WR_n	  : out    std_logic ;
		LCD_D_C_n	  : out    std_logic ;

		LCD_IM0	: OUT std_logic;
		LCD_RES: OUT std_logic;
		LCD_RD: OUT std_logic
	);
end entity DMA_LCD_ctrl;

architecture rtl of DMA_LCD_ctrl is
	signal iRegData: std_logic_vector (15 DOWNTO 0);
	signal iRegDataFromDMA: std_logic_vector (15 DOWNTO 0);
	signal iRegPointer: std_logic_vector (31 DOWNTO 0);
	signal iRegSize: std_logic_vector (31 DOWNTO 0);
	signal iRegControl:  std_logic_vector (2 DOWNTO 0);
	signal iD_C_n: std_logic;
	signal iRegDMA: std_logic_vector(2 DOWNTO 0);
	signal memMaster_waitrequest : std_logic;
	signal sendToLCD : std_logic;
	signal flagIsLocal : std_logic;
  signal iRegMasterReadData : std_logic_vector (15 DOWNTO 0);
	type smState is (
	    IDLE, STATE1, STATE2
	  );
	signal mainState : smState;

	type smStateDMA is (
			IDLEDMA, READMEM, SEND, WAITTOSEND
		);
	signal mainStateDMA : smStateDMA;
begin
-------- register model (a proposal) -----------
-- 000 write command to LCD
-- 001 write data to LCD
-- 010 write pointer of the image to copy
-- 011 write size of the image to copy
-- 100 control register
--	bit 0 => start transfer
--	bit 1 => reserved
--	bit 2 => IRQ ack
--master_read <= '0';
--master_address <= (others => '0');
end_of_transaction_irq <= '0';
avalon_read_data <= (others => '0');
iRegMasterReadData <= master_readdata; --debug
pRegWr : process(signalsClk, nReset)
begin
	if nReset = '0' then
		iRegData <= (others => '0');-- Input by default
		iRegControl <= (others => '0');-- Input by default
		iD_C_n <= '0';-- Input by default
		iRegSize <= (others => '0');
		iRegDMA <= (others => '0');
		iRegPointer <= (others => '0');
	elsif rising_edge(signalsClk) then
		iRegDMA(0) <= '0'; -- reset the start transfer
		if avalon_cs = '1' and avalon_wr = '1' then-- Write cycle
			case avalon_address(2 downto 0) is
				when "000" =>
					iRegData <= avalon_write_data(iRegData'high DOWNTO 0);
					iD_C_n <= '0';
				when "001" =>
					iRegData <= avalon_write_data(iRegData'high DOWNTO 0);
					iD_C_n <= '1';
				when "010" =>
					iRegPointer <= avalon_write_data;
				when "011" =>
					iRegSize <= avalon_write_data;
				when "100" =>
					iRegDMA <= avalon_write_data(iRegDMA'high DOWNTO 0);
				when "111" => iRegControl <= avalon_write_data(iRegControl'high DOWNTO 0);
				when others => null;
			end case;
		end if;
	end if;
end process pRegWr;


LCD_D_C_n <= iD_C_n;

process(iRegData, iRegDataFromDMA, flagIsLocal)
BEGIN
  if flagIsLocal = '0' then
		LCD_data <= iRegDataFromDMA;
	else
		LCD_data <= iRegData;
	end if;
end process;

-- Synchronize outputs
pSync:process(signalsClk, nReset)
begin
	if nReset = '0' then
		-- Control register mapping
		LCD_CS_n <= '0';
		LCD_IM0 <= '0';
		LCD_RES <= '0';
		--LCD_DATA <= (others => '0');
	elsif rising_edge(signalsClk) then
		-- Control register mapping
		LCD_CS_n <= iRegControl(0);
		LCD_IM0 <= iRegControl(1);
		LCD_RES <= iRegControl(2);


	end if;
end process pSync;

smWrite:process(signalsClk, nReset)
begin
	if nReset = '0' then
		mainState <= IDLE;
		avalon_waitrequest <= '0';
		flagIsLocal <= '1';
		LCD_WR_n <= '1';
	elsif rising_edge(signalsClk) then
		case mainState is
			when IDLE =>
				LCD_WR_n <= '1';
			if sendToLCD = '1' then -- send
					mainState <= STATE1;
					LCD_WR_n <='0';
					flagIsLocal <= '0';
			elsif avalon_cs = '1' and avalon_wr = '1' and (avalon_address(2 downto 0) = "000" or avalon_address(2 downto 0) = "001") then
					mainState <= STATE1;
					avalon_waitrequest <= '1';
					LCD_WR_n <='0';
					flagIsLocal <= '1';
        end if;
			when STATE1 =>
				LCD_WR_n <='1';
				mainState <= STATE2;
				if flagIsLocal = '1' then
					avalon_waitrequest <= '1';
				end if;

			when STATE2 =>
				mainState <= IDLE;
				if flagIsLocal = '1' then
					avalon_waitrequest <= '0';
				end if;
				LCD_WR_n <='1';

		end case;
	end if;
end process smWrite;

smMem:process(signalsClk,nReset)
    variable counterTq : integer;
BEGIN
if nReset = '0' then
	mainStateDMA <= IDLEDMA;
	sendToLCD <= '0';
	master_read <= '0';
	master_address <= (others => '0');
	iRegDataFromDMA <= (others => '0');
	counterTq := 0;
elsif rising_edge(signalsClk) then
	case mainStateDMA is
		WHEN IDLEDMA =>
			master_read <= '0';
			if iRegDMA(0) = '1' then -- send
				mainStateDMA <= READMEM;
				master_address <= std_logic_vector( unsigned(iRegPointer) + counterTq);
			end if;
		WHEN READMEM =>
			sendToLCD <= '0';
			--master_address <= std_logic_vector( unsigned(iRegPointer) + counterTq);
			master_read <= '1';
			if ((counterTq <= unsigned(iRegSize))) then
				--if (memMaster_waitrequest = '1' AND master_waitrequest = '0') then -- detect when memory has finish
				if master_waitrequest = '0' then
					iRegDataFromDMA <= master_readdata;
					mainStateDMA <= WAITTOSEND;
					memMaster_waitrequest <= master_waitrequest;
				else
					memMaster_waitrequest <= master_waitrequest;
				end if;
			else
				mainStateDMA <= IDLEDMA;
				counterTq := 0;
			end if;
		WHEN SEND =>
			sendToLCD <= '1';
			mainStateDMA <= READMEM;
		WHEN WAITTOSEND =>
		  master_read <= '0';
			if mainState = IDLE then
				counterTq := counterTq + 2;
				mainStateDMA <= SEND;
				master_address <= std_logic_vector( unsigned(iRegPointer) + counterTq);
			end if;
	end case;
end if;
end process smMem;


LCD_RD <= '1'; --always 1 (disabled)

end architecture rtl;
