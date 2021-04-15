`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module reg_32(in, data, write, read, addr, clk);
input write, read, clk;
input [7:0] in;
input [3:0] addr; //addr should be reduced to 4 bits width, not 8 bits width.
//input [3:0] addr;

output [7:0] data;

reg [7:0] R[31:0]; //32Byte
wire [3:0] r_addr;

assign r_addr = addr;
assign data = (read)? R[r_addr]:8'hzz;	//read enable

always @(posedge clk) begin				//write, clk posedge
	if(write)	R[r_addr] <= in; 
end

endmodule
