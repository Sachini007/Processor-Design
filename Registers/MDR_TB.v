`timescale 1ns/1ps

module MDR_TB ();
    reg clk, write, read_bus;
    reg [23:0] data_in;
    wire [23:0] Bus_out;
    wire [23:0] DMEM;

    MDR dut(.clk(clk), .write(write), .read_bus(read_bus), .data_in(data_in),
    .Bus_out(Bus_out), .DMEM(DMEM));

    //Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

    //Test Case 01
    initial begin
        write = 1; read_bus = 0; data_in = 23'd100;
        #50;
        read_bus = 1; write = 0; 
        #50;
        write = 1; read_bus = 0; data_in = 23'd80;
        #50;
        $finish;
    end

endmodule //MDR_TB