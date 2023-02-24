`timescale 1ns/1ps

module MUX_TB ();
    reg clk;
    reg [2:0] mux;
    reg [23:0] L;
    reg [23:0] W;
    reg [23:0] K;
    reg [23:0] T;
    reg [23:0] X;
    reg [23:0] J;
    wire [23:0] MUX_out;

    MUX dut(.clk(clk), .mux(mux), .L(L), .W(W), .K(K), .T(T), .X(X), .J(J), .MUX_out(MUX_out));

    //Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end
    // 111 - L (default)
    // 010 - W
    // 011 - K
    // 001 - T
    // 101 - X
    // 110 - J
    //Test Case 01
    initial begin
        mux = 111; L = 24'd64; W = 24'd256; K = 24'd32; T = 24'd128; X = 24'd160; J = 24'd32;
        #50;
        mux = 010; L = 24'd64; W = 24'd256; K = 24'd32; T = 24'd128; X = 24'd160; J = 24'd32;
        #50;
        mux = 011; L = 24'd64; W = 24'd256; K = 24'd32; T = 24'd128; X = 24'd160; J = 24'd32;
        #50;
        mux = 001; L = 24'd64; W = 24'd256; K = 24'd32; T = 24'd128; X = 24'd160; J = 24'd32;
        #50;
        mux = 101; L = 24'd64; W = 24'd256; K = 24'd32; T = 24'd128; X = 24'd160; J = 24'd32;
        #50;
        mux = 110; L = 24'd64; W = 24'd256; K = 24'd32; T = 24'd128; X = 24'd160; J = 24'd32;
        #50;
        mux = 000; L = 24'd64; W = 24'd256; K = 24'd32; T = 24'd128; X = 24'd160; J = 24'd32;
        #50;
        $finish;
    end

endmodule //MUX_TB