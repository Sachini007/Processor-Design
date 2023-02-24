`timescale 1ns/1ps

module GPR1_TB ();
    reg clk, write, read_bus;
    reg [23:0] data_in;
    wire [23:0] MUX;
    wire [23:0] BUS_OUT;

    GPR1 dut(.clk(clk), .write(write), .read_bus(read_bus), .data_in(data_in),
    .MUX(MUX), .BUS_OUT(BUS_OUT));

//Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

//Test Case 01
    initial begin
        write = 1; read_bus = 0; data_in = 24'd100;
        #50;
        read_bus = 1; write = 0; data_in = 24'd100;
        #50
        $finish;
    end

endmodule //GPR1_TB