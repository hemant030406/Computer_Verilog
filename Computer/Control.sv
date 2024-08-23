module Control(
    input [31:0] inst,
    output Branch,MemRead,MemWrite,MemtoReg,,ALUsrc,RegWrite,
    output[1:0] ALUOp
);

    assign Branch = inst[6:0] == 7'b1100011;
    assign ALUOp[0] = inst[6:0] == 7'b1100011;
    assign ALUOp[1] = inst[6:0] == 7'b0110011;
    assign ALUsrc = (inst[6:0] == 7'b0000011 || inst[6:0] == 7'b0100011);
    assign MemtoReg = (inst[6:0] == 7'b0100011 || inst[6:0] == 7'b1100011) ? 1'bx : (inst[6:0] == 7'b0000011);
    assign MemRead = inst[6:0] == 7'b0000011;
    assign MemWrite = inst[6:0] == 7'b0100011;
    assign RegWrite = (inst[6:0] == 7'b0110011 || inst[6:0] == 7'b0000011);

endmodule