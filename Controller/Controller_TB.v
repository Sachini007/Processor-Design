`timescale 1ns/1ps

module Controller_TB ();
    reg clk, neg_flag;
    reg [23:0] IR;
    wire  IR_write, IR_read, IRAM_read, DRAM_read, DRAM_write, MDR_write, MDR_read, AC_write, AC_read, ALU_MUX, AC_reset, 
            L_write, L_read, X_read, X_write, CenterP_write, CenterP_read, J_read, J_write, MAR_write, MAR_read, T_write, T_read, H_read, H_write,
            W_read, W_write, PC_write, K_read, K_write, Count_write, Count_read, PC_inc;
    wire [2:0] ALU_op;
    wire [2:0] MUX;

    Controller dut(.clk(clk), .neg_flag(neg_flag), .IR(IR), .IR_write(IR_write), .L_read(L_read),
    .IRAM_read(IRAM_read), .PC_inc(PC_inc), .DRAM_read(DRAM_read), .DRAM_write(DRAM_write), .MDR_read(MDR_read),
    .MDR_write(MDR_write), .AC_write(AC_write), .ALU_MUX(ALU_MUX), .AC_read(AC_read), .IR_read(IR_read),
    .AC_reset(AC_reset), .L_write(L_write), .X_read(X_read), .X_write(X_write), .CenterP_write(CenterP_write), 
    .CenterP_read(CenterP_read), .J_read(J_read), .J_write(J_write), .MAR_write(MAR_write), .MAR_read(MAR_read), 
    .T_write(T_write), .T_read(T_read), .H_read(H_read), .H_write(H_write), .W_read(W_read), .W_write(W_write), 
    .PC_write(PC_write), .K_read(K_read), .K_write(K_write), .Count_write(Count_write), .Count_read(Count_read), 
    .ALU_op(ALU_op), .MUX(MUX));

    //Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

    //Test Case 01
    initial begin
        neg_flag = 1; 
        #100;
        neg_flag = 1; 
        #100;
        $finish;
    end

endmodule //Controller_TB