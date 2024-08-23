module ROM (
    input [63:0] program_counter_input,
    input clock,
    output reg [31:0] instruction_output
);

    reg [7:0] instruction_memory [2**14 - 1];
    reg [31:0] line_instruction;

    integer file_handle, num_instructions = 0;

    initial begin
      // To check for "add" instruction. "add x1,x1,x2"
        file_handle = $fopen("../Tests/Textfiles/add.txt","r");

      // To check for "sub" instruction. "sub x1,x1,x2"
      // file_handle = $fopen("../Tests/Textfiles/sub.txt","r");

      // To check for "sd" instruction. "sd x1,0(x0)"
      // file_handle = $fopen("../Tests/Textfiles/sd.txt","r");

      // To check for "ld" instruction. "ld x1,0(x0)"
      // file_handle = $fopen("../Tests/Textfiles/ld.txt","r");

      // To check for "beq" instruction. Adds 37 + (10 + 9 + .... + 1) through a loop.
      // file_handle = $fopen("../Tests/Textfiles/beq.txt","r");
      
        if (file_handle == 0) begin
            $display("Couldn't read file!");
            $finish;
        end

        while (!$feof(file_handle)) begin
            $fscanf(file_handle, "%b\n", line_instruction);
            instruction_memory[num_instructions] = line_instruction[7:0];
            instruction_memory[num_instructions + 1] = line_instruction[15:8];
            instruction_memory[num_instructions + 2] = line_instruction[23:16];
            instruction_memory[num_instructions + 3] = line_instruction[31:24];
            num_instructions = num_instructions + 4;
        end
        $display("File scan completed.");
    end

  assign instruction_output = {instruction_memory[program_counter_input[13:0] + 3],instruction_memory[program_counter_input[13:0] + 2],instruction_memory[program_counter_input[13:0] + 1],instruction_memory[program_counter_input[13:0]]};

    always @(posedge clock) begin
      if (program_counter_input[15:2] >= num_instructions/4 - 1) #5 $finish;
    end

endmodule
