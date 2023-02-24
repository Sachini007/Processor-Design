`timescale 1ns/1ps

module PC_TB ();
    reg clk, write, PC_INC;
    reg [23:0] ins_in;
    wire [23:0] ins_out;

    PC dut(.clk(clk), .write(write), .PC_INC(PC_INC),
    .ins_in(ins_in), .ins_out(ins_out));

    //Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

    //Test Case 01
    initial begin
        write = 1; PC_INC = 0; ins_in = 24'd100;
        #50;
        write = 0; PC_INC = 1; 
        #50
        $finish;
    end

endmodule //PC_TB