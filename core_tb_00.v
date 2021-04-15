`timescale 1ps / 1ps
module core_tb_00  ; 
 
  reg clk,rst; 
  
  wire write_r, read_r, PC_en, PC_wr, acall, ac_ena, ram_ena, rom_ena;
wire ram_write, ram_read, rom_read, ad_sel;
  wire [1:0] fetch;
wire [7:0] data, addr;
wire [7:0] accum_out, alu_out;
wire [7:0] ir_ad, pc_ad;
wire [3:0] reg_ad;
wire [3:0] ins;
wire [3:0] state,next_state;
  core  DUT  ( clk, rst,write_r, read_r, PC_en, PC_wr, acall, ac_ena, ram_ena, rom_ena,ram_write, ram_read, rom_read, ad_sel, fetch, data,addr,accum_out,alu_out,ir_ad,pc_ad,reg_ad,ins,state); 



// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ps, End Time = 10 ns, Period = 100 ps
  initial
  begin
	  clk  = 1'b0  ;
	 # 150 ;
// 50 ps, single loop till start period.
   repeat(300)
   begin
	   clk  = 1'b1  ;
	  #50  clk  = 1'b0  ;
	  #50 ;
// 9950 ps, repeat pattern in loop.
   end
	  clk  = 1'b1  ;
	 # 50 ;
// dumped values till 10 ns
  end


// "Constant Pattern"
// Start Time = 0 ps, End Time = 10 ns, Period = 0 ps
  initial
  begin
	  rst  = 1'b0  ;
	 # 100;
	rst=1'b1;
	 # 9000 ;
// dumped values till 10 ns
  end

  initial
#20000 $stop;
endmodule
