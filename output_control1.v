
module output_control1 (clk,state_reg,address,tick_CRC,tick_NEXT,q,
data_oe,clk_oe,wren,CRC_data,tick_WRITE,tick_IDLE);

parameter nbr_states = 2;
parameter mess_len = 10;
parameter crc_len = 4;
parameter poly_div_param;
parameter address_init_param;


//INPUTS:
input clk;
input [nbr_states:0] state_reg;
input [mess_len+crc_len-1+2:0] q;


//OUTPUTS:
output reg [4:0] address;
output reg wren;
output reg tick_CRC;
output reg tick_NEXT;
output reg tick_WRITE;
output reg tick_IDLE;
reg [mess_len+crc_len-1:0] CRC_reg;
reg [mess_len+crc_len-1:0] poly_div;
output reg [mess_len+crc_len-1+2:0] CRC_data;
integer i;
output reg data_oe;
output reg clk_oe;

//OTHER PARAMETER, NETS AND REGISTERS
reg [5:0] counter;
//integer i = mess_len+crc_len; 
initial begin
	address <= address_init_param;
	poly_div = poly_div_param;
	counter <= 0;
	tick_CRC <= 0;
	tick_NEXT <= 0;
	tick_WRITE <= 0;
	tick_IDLE <= 0;
	CRC_reg <= 0;
	i = 14;
	data_oe <= 0;
	clk_oe <= 0;
	wren <= 0;
	CRC_data <= 0;

end


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
always @( posedge clk) begin 
    case (state_reg)  
        0 : begin
				address <= address_init_param;
				poly_div = poly_div_param;
				counter <= 0;
				tick_CRC <= 0;
				tick_NEXT <= 0;
				tick_WRITE <= 0;
				tick_IDLE <= 0;
				CRC_reg <= 0;
				i = 14;
				data_oe <= 0;
				clk_oe <= 0;
				wren <= 0;
				CRC_data <= 0;
         end
        1 : begin
				wren <= 0;
				tick_NEXT <= 0;
				if (counter[1:0] == 2'b01 && counter != 1) begin
					address <= address + 5'b00001;
					tick_CRC <= 1;
				end
				counter <= counter + 6'b000001;
				if (counter == 0) begin
					tick_CRC <= 1;
				end
         end
        2 : begin
				tick_CRC <= 0;
				
				if (i == mess_len+crc_len) begin	
					CRC_reg <= {q[13:4],4'b0000};
					i = i - 1;
				end
				else if(CRC_reg[i]==0 && i != crc_len-1) begin
					poly_div <= poly_div >> 1;
					i=i-1;
				end
				else if (i != crc_len-1)begin
					CRC_reg <= CRC_reg ^ poly_div;
				end
				
				if(i == crc_len-1) begin
					poly_div <= poly_div_param;
					tick_WRITE <= 1;
				end
			end
		  3 : begin
				i = 14;
				tick_WRITE <= 0;
				wren <= 1;
				if (address == address_init_param) begin
					CRC_data <= {2'b01,q[13:4],CRC_reg[3:0]};
					tick_NEXT <= 1;
				end
				else if (address == address_init_param + mess_len + crc_len - 1 ) begin
					CRC_data <= {2'b11,q[13:4],CRC_reg[3:0]};
					tick_IDLE <= 1;
				end
				else begin
					CRC_data <= {2'b10,q[13:4],CRC_reg[3:0]};
					tick_NEXT <= 1;
				end
		  end
		 4 : begin
				data_oe <= 1;
				clk_oe <= 1;
				if (counter > 0 && counter < mess_len + crc_len) begin
					address <= address + 5'b00001;
				end
				counter <= counter + 6'b000001;
				
				if (counter ==  mess_len + crc_len + 30) begin
					tick_IDLE <= 1;
				end
		 end
		  default: begin
			   
		  end
    endcase
end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////