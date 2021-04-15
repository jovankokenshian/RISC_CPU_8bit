`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module alu(alu_out, alu_in, accum, op);//  arithmetic logic unit
    // to perform arithmetic and logic operations.
input [3:0] op;
input [7:0] alu_in,accum;
output reg [7:0] alu_out;

parameter 	NOP=4'b0000, // no operation
				LDO=4'b0001,	// load ROM to register
				LDA=4'b0010, // load RAM to register
				STO=4'b0011, // Store ALU results to RAM
				PRE=4'b0100, // Prefetch Data from Address
				JMP=4'b0101, // Jump to Spef Address
				ADD=4'b0110, // Adds the contents of the memory address or integer to the accumulator
				SUB=4'b0111, // Sub contents
				LAND=4'b1000, // AND contents
				LOR=4'b1001, // OR contents
				LNOT=4'b1010, //NOT Contents
				INC =4'b1011, //Increment ACC
				ACL =4'b1100, //ACALL to spef Address
				RET=4'b1101, // Return to prev Address
				LDM=4'b1110, // Update Register Value
				HLT=4'b1111; // Halt

always @(*) begin
		casez(op)
		NOP:	alu_out = accum;
		HLT:	alu_out = accum;
		LDO:	alu_out = alu_in;
		LDA:	alu_out = alu_in;
		STO:	alu_out = accum;
		PRE:	alu_out = alu_in;
		JMP:  alu_out = alu_in;
		ADD:	alu_out = accum+alu_in;
		SUB:	alu_out = accum-alu_in;
		LAND:	alu_out = accum&alu_in;
		LOR:	alu_out = accum|alu_in;
		LNOT: alu_out = ~(accum);
		INC : alu_out = accum+8'd1;
		ACL:  alu_out = alu_in;
		LDM:	alu_out = accum;
		default:	alu_out = 8'bzzzz_zzzz;
		endcase
end
			 
			
endmodule
