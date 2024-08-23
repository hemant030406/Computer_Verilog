module ALU(
    input [63:0] in1,in2,
    input [3:0] aluControl,
    output [63:0] out,
    output zero
);

    assign out = (aluControl == 4'b0) ? (in1 & in2) : 
            ((aluControl == 4'b0001) ? (in1 | in2) :
            ((aluControl == 4'b0010) ? (in1 + in2) : (in1 - in2)));

    assign zero = out == 0;


endmodule