module PC(
    input [63:0] addr,
    input reset,ld,clk,
    output reg [63:0] out
);

    always @(posedge clk) begin
        out = reset ? 64'b0 : (ld ? addr : out + 4);
    end

endmodule