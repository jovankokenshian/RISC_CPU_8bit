`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module rom(data, addr, read, ena);
input read, ena;
input [7:0] addr;
output [7:0] data;
 
reg [7:0] memory[255:0];

//NOP=4'b0000, // no operation
//LDO=4'b0001,	// load ROM to register
//LDA=4'b0010, // load RAM to register
//STO=4'b0011, // Store ALU results to RAM
//PRE=4'b0100, // Prefetch Data from Address
//JMP=4'b0101, // Jump to spef Add
//ADD=4'b0110, // Adds the contents of the memory address or integer to the accumulator
//SUB=4'b0111, // Sub contents
//LAND=4'b1000, // AND contents
//LOR=4'b1001, // OR contents
//LNOT=4'b1010, //NOT Contents
//INC =4'b1011, //Increment ACC
//ACL =4'b1100, //ACALL to spef Address
//RET=4'b1101, // Return to prev Address
//LDM=4'b1110, // Update Register Value
//HLT=4'b1111; // Halt


// note: Decimal number in the bracket
initial begin
	memory[0]  = 8'b0000_0000;	//NOP	
	// [ins] [target_reg_addr] [from_rom_addr]
	memory[1]  = 8'b0001_0001;	//LDO s1
	memory[2]  = 8'b0100_0001;	//rom(65)	//rom[65] -> reg[1]
	memory[3]  = 8'b0001_0010;	//LDO s2
	memory[4]  = 8'b0100_0010;	//rom(66)
	memory[5]  = 8'b0001_0011;	//LDO s3
	memory[6]  = 8'b0100_0011;	//rom(67)
	memory[7]  = 8'b0001_0100; //LDO s4
	memory[8]  = 8'b0100_0100;	//rom(68)
	memory[9]  = 8'b0001_0101; //LDO s5
	memory[10] = 8'b0100_0101;	//rom(69)

	memory[11] = 8'b0100_0001;	//PRE s1
	memory[12] = 8'b0110_0010;	//ADD s2 //Expected Value 37+89 = 126
	memory[13] = 8'b1110_0001;	//LDM s1

   memory[14] = 8'b0101_0000; //JUMP
	memory[15] = 8'b0001_0111; //to mem 23 (if fail Halt)
	memory[16] = 8'b1111_0000; //HLT

	memory[23] = 8'b0011_0001;	//STO s1
	memory[24] = 8'b0000_0001;	//ram(1) //value 126	
	memory[25] = 8'b0010_0010;	//LDA s2
	memory[26] = 8'b0000_0001;	//ram(1) 
	
	memory[27] = 8'b0100_0011;	//PRE s3
	memory[28] = 8'b0111_0010;	//SUB s2 //Expected Value 53 - 126 = -73
	memory[29] = 8'b1110_0011;	//LDM s3
	memory[30] = 8'b0011_0011;	//STO s3
	memory[31] = 8'b0000_0010;	//ram(2) //value -73
	
	memory[32] = 8'b0100_0100;	//PRE s4
	memory[33] = 8'b1000_0010;	//AND s2 //Expected Value 43 & 126 = 42
	memory[34] = 8'b1110_0100; //LDM S4
	memory[35] = 8'b0011_0100;	//STO s4
	memory[36] = 8'b0000_0011;	//ram(3) //value 42
	
	memory[37] = 8'b0100_0101;	//PRE s5
	memory[38] = 8'b1001_0010;	//OR s2 //Expected Value 21 | 126 = 127
	memory[39] = 8'b1110_0101; //LDM S5
	memory[40] = 8'b0011_0101;	//STO s5
	memory[41] = 8'b0000_0100;	//ram(4) //value 127
	
	memory[42] = 8'b0010_0001; //LDA s1
	memory[43] = 8'b0000_0011; //ram(3)
	
	memory[44] = 8'b0010_0010; //LDA s2
	memory[45] = 8'b0000_0100; //ram(4) 
	
	memory[46] = 8'b1100_0000; //ACALL to 50
	memory[47] = 8'd50;
	
	memory[50] = 8'b0100_0001; //PRE s1 //Expected Val 42
	memory[51] = 8'b0111_0010; //SUB S2 //Expected Value 42-127 = -85
	memory[52] = 8'b1010_0000; //LNOT //Expected Value 84
	memory[53] = 8'b1000_0001; //84 AND 42 = 0  
	memory[54] = 8'b1011_0000; //Increment by 1 //Expected Val 1
	memory[55] = 8'b1101_0000; //RET to 48

	memory[48] = 8'b1111_0000;	//HLT
	
	memory[65] = 8'b001_00101;	//37
	memory[66] = 8'b010_11001;	//89
	memory[67] = 8'b001_10101;	//53
	memory[68] = 8'b001_01011;	//43
	memory[69] = 8'b000_10101;	//21
end


assign data = (read&&ena)? memory[addr]:8'hzz;	

endmodule
