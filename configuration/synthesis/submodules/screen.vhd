library ieee;

use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 


ENTITY LCDPort IS 
	PORT( 
		-- Avalon interfaces 
		signalsClk : IN std_logic;
		nReset: IN std_logic;
		Address: IN std_logic_vector (2 DOWNTO 0);
		ChipSelect: IN std_logic;
		Write: IN std_logic;
		WriteData: IN std_logic_vector (15 DOWNTO 0);
		wait_request: OUT std_logic;
		-- external 
		LCD_CS: OUT std_logic;
		LCD_IM0: OUT std_logic;
		LCD_RES: OUT std_logic;
		LCD_C_D: OUT std_logic;
		LCD_DATA: OUT std_logic_vector (15 DOWNTO 0);
		LCD_WR: OUT std_logic;
		LCD_RD: OUT std_logic


	);
End LCDPort;

ARCHITECTURE comp OF LCDPort IS
signal iRegData: std_logic_vector (15 DOWNTO 0);
signal iRegControl:  std_logic_vector (15 DOWNTO 0);
signal iC_D: std_logic;

type smState is (
    IDLE, STATE1, STATE2
  );
signal mainState : smState;
BEGIN
pRegWr : process(signalsClk, nReset)
begin
	if nReset = '0' then
		iRegData <= (others => '0');-- Input by default
		iRegControl <= (others => '0');-- Input by default
		iC_D <= '0';-- Input by default
	elsif rising_edge(signalsClk) then
		if ChipSelect = '1' and Write = '1' then-- Write cycle
			case Address(2 downto 0) is
				when "000" => 
					iRegData <= WriteData ;
					iC_D <= '1';
				when "010" => 
					iRegData <= WriteData;
					iC_D <= '0';
				when "011" => iRegControl <= WriteData;
				when others => null;
			end case;
		end if;
	end if;
end process pRegWr;


LCD_C_D <= iC_D;
LCD_DATA <= iRegData;
-- Synchronize outputs
pSync:process(signalsClk, nReset)
begin
	if nReset = '0' then
		-- Control register mapping
		LCD_CS <= '0';
		LCD_IM0 <= '0';
		LCD_RES <= '0';
		--LCD_DATA <= (others => '0');
	elsif rising_edge(signalsClk) then
		-- Control register mapping
		LCD_CS <= iRegControl(0);
		LCD_IM0 <= iRegControl(1);
		LCD_RES <= iRegControl(2);


	end if;
end process pSync;

smWrite:process(signalsClk, nReset)
begin
	if nReset = '0' then
		mainState <= IDLE;
	elsif rising_edge(signalsClk) then
		case mainState is
			when IDLE =>	
				LCD_WR <= '1';
				if ChipSelect = '1' and Write = '1' and (Address(2 downto 0) = "000" or Address(2 downto 0) = "010") then
					mainState <= STATE1;
					wait_request <= '1';
					LCD_WR <='0';
                end if;
			when STATE1 =>
					LCD_WR <='1';
				mainState <= STATE2;
				wait_request <= '1';

			when STATE2 =>
				mainState <= IDLE;
				wait_request <= '0';
				LCD_WR <='1';
				
		end case;
	end if;
end process smWrite;

LCD_RD <= '1'; --always 1 (disabled)

END comp;

