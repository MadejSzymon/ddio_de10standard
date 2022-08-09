`timescale 1ns/100ps
module tb ();

parameter nbr_states_1ab = 2;
parameter mess_len = 12;
parameter crc_len = 4;

reg board_clk;
reg btn;
reg btn_SEND;

wire tick_START_1a;
wire tick_START_1b;
wire tick_CRC_1a;
wire tick_CRC_1b;
wire tick_NEXT_1a;
wire tick_NEXT_1b;
wire tick_NEXT_2a;
wire tick_NEXT_2b;
wire tick_SEND_1a;
wire tick_SEND_1b;
wire tick_LAST_2a;
wire tick_LAST_2b;
wire tick_WRITE_1a;
wire tick_WRITE_1b;
wire tick_IDLE_1a;
wire tick_IDLE_1b;
wire tick_IDLE_2a;
wire tick_IDLE_2b;
wire tick_CRC_2a;
wire tick_CRC_2b;
wire tick_READ_2a;
wire tick_READ_2b;
wire tx_clk;
wire rx_clk;
wire DDIO_clk;
wire [nbr_states_1ab:0] state_reg_1a;
wire [nbr_states_1ab:0] state_next_1a;
wire [nbr_states_1ab:0] state_reg_1b;
wire [nbr_states_1ab:0] state_next_1b;	
wire [4:0] address_1a;
wire [4:0] address_1b;
wire [mess_len+crc_len-1:0] CRC_reg_1a;
wire [mess_len+crc_len-1:0] CRC_reg_1b;
wire [mess_len+crc_len-1:0] CRC_reg_2a;
wire [mess_len+crc_len-1:0] CRC_reg_2b;
wire [mess_len+crc_len-1:0] poly_div_1a;
wire [mess_len+crc_len-1:0] poly_div_1b;
wire [mess_len+crc_len-1:0] poly_div_2a;
wire [mess_len+crc_len-1:0] poly_div_2b;
wire [mess_len+crc_len-1+2:0] q_1a;
wire [mess_len+crc_len-1+2:0] q_1b;
wire [4:0] i_a;
wire [4:0] i_b;
wire [mess_len+crc_len-1+2:0] DDIO_data_1a;
wire [mess_len+crc_len-1+2:0] DDIO_data_1b;
wire data_oe_1a;
wire data_oe_1b;
wire clk_oe_1a;
wire clk_oe_1b;
wire [mess_len+crc_len-1+2:0] dataout_2a;
wire [mess_len+crc_len-1+2:0] dataout_2b;
wire clkout;
wire [mess_len+crc_len-1+2:0] dataout;
wire[mess_len+crc_len-1+2:0] CRC_data_1a;
wire[mess_len+crc_len-1+2:0] CRC_data_1b;
wire wren_1a;
wire wren_1b;
wire [nbr_states_1ab:0] state_reg_2a;
wire [nbr_states_1ab:0] state_next_2a;
wire [nbr_states_1ab:0] state_reg_2b;
wire [nbr_states_1ab:0] state_next_2b;
wire [4:0] address_2a;
wire [4:0] address_2b;
wire [mess_len+crc_len-1+2:0] q_2a;
wire [mess_len+crc_len-1+2:0] q_2b;
wire wren_2a;
wire wren_2b;
wire LED_alert_2a;
wire LED_alert_2b;
wire [5:0] counter_2a;
wire [5:0] counter_2b;


initial begin
	board_clk <= 0;
	btn <= 0;
	btn_SEND <= 0;
end

always begin
	#10;
	board_clk = !board_clk;
end

top top_DUT(
	.btn(btn),
	.board_clk(board_clk),
	.tick_START_1a(tick_START_1a),
	.tick_START_1b(tick_START_1b),
	.tx_clk(tx_clk),
	.rx_clk(rx_clk),
	.DDIO_clk(DDIO_clk),
	.state_reg_1a(state_reg_1a),
	.state_next_1a(state_next_1a),
	.state_reg_1b(state_reg_1b),
	.state_next_1b(state_next_1b),
	.state_reg_2a(state_reg_2a),
	.state_next_2a(state_next_2a),
	.state_reg_2b(state_reg_2b),
	.state_next_2b(state_next_2b),
	.address_1a(address_1a),
	.address_1b(address_1b),
	.address_2a(address_2a),
	.address_2b(address_2b),
	.tick_CRC_1a(tick_CRC_1a),
	.tick_CRC_1b(tick_CRC_1b),
	.tick_READ_2a(tick_READ_2a),
	.tick_READ_2b(tick_READ_2b),
	.tick_NEXT_1a(tick_NEXT_1a),
	.tick_NEXT_1b(tick_NEXT_1b),
	.tick_NEXT_2a(tick_NEXT_2a),
	.tick_NEXT_2b(tick_NEXT_2b),
	.tick_SEND_1a(tick_SEND_1a),
	.tick_SEND_1b(tick_SEND_1b),
	.tick_CRC_2a(tick_CRC_2a),
	.tick_CRC_2b(tick_CRC_2b),
	.tick_LAST_2a(tick_LAST_2a),
	.tick_LAST_2b(tick_LAST_2b),
	.CRC_reg_1a(CRC_reg_1a),
	.CRC_reg_1b(CRC_reg_1b),
	.CRC_reg_2a(CRC_reg_2a),
	.CRC_reg_2b(CRC_reg_2b),
	.poly_div_1a(poly_div_1a),
	.poly_div_1b(poly_div_1b),
	.poly_div_2a(poly_div_2a),
	.poly_div_2b(poly_div_2b),
	.q_1a(q_1a),
	.q_1b(q_1b),
	.q_2a(q_2a),
	.q_2b(q_2b),
	.i_a(i_a),
	.i_b(i_b),
	.DDIO_data_1a(DDIO_data_1a),
	.DDIO_data_1b(DDIO_data_1b),
	.data_oe_1a(data_oe_1a),
	.data_oe_1b(data_oe_1b),
	.clk_oe_1a(clk_oe_1a),
	.clk_oe_1b(clk_oe_1b),
	.clkout(clkout),
	.dataout_2a(dataout_2a),
	.dataout_2b(dataout_2b),
	.dataout(dataout),
	.tick_WRITE_1a(tick_WRITE_1a),
	.tick_WRITE_1b(tick_WRITE_1b),
	.tick_IDLE_1a(tick_IDLE_1a),
	.tick_IDLE_1b(tick_IDLE_1b),
	.tick_IDLE_2a(tick_IDLE_2a),
	.tick_IDLE_2b(tick_IDLE_2b),
	.CRC_data_1a(CRC_data_1a),
	.CRC_data_1b(CRC_data_1b),
	.wren_1a(wren_1a),
	.wren_1b(wren_1b),
	.wren_2a(wren_2a),
	.wren_2b(wren_2b),
	.btn_SEND(btn_SEND),
	.LED_alert_2a(LED_alert_2a),
	.LED_alert_2b(LED_alert_2b),
	.counter_2a(counter_2a),
	.counter_2b(counter_2b)
	
);

initial
begin
	#50;
	btn = 1;
	#40;
	btn = 0;
	#13000;
	btn_SEND = 1;
	#40;
	btn_SEND = 0;
	
	#25000;
	#50;
	btn = 1;
	#40;
	btn = 0;
	#13000;
	btn_SEND = 1;
	#40;
	btn_SEND = 0;
	
end
endmodule 