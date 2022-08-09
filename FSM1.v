
module FSM1 (clk,state_reg,state_next,tick_START,tick_CRC,tick_NEXT,tick_SEND,tick_WRITE,tick_IDLE);

parameter nbr_states = 2;

//INPUTS:
input clk;
input [nbr_states:0] state_reg;
input tick_START;
input tick_CRC;
input tick_NEXT;
input tick_SEND;
input tick_WRITE;
input tick_IDLE;

//OUTPUTS:
output reg [nbr_states:0] state_next;

//state_next - REGISTER THAT STORES VALUE OF THE STATE THAT WILL BE AFTER ONE CLOCK CYCLE FROM "NOW"

initial begin
	state_next <= 0;
end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @(posedge clk) begin 
	 case (state_reg)
		  0 : begin
		  
				if (tick_START) begin
					state_next <= 1;
					
				end
				else if (tick_SEND) begin
					state_next <= 4;
				end
				else begin
					state_next <= 0;
				end
		  end
		  1 : begin
				if (tick_CRC) begin
					state_next <= 2;
				end
				else begin
					state_next <= 1;
				end
		  end
		  2 : begin
			  if (tick_WRITE) begin
					state_next <= 3;
				end
				else begin
					state_next <= 2;
				end
		  end
		  3 : begin
				if (tick_NEXT) begin
					state_next <= 1;
				end
				else if (tick_IDLE) begin
					state_next <= 0;
				end
				else begin
					state_next <= 3;
				end
			end
		  4 : begin
		  
				if (tick_IDLE) begin
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