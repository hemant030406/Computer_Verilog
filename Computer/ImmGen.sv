module ImmGen(
    input [31:0] inst,
    output [63:0] imm
);

    wire [11:0] init_imm;

    assign init_imm = inst[6] ? {inst[31],inst[7],inst[30:25],inst[11:8]} :
                (inst[5] ? {inst[31:25],inst[11:7]} : inst[31:20]);

    assign imm = {{52{init_imm[11]}},init_imm};

endmodule