`timescale 1ns/1ps

module ALU_MUX_TB ();
    reg clk, mux;
    reg [23:0] ALU_out;
    reg [23:0] Bus_out;
    wire [23:0] MUX_out;

    ALU_MUX dut(.clk(clk), .mux(mux), .ALU_out(ALU_out), .Bus_out(Bus_out),
    .MUX_out(MUX_out));

    //Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

    //Test Case 01
    initial begin
        mux = 0; ALU_out = 24'd64; Bus_out = 24'd256;
        #50;
        mux = 1; ALU_out = 24'd64; Bus_out = 24'd256;
        #50;
        $finish;
    end

endmodule //ALU_MUX_TB