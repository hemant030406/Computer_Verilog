module RegFile (
    input [4:0] source_reg1, source_reg2, dest_reg,
    input [63:0] data_in,
    input reg_write, clock,
    output reg [63:0] out_data1, out_data2
);

    reg [63:0] registers [32];

    // Initialize register file
    initial begin
        registers[0] = 0;
        registers[1] = 37;
        registers[2] = 10;
        registers[7] = -1;
    end 

    // Assign read data outputs
    assign out_data1 = registers[source_reg1];
    assign out_data2 = registers[source_reg2];

    // Clocked process for write operation
    always @(posedge clock) begin 
        if (dest_reg != 5'd0) begin
            if (reg_write) begin
                registers[dest_reg] = data_in;
            end
        end else begin
            registers[dest_reg] = 64'b0;
        end
    end

    // Display register contents for debugging
    always @(posedge clock) begin
        for (int i = 0; i < 32; i = i + 1) begin
          $display("x%d: %d", i, registers[i]);
        end
        $display("data_in: %h", data_in);
        $display("dest_reg: %d", dest_reg);
        $display("reg_write: %d", reg_write);
    end

endmodule
