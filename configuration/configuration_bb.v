
module configuration (
	clk_clk,
	dma_lcd_0_cs_n_export,
	dma_lcd_0_d_c_n_export,
	dma_lcd_0_data_export,
	dma_lcd_0_end_of_transaction_irq_export,
	dma_lcd_0_im0_export,
	dma_lcd_0_rd_export,
	dma_lcd_0_res_export,
	dma_lcd_0_wr_n_export,
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
	output		dma_lcd_0_cs_n_export;
	output		dma_lcd_0_d_c_n_export;
	output	[15:0]	dma_lcd_0_data_export;
	output		dma_lcd_0_end_of_transaction_irq_export;
	output		dma_lcd_0_im0_export;
	output		dma_lcd_0_rd_export;
	output		dma_lcd_0_res_export;
	output		dma_lcd_0_wr_n_export;
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
