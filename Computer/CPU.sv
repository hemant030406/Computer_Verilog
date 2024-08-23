module CPU(
    input reset,clk
);

  logic [63:0] addr,reg_data1,reg_data2,aluin2,Memout,pcout,aluout,immOut,writeRegData;
    logic pc_load,alu0,branch,MemRead,MemWrite,MemtoReg,ALUsrc,RegWrite;
    logic [3:0] alucont;
    logic [31:0] inst;
    logic [1:0] aluop;
    logic [4:0]  rs1,rs2,rd;

    PC pc(addr,reset,pc_load,clk,pcout);

    ALU alu(reg_data1,aluin2,alucont,aluout,alu0);

    AluControl aluControl(inst,aluop,alucont);

    Control cntrl(inst,branch,MemRead,MemWrite,MemtoReg,ALUsrc,RegWrite,aluop);

    RAM ram(aluout,reg_data2,MemWrite,MemRead,clk,Memout);

    ImmGen imm(inst,immOut);

    ROM rom(pcout,clk,inst);

    RegFile regf(rs1,rs2,rd,writeRegData,RegWrite,clk,reg_data1,reg_data2);

    assign aluin2 = ALUsrc ? immOut : reg_data2;

    assign addr = pcout + {immOut[62:0],1'b0};
    assign pc_load = branch && alu0;

    assign writeRegData = MemtoReg ? Memout : aluout;

    assign rs1 = inst[19:15];
    assign rs2 = inst[24:20];
    assign rd = inst[11:7];

endmodule