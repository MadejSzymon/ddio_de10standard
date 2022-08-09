
module FSM2 (clk,state_reg,state_next,tick_CRC,tick_NEXT,tick_LAST,tick_READ,tick_WAIT,LED);

parameter nbr_states = 2;


//INPUTS:
input clk;
input [nbr_states:0] state_reg;
input tick_CRC;
input tick_NEXT;
input tick_LAST;
input tick_READ;
input tick_WAIT;
//OUTPUTS:
output reg [nbr_states:0] state_next;
output reg LED;

//state_next - REGISTER THAT STORES VALUE OF THE STATE THAT WILL BE AFTER ONE CLOCK CYCLE FROM "NOW"

initial begin
	state_next <= 0;
	LED <= 0;
end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @(posedge clk) begin 
	 case (state_reg)
		  0 : begin
				if (tick_READ) begin
					state_next <= 1;
					LED <= 1;
				end
				else begin
					state_next <= 0;
				end
		  end
		  1 : begin
				if (tick_WAIT) begin
					state_next <= 2;
				end
				else begin
					state_next <= 1;
				end
		  end
		  2 : begin
			  if (tick_CRC) begin
					state_next <= 3;
				end
				else begin
					state_next <= 2;
				end
		  end
		  3 : begin
				if (tick_NEXT) begin
					state_next <= 4;
				end
				else begin
					state_next <= 3;
				end
			end
			4: begin
				if (tick_CRC) begin
					state_next <= 3;
				end
				else if(tick_LAST) begin
					state_next <= 0;
				end
				else begin
					state_next <= 4;
				end
			end
			default: begin
					state_next = 0;
			end
	 endcase
end 

endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////