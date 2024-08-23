module AluControl(
    input [31:0] inst,
    input [1:0] ALUOP,
    output [3:0] out
);

    assign out = ALUOP == 2'b0 ? 4'b0010 : (ALUOP[0] ? 4'b0110 : (inst[30] ? 4'b0110 : (inst[14:12] == 3'b0 ? 4'b0010 : (inst[14:12] == 3'b111 ? 4'b0 : 4'b0001))));

endmodule