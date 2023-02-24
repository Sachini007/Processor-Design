`timescale 1ns/1ps

module Bus_TB ();
    reg clk, H_read, W_read, K_read, Count_read, X_read, J_read, L_read, CenterP_read, T_read, AC_read, PC_read, MDR_read, MAR_read, IR_read,
                H_write, W_write, K_write, Count_write, X_write, J_write, L_write, CenterP_write, T_write, AC_write, PC_write, MDR_write, MAR_write, IR_write, 
                DRAM_read, AC_reset, PC_inc;
    reg [2:0] mux_ctrl;
    reg [23:0] FROM_DMEM, FROM_IRAM, C_Bus;
    wire [23:0] B_Bus, ALU_IN, TO_DMEM, IRAM_addr, MUX_out, DMEM_addr;

    Bus dut(.clk(clk), .AC_read(AC_read), .AC_reset(AC_reset), .L_read(L_read), .L_write(L_write), .X_read(X_read), .X_write(X_write), .CenterP_write(CenterP_write), 
    .CenterP_read(CenterP_read), .J_read(J_read), .J_write(J_write), .MAR_write(MAR_write), .MAR_read(MAR_read),.PC_read(PC_read), .PC_inc(PC_inc), .IR_read(IR_read),
    .T_write(T_write), .T_read(T_read), .H_read(H_read), .H_write(H_write), .W_read(W_read), .AC_write(AC_write), .W_write(W_write), .DRAM_read(DRAM_read), .IR_write(IR_write),
    .PC_write(PC_write), .K_read(K_read), .K_write(K_write), .Count_write(Count_write), .Count_read(Count_read), .MDR_write(MDR_write), .MDR_read(MDR_read), 
    .mux_ctrl(mux_ctrl), .FROM_DMEM(FROM_DMEM), .FROM_IRAM(FROM_IRAM), .C_Bus(C_Bus),
    .B_Bus(B_Bus), .ALU_IN(ALU_IN), .TO_DMEM(TO_DMEM), .IRAM_addr(IRAM_addr), .MUX_out(MUX_out), .DMEM_addr(DMEM_addr));

    //Clock
    always begin
        clk = 1; #10; clk = 0; #10;
    end

    //Test Case 01
    initial begin
        H_read = 1'b0; H_write = 1'b1; C_Bus = 24'd32; DRAM_read = 0;  W_read = 1'b0; K_read = 1'b0; Count_read = 1'b0; X_read = 1'b0; J_read = 1'b0; L_read = 1'b0; CenterP_read = 1'b0; T_read = 1'b0; AC_read = 1'b0; PC_read = 1'b0; MDR_read = 1'b0; MAR_read = 1'b0; IR_read = 1'b0; 
        #30;
        H_read = 1'b1; H_write = 1'b0; C_Bus = 24'd32; DRAM_read = 0; FROM_DMEM = 24'b0; 
        #30;
        H_read = 1'b0; T_write = 1'b1; C_Bus = 24'd256; DRAM_read = 0; 
        #30;
        H_read = 1'b0; T_write = 1'b0; T_read = 1'b1; C_Bus = 24'd256; DRAM_read = 0; 
        #30;
        T_read = 1'b0; J_write = 1'b1; C_Bus = 24'd16; DRAM_read = 0; 
        #30;
        T_read = 1'b0; J_write = 1'b0; J_read = 1'b1; C_Bus = 24'd16; DRAM_read = 0; 
        #30;
        J_read = 1'b0; AC_write = 1'b1; C_Bus = 24'd32; AC_reset = 1'b0; AC_read = 1'b0;
        #30;
        AC_read = 1'b1; AC_write = 1'b0;
        #30;
        AC_read = 1'b0; K_write = 1'b1; K_read = 1'b0;
        #30;
        K_write = 1'b0; K_read = 1'b1;
        #30;
        L_write = 1'b1; K_read = 1'b0; C_Bus = 24'd160;
        #30;
        L_read = 1'b1; L_write = 1'b0; C_Bus = 24'd160;
        #30;
        L_read = 1'b0; W_write = 1'b1; C_Bus = 24'd1600;
        #30;
        W_read = 1'b1; W_write = 1'b0; C_Bus = 24'd1600;
        #30;
        W_read = 1'b0; X_write = 1'b1; C_Bus = 24'd100;
        #30;
        X_read = 1'b1; X_write = 1'b0; C_Bus = 24'd100;
        #30;
        X_read = 1'b0; CenterP_write = 1'b1; C_Bus = 24'd101;
        #30;
        CenterP_read = 1'b1; CenterP_write = 1'b0; C_Bus = 24'd101;
        #50;
        CenterP_read = 1'b0; Count_write = 1'b1; C_Bus = 24'd102;
        #30;
        Count_read = 1'b1; Count_write = 1'b0; C_Bus = 24'd102;
        #30;
        Count_read = 1'b0; PC_write = 1'b1; C_Bus = 24'd4;
        #30;
        PC_inc = 1'b1; PC_write = 1'b0; C_Bus = 24'd4;
        #30;
        PC_inc = 1'b0; MAR_write = 1'b1; C_Bus = 24'd11;
        #30;
        FROM_IRAM = 24'd12; IR_write = 1'b1; MAR_write = 1'b0;
        #50;
        IR_read = 1'b1; IR_write = 1'b0;
        #30;
        IR_read = 1'b0; MDR_write = 1'b1; C_Bus = 24'd3;
        #30;
        MDR_read = 1'b1; MDR_write = 1'b0;
        #30;
        MDR_read = 1'b0; mux_ctrl = 3'b000;
        #30;
        DRAM_read = 1'b1; FROM_DMEM = 24'd1;
        #30;
        $finish;
    end

endmodule //Bus_TB