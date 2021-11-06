
module configuration (
	clk_clk,
	lcd_controller_0_c_d_export,
	lcd_controller_0_cs_export,
	lcd_controller_0_data_export,
	lcd_controller_0_im0_export,
	lcd_controller_0_rd_export,
	lcd_controller_0_res_export,
	lcd_controller_0_wr_export,
	led_port_export,
	leds_external_connection_export,
	reset_reset_n,
	sdram_ctrl_wire_addr,
	sdram_ctrl_wire_ba,
	sdram_ctrl_wire_cas_n,
	sdram_ctrl_wire_cke,
	sdram_ctrl_wire_cs_n,
	sdram_ctrl_wire_dq,
	sdram_ctrl_wire_dqm,
	sdram_ctrl_wire_ras_n,
	sdram_ctrl_wire_we_n,
	sram_clk_clk);	

	input		clk_clk;
	output		lcd_controller_0_c_d_export;
	output		lcd_controller_0_cs_export;
	output	[15:0]	lcd_controller_0_data_export;
	output		lcd_controller_0_im0_export;
	output		lcd_controller_0_rd_export;
	output		lcd_controller_0_res_export;
	output		lcd_controller_0_wr_export;
	inout	[31:0]	led_port_export;
	output	[7:0]	leds_external_connection_export;
	input		reset_reset_n;
	output	[11:0]	sdram_ctrl_wire_addr;
	output	[1:0]	sdram_ctrl_wire_ba;
	output		sdram_ctrl_wire_cas_n;
	output		sdram_ctrl_wire_cke;
	output		sdram_ctrl_wire_cs_n;
	inout	[15:0]	sdram_ctrl_wire_dq;
	output	[1:0]	sdram_ctrl_wire_dqm;
	output		sdram_ctrl_wire_ras_n;
	output		sdram_ctrl_wire_we_n;
	output		sram_clk_clk;
endmodule
