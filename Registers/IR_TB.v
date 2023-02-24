`timescale 1ns/1ps

module IR_TB ();
    reg clk, write, read;
    reg [23:0] ins_in;
    wire [23:0] ins_out;

    IR dut(.clk(clk), .write(write), .read(read), .ins_in(ins_in), 
    .ins_out(ins_out));

//Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

//Test Case 01
    initial begin
        write = 1; read = 0; ins_in = 24'd100;
        #50;
        read = 1; write = 0;
        #50
        $finish;
    end

endmodule //IR_TB