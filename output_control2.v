
module output_control2 (clk,state_reg,tick_CRC,tick_NEXT,address,wren,LED_alert,q,
tick_LAST,dataout,tick_READ,tick_WAIT);

parameter nbr_states = 2;
parameter mess_len = 10;
parameter crc_len = 4;
parameter address_init_param;
parameter type_param;
parameter poly_div_param;
//INPUTS:
input clk;
input [nbr_states:0] state_reg;
input [mess_len+crc_len-1+2:0] q;
input [mess_len+crc_len-1+2:0] dataout;

//OUTPUTS:
output reg tick_CRC;
output reg tick_NEXT;
output reg tick_LAST;
output reg tick_READ;
output reg tick_WAIT;
output reg [4:0] address;
output reg wren;
output reg LED_alert;
reg [mess_len+crc_len-1:0] poly_div;
reg [mess_len+crc_len-1:0] CRC_reg;
//OTHER PARAMETER, NETS AND REGISTERS
reg [5:0] counter;
integer i = 14;
initial begin
	counter <= 0;
	tick_CRC <= 0;
	tick_NEXT <= 0;
	address <= address_init_param;
	wren <= 0;
	LED_alert <= 0;
	poly_div <= poly_div_param;
	CRC_reg <= 0;
	tick_LAST <= 0;
	tick_READ <= 0;
	tick_WAIT <= 0;
end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @( posedge clk) begin 
    case (state_reg)  
        0 : begin
				counter <= 0;
				tick_CRC <= 0;
				tick_NEXT <= 0;
				address <= address_init_param;
				wren <= 0;
				poly_div <= poly_div_param;
				CRC_reg <= 0;
				i = 14;
				tick_LAST <= 0;
				if (dataout[15:14] == 2'b01) begin
					tick_READ <= 1;
					wren <= 1;
				end
         end
        1 : begin
				tick_READ <= 0;
				if (counter >= 0+type_param && counter < mess_len + crc_len+type_param-1) begin
					address <= address + 5'b00001;
				end
				if (dataout[15:14] == 2'b11) begin
					tick_WAIT <= 1;
					counter <= 0;
					wren <= 0;
				end
				else begin
					counter <= counter + 6'b000001;
				end
				
         end
        2 : begin
				tick_WAIT <= 0;
				address <= address_init_param;
				counter <= counter + 6'b000001;
				if (counter == 5) begin 
					tick_CRC <= 1;
				end
			end
		  3 : begin
				tick_CRC <= 0;
				
				if (i == 14) begin	
					CRC_reg <= q[13:0];
					i = i - 1;
				end
				else if(CRC_reg[i]==0) begin
					poly_div <= poly_div >> 1;
					i=i-1;
				end
				else begin
					CRC_reg <= CRC_reg ^ poly_div;
				end
				
				if(poly_div[13:4] == 0) begin
					tick_NEXT <= 1;
					if (CRC_reg != 0) begin
						LED_alert <= 1;
					end
				end
				
		  end
		  4 : begin
				poly_div <= poly_div_param;
				counter <= counter + 6'b000001;
				i = 14;
				tick_NEXT <= 0;
				if (counter[1:0] == 2'b01) begin
					address <= address + 5'b00001;
					if (q[15:14] == 2'b11) begin
						tick_LAST <= 1;
					end
					else begin	
						tick_CRC <= 1;
					end
				end
		  end
		  default: begin
			   
		  end
    endcase
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////