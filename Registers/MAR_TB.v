`timescale 1ns/1ps

module MAR_TB ();
    reg clk, write;
    reg [23:0] addr_in;
    wire [23:0] DMEM;

    MAR dut(.clk(clk), .write(write), .addr_in(addr_in), .DMEM(DMEM));

//Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

//Test Case 01
    initial begin
        write = 1; addr_in = 24'd100;
        #50;
        write = 0;
        #50;
        write = 1; addr_in = 24'd32;
        #50
        $finish;
    end

endmodule //MAR_TB