module top(board_clk,btn,btn_SEND,LED_alert_2a,LED_alert_2b,clkin,clkout,dataout,datain,pll_rst,LED);

parameter mess_len = 10;
parameter crc_len = 4;
parameter address_1a_init_param = 5'b00000;
parameter address_1b_init_param = 5'b10000;
parameter poly_div_1a_param = 14'b10111000000000;
parameter poly_div_1b_param = 14'b10111000000000;
parameter nbr_states_1ab = 2;



input board_clk;
input btn;
input btn_SEND;
input wire clkin;
input wire [mess_len+crc_len-1+2:0] datain;
input wire pll_rst;

output wire LED_alert_2a;
output wire LED_alert_2b;
output wire clkout;
output wire [mess_len+crc_len-1+2:0] dataout;
output wire LED;



wire tick_START_1a;
wire tick_START_1b;
wire tick_WAIT_2a;
wire tick_WAIT_2b;
wire tick_CRC_1a;
wire tick_CRC_1b;
wire tick_NEXT_1a;
wire tick_NEXT_1b;
wire tick_NEXT_2a;
wire tick_NEXT_2b;
wire tick_SEND_1a;
wire tick_SEND_1b;
wire tick_WRITE_1a;
wire tick_WRITE_1b;
wire tick_IDLE_1a;
wire tick_IDLE_1b;
wire tick_IDLE_2a;
wire tick_IDLE_2b;
wire tick_CRC_2a;
wire tick_CRC_2b;
wire tick_LAST_2a;
wire tick_LAST_2b;
wire tick_READ_2a;
wire tick_READ_2b;
wire tx_clk;
wire DDIO_clk;
wire [nbr_states_1ab:0] state_reg_1a;
wire [nbr_states_1ab:0] state_next_1a;
wire [nbr_states_1ab:0] state_reg_1b;
wire [nbr_states_1ab:0] state_next_1b;
wire [nbr_states_1ab:0] state_reg_2a;
wire [nbr_states_1ab:0] state_next_2a;
wire [nbr_states_1ab:0] state_reg_2b;
wire [nbr_states_1ab:0] state_next_2b;
wire [4:0] address_1a;
wire [4:0] address_1b;
wire [4:0] address_2a;
wire [4:0] address_2b;
wire [mess_len+crc_len-1+2:0] q_1a;
wire [mess_len+crc_len-1+2:0] q_1b;
wire [mess_len+crc_len-1+2:0] q_2a;
wire [mess_len+crc_len-1+2:0] q_2b;
wire [mess_len+crc_len-1+2:0] dataout_2a;
wire [mess_len+crc_len-1+2:0] dataout_2b;
wire data_oe_1a;
wire clk_oe_1a;
wire data_oe_1b;
wire clk_oe_1b;
wire[mess_len+crc_len-1+2:0] CRC_data_1a;
wire[mess_len+crc_len-1+2:0] CRC_data_1b;
wire wren_1a;
wire wren_1b;
wire wren_2a;
wire wren_2b;

pll pll_inst (
		.refclk   (board_clk),   //  refclk.clk
		.rst      (),      //   reset.reset
		.outclk_0 (tx_clk), // outclk0.clk
		.outclk_1 (DDIO_clk), // outclk1.clk
		.locked   ()          // (terminated)
	);

debouncer debouncer_u
(
	.clk(tx_clk),
	.btn(btn),	
	.tick_a(tick_START_1a),
	.tick_b(tick_START_1b) 	
);

debouncer debouncer_SEND
(
	.clk(tx_clk),
	.btn(btn_SEND),	
	.tick_a(tick_SEND_1a),
	.tick_b(tick_SEND_1b) 	
);
	
FSM1 FSM_1a(
	
	.clk(tx_clk),
	.state_reg(state_reg_1a),
	.state_next(state_next_1a),
	.tick_START(tick_START_1a),
	.tick_CRC(tick_CRC_1a),
	.tick_NEXT(tick_NEXT_1a),
	.tick_SEND(tick_SEND_1a),
	.tick_WRITE(tick_WRITE_1a),
	.tick_IDLE(tick_IDLE_1a)
);

FSM1 FSM_1b(
	.clk(tx_clk),
	.state_reg(state_reg_1b),
	.state_next(state_next_1b),
	.tick_START(tick_START_1b),
	.tick_CRC(tick_CRC_1b),
	.tick_NEXT(tick_NEXT_1b),
	.tick_SEND(tick_SEND_1b),
	.tick_WRITE(tick_WRITE_1b),
	.tick_IDLE(tick_IDLE_1b)
);

FSM2 FSM_2a(
	.clk(tx_clk),
	.state_reg(state_reg_2a),
	.state_next(state_next_2a),
	.tick_CRC(tick_CRC_2a),
	.tick_NEXT(tick_NEXT_2a),
	.tick_LAST(tick_LAST_2a),
	.tick_READ(tick_READ_2a),
	.tick_WAIT(tick_WAIT_2a),
	.LED(LED)
);

FSM2 FSM_2b(
	.clk(tx_clk),
	.state_reg(state_reg_2b),
	.state_next(state_next_2b),
	.tick_CRC(tick_CRC_2b),
	.tick_NEXT(tick_NEXT_2b),
	.tick_LAST(tick_LAST_2b),
	.tick_READ(tick_READ_2b),
	.tick_WAIT(tick_WAIT_2b)
);

state_change1 state_change_1a(
	.clk(tx_clk),
	.state_next(state_next_1a),
	.state_reg(state_reg_1a)
);

state_change1 state_change_1b(
	.clk(tx_clk),
	.state_next(state_next_1b),
	.state_reg(state_reg_1b)
);

state_change2 state_change_2a(
	.clk(tx_clk),
	.state_next(state_next_2a),
	.state_reg(state_reg_2a)
);

state_change2 state_change_2b(
	.clk(tx_clk),
	.state_next(state_next_2b),
	.state_reg(state_reg_2b)
);

output_control1 #(
	.poly_div_param (poly_div_1a_param),
	.address_init_param (address_1a_init_param)
	)output_control_1a(
	.clk(tx_clk),
	.state_reg(state_reg_1a),
	.address(address_1a),
	.wren(wren_1a),
	.tick_CRC(tick_CRC_1a),
	.tick_NEXT(tick_NEXT_1a),
	.tick_WRITE(tick_WRITE_1a),
	.tick_IDLE(tick_IDLE_1a),
	.q(q_1a),
	.data_oe(data_oe_1a),
	.clk_oe(clk_oe_1a),
	.CRC_data(CRC_data_1a)
	
);

output_control1 #(
	.poly_div_param (poly_div_1b_param),
	.address_init_param (address_1b_init_param)
	)output_control_1b(
	.clk(tx_clk),
	.state_reg(state_reg_1b),
	.address(address_1b),
	.wren(wren_1b),
	.tick_CRC(tick_CRC_1b),
	.tick_NEXT(tick_NEXT_1b),
	.tick_WRITE(tick_WRITE_1b),
	.tick_IDLE(tick_IDLE_1b),
	.q(q_1b),
	.data_oe(data_oe_1b),
	.clk_oe(clk_oe_1b),
	.CRC_data(CRC_data_1b)
);

output_control2 #(
	.address_init_param (address_1a_init_param),
	.poly_div_param (poly_div_1a_param),
	.type_param (0)
	)output_control_2a(
	.clk(tx_clk),
	.state_reg(state_reg_2a),
	.address(address_2a),
	.wren(wren_2a),
	.tick_CRC(tick_CRC_2a),
	.tick_NEXT(tick_NEXT_2a),
	.tick_LAST(tick_LAST_2a),
	.LED_alert(LED_alert_2a),
	.tick_READ(tick_READ_2a),
	.q(q_2a),
	.dataout(dataout_2a),
	.tick_WAIT(tick_WAIT_2a)
);

output_control2 #(
	.address_init_param (address_1b_init_param),
	.poly_div_param (poly_div_1b_param),
	.type_param (1)
	)output_control_2b(
	.clk(tx_clk),
	.state_reg(state_reg_2b),
	.address(address_2b),
	.wren(wren_2b),
	.tick_CRC(tick_CRC_2b),
	.tick_NEXT(tick_NEXT_2b),
	.tick_LAST(tick_LAST_2b),
	.tick_READ(tick_READ_2b),
	.LED_alert(LED_alert_2b),
	.q(q_2b),
	.dataout(dataout_2b),
	.tick_WAIT(tick_WAIT_2b)
);

RAM1	RAM1_inst (
	.address_a (address_1a),
	.address_b (address_1b),
	.clock (tx_clk),
	.data_a (CRC_data_1a),
	.data_b (CRC_data_1b),
	.wren_a (wren_1a),
	.wren_b (wren_1b),
	.q_a (q_1a),
	.q_b (q_1b)
	);

RAM2	RAM2_inst (
	.address_a (address_2a),
	.address_b (address_2b),
	.clock (tx_clk),
	.data_a (dataout_2a),
	.data_b (dataout_2b),
	.wren_a (wren_2a),
	.wren_b (wren_2b),
	.q_a (q_2a),
	.q_b (q_2b)
	);
	
DDIO_OUT	DDIO_OUT_data (
	.datain_h (q_1a),
	.datain_l (q_1b),
	.oe (data_oe_1a),
	.outclock (tx_clk),
	.dataout (dataout)
	);

DDIO_OUT_clk	DDIO_OUT_clk (
	.datain_h (1'b1),
	.datain_l (1'b0),
	.oe (clk_oe_1a),
	.outclock (DDIO_clk),
	.dataout (clkout)
	);

DDIO_IN	DDIO_IN_inst (
	.datain (datain),
	.inclock (clkin),
	.dataout_h (dataout_2a),
	.dataout_l (dataout_2b)
	);
	
endmodule 