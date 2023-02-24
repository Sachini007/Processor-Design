`timescale 1ns/1ps

module ALU_TB ();
    reg [2:0] operation;
    reg [23:0] alu_in1;
    reg [23:0] alu_in2;
    wire [23:0] alu_out;
    wire neg_flag;

    ALU dut(.operation(operation), .alu_in1(alu_in1), .alu_in2(alu_in2),
    .alu_out(alu_out), .neg_flag(neg_flag));

    //Test Case 01
    initial begin
        operation = 3'b000; alu_in1 = 24'd10; alu_in2 = 24'd10;
        #20;
        operation = 3'b001; alu_in1 = 24'd20; alu_in2 = 24'd84;
        #20;
        operation = 3'b010; alu_in1 = 24'd32;
        #20;
        operation = 3'b011; alu_in1 = 24'd2;
        #20;
        operation = 3'b100; alu_in1 = 24'd2; alu_in2 = 24'd16;
        #20;
        operation = 3'b101; alu_in1 = 24'd16;
        #20;
        operation = 3'b110;
        #20;
        operation = 3'b111;
        #20;
        $finish; 
    end


endmodule //ALU_TB