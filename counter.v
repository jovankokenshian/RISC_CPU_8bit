`timescale 1ns / 1ps
//PC, program counter
module counter(pc_addr, clock, rst, en, wr, acall, data);
input clock, rst, en, wr, acall;
input [7:0] data;
output reg [7:0] pc_addr;

reg[7:0] temp [7:0];
reg[7:0] count;

always @(posedge clock or negedge rst) begin
	if(!rst) begin
		pc_addr <= 8'd0;
		count <= 8'd0;
	end
	else begin
		if(en) pc_addr <= pc_addr+1;
		else if(wr) begin
			if (acall) begin
				temp[count] <= pc_addr+1;
				count <= count+1;
			end
			pc_addr<=data;
		end
		else if(acall & !wr) begin
			pc_addr<= temp[count-1];
			count <= count-1;
		end
		else pc_addr <= pc_addr;
	end
end

endmodule