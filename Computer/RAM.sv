module RAM (
    input [63:0] memory_address,
    input [63:0] write_data,
    input memory_write, memory_read, clock,
    output [63:0] read_data
);

  reg [7:0] memory [2**50 - 1];
  integer i;
  
  initial begin
    memory[0] = 12;
    for (i = 1; i < 8; i = i + 1) begin
      memory[i] = 0;
    end
  end

    always @(posedge clock) begin
        if (memory_write) begin
            for (int i = 0; i < 8; i = i + 1) begin
              memory[memory_address[49:0] + i] = write_data[i*8 +: 8];
            end
        end
      $display("mem: %d",memory[0]);
    end
    
    assign read_data = memory_read ? { memory[memory_address[49:0] + 7], memory[memory_address[49:0] + 6], memory[memory_address[49:0] + 5], memory[memory_address[49:0] + 4], memory[memory_address[49:0] + 3], memory[memory_address[49:0] + 2], memory[memory_address[49:0] + 1], memory[memory_address[49:0]] } : 64'bx;


endmodule