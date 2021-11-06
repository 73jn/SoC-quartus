	component configuration is
		port (
			clk_clk                         : in    std_logic                     := 'X';             -- clk
			lcd_controller_0_c_d_export     : out   std_logic;                                        -- export
			lcd_controller_0_cs_export      : out   std_logic;                                        -- export
			lcd_controller_0_data_export    : out   std_logic_vector(15 downto 0);                    -- export
			lcd_controller_0_im0_export     : out   std_logic;                                        -- export
			lcd_controller_0_rd_export      : out   std_logic;                                        -- export
			lcd_controller_0_res_export     : out   std_logic;                                        -- export
			lcd_controller_0_wr_export      : out   std_logic;                                        -- export
			led_port_export                 : inout std_logic_vector(31 downto 0) := (others => 'X'); -- export
			leds_external_connection_export : out   std_logic_vector(7 downto 0);                     -- export
			reset_reset_n                   : in    std_logic                     := 'X';             -- reset_n
			sdram_ctrl_wire_addr            : out   std_logic_vector(11 downto 0);                    -- addr
			sdram_ctrl_wire_ba              : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_ctrl_wire_cas_n           : out   std_logic;                                        -- cas_n
			sdram_ctrl_wire_cke             : out   std_logic;                                        -- cke
			sdram_ctrl_wire_cs_n            : out   std_logic;                                        -- cs_n
			sdram_ctrl_wire_dq              : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_ctrl_wire_dqm             : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ctrl_wire_ras_n           : out   std_logic;                                        -- ras_n
			sdram_ctrl_wire_we_n            : out   std_logic;                                        -- we_n
			sram_clk_clk                    : out   std_logic                                         -- clk
		);
	end component configuration;

	u0 : component configuration
		port map (
			clk_clk                         => CONNECTED_TO_clk_clk,                         --                      clk.clk
			lcd_controller_0_c_d_export     => CONNECTED_TO_lcd_controller_0_c_d_export,     --     lcd_controller_0_c_d.export
			lcd_controller_0_cs_export      => CONNECTED_TO_lcd_controller_0_cs_export,      --      lcd_controller_0_cs.export
			lcd_controller_0_data_export    => CONNECTED_TO_lcd_controller_0_data_export,    --    lcd_controller_0_data.export
			lcd_controller_0_im0_export     => CONNECTED_TO_lcd_controller_0_im0_export,     --     lcd_controller_0_im0.export
			lcd_controller_0_rd_export      => CONNECTED_TO_lcd_controller_0_rd_export,      --      lcd_controller_0_rd.export
			lcd_controller_0_res_export     => CONNECTED_TO_lcd_controller_0_res_export,     --     lcd_controller_0_res.export
			lcd_controller_0_wr_export      => CONNECTED_TO_lcd_controller_0_wr_export,      --      lcd_controller_0_wr.export
			led_port_export                 => CONNECTED_TO_led_port_export,                 --                 led_port.export
			leds_external_connection_export => CONNECTED_TO_leds_external_connection_export, -- leds_external_connection.export
			reset_reset_n                   => CONNECTED_TO_reset_reset_n,                   --                    reset.reset_n
			sdram_ctrl_wire_addr            => CONNECTED_TO_sdram_ctrl_wire_addr,            --          sdram_ctrl_wire.addr
			sdram_ctrl_wire_ba              => CONNECTED_TO_sdram_ctrl_wire_ba,              --                         .ba
			sdram_ctrl_wire_cas_n           => CONNECTED_TO_sdram_ctrl_wire_cas_n,           --                         .cas_n
			sdram_ctrl_wire_cke             => CONNECTED_TO_sdram_ctrl_wire_cke,             --                         .cke
			sdram_ctrl_wire_cs_n            => CONNECTED_TO_sdram_ctrl_wire_cs_n,            --                         .cs_n
			sdram_ctrl_wire_dq              => CONNECTED_TO_sdram_ctrl_wire_dq,              --                         .dq
			sdram_ctrl_wire_dqm             => CONNECTED_TO_sdram_ctrl_wire_dqm,             --                         .dqm
			sdram_ctrl_wire_ras_n           => CONNECTED_TO_sdram_ctrl_wire_ras_n,           --                         .ras_n
			sdram_ctrl_wire_we_n            => CONNECTED_TO_sdram_ctrl_wire_we_n,            --                         .we_n
			sram_clk_clk                    => CONNECTED_TO_sram_clk_clk                     --                 sram_clk.clk
		);

