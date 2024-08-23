`include "ALU.sv"
`include "AluControl.sv"
`include "Control.sv"
`include "CPU.sv"
`include "RAM.sv"
`include "ImmGen.sv"
`include "ROM.sv"
`include "PC.sv"
`include "RegFile.sv"

module tb();
  reg clk,reset;
  
  CPU cpu(reset,clk);

initial begin
  clk = 1; reset = 1;
  #3 reset = 0;
  forever begin
       #10 clk = !clk;
  end
end
  
endmodule