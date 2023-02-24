`timescale 1ns/1ps

module GRP2_TB ();
    reg clk, write, read;
    reg [23:0] data_in;
    wire [23:0] data_out;


    GPR2 dut(.clk(clk), .write(write), .read(read), .data_in(data_in), 
    .data_out(data_out));

//Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

//Test Case 01
    initial begin
        #50;
        write = 1; read = 0; data_in = 24'd100;
        #50;
        read = 1; write = 0;
        #50;
        $finish;
    end

endmodule //GRP2_TB