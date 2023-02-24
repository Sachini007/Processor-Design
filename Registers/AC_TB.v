`timescale 1ns/1ps

module AC_TB ();
    reg clk, read_bus, write, reset;
    reg [23:0] data_in;
    wire [23:0] BUS_OUT;
    wire [23:0] ALU_IN;

    AC dut(.clk(clk), .read_bus(read_bus),
    .write(write), .reset(reset),
    .data_in(data_in), .BUS_OUT(BUS_OUT), .ALU_IN(ALU_IN));

    //Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

    //Test Case 01
    initial begin
        write = 1; read_bus = 0; data_in = 24'd100; reset = 0; 
//        $display("Expected output: %d, actual output: %d",100, data_in);
        #50;
        read_bus = 1; write = 0; reset = 0; 
        #50;
        read_bus = 0; write = 0; reset = 0; 
        #50;
        read_bus = 0; write = 0; reset = 0; 
        #50;
        read_bus = 0; write = 0; reset = 1;
        #50;
        $finish;
    end


endmodule //AC_TB