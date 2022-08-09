
module state_change2 (clk,state_next,state_reg);

parameter nbr_states = 2;

//INPUTS:
input clk;
input [nbr_states:0] state_next;
//clk - WIRE FROM (PLL) 
//state_next - BUS OF WIRES FROM (FSM) 

//OUTPUTS:
output reg [nbr_states:0] state_reg;
//state_reg - REGISTER THAT STORES VALUE OF CURRENT STATE

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
initial
	state_reg = 0;

always @(posedge clk) begin
        state_reg <= state_next;
 end
 
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////