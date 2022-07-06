module Datapath (input clk);

    wire IR_write, IR_read, IRAM_read, DRAM_read, DRAM_write, MDR_write, MDR_read, AC_write, AC_read, alu_mux, AC_reset, 
                        L_write, L_read, X_read, X_write, CenterP_write, CenterP_read, J_read, J_write, MAR_write, MAR_read, T_write, T_read, H_read, H_write,
                        W_read, W_write, PC_write, K_read, K_write, Count_write, Count_read, PC_inc, PC_read, neg_flag;
    wire [23:0] TO_DMEM, FROM_DMEM, FROM_IRAM, C_Bus, B_Bus, ALU_out, ALU_IN, MUX_out, IR, IRAM_addr, IR_out, DMEM_addr;
//    reg [23:0] IR_out;
    wire [2:0] ALU_op, mux_ctrl;

    assign DRAM_reset = 1'b0; 

    DRAM DRAM(.clk(clk), .write(DRAM_write), .read(DRAM_read), .reset(DRAM_reset), .addr_in(DMEM_addr), .data_in(TO_DMEM), .data_out(FROM_DMEM));
    IRAM IRAM(.clk(clk), .read(IRAM_read), .addr_in(IRAM_addr), .ins_out(FROM_IRAM));

    Bus BUS(.clk(clk), .AC_read(AC_read), .AC_reset(AC_reset), .L_read(L_read), .L_write(L_write), .X_read(X_read), .X_write(X_write), .CenterP_write(CenterP_write), 
    .CenterP_read(CenterP_read), .J_read(J_read), .J_write(J_write), .MAR_write(MAR_write), .MAR_read(MAR_read),.PC_read(PC_read), .PC_inc(PC_inc), .IR_read(IR_read),
    .T_write(T_write), .T_read(T_read), .H_read(H_read), .H_write(H_write), .W_read(W_read), .AC_write(AC_write), .W_write(W_write), .DRAM_read(DRAM_read), .IR_write(IR_write),
    .PC_write(PC_write), .K_read(K_read), .K_write(K_write), .Count_write(Count_write), .Count_read(Count_read), .MDR_write(MDR_write), .MDR_read(MDR_read), 
    .mux_ctrl(mux_ctrl), .FROM_DMEM(FROM_DMEM), .FROM_IRAM(FROM_IRAM), .C_Bus(C_Bus), .IR_out(IR_out),
    .B_Bus(B_Bus), .ALU_IN(ALU_IN), .TO_DMEM(TO_DMEM), .IRAM_addr(IRAM_addr), .MUX_out(MUX_out), .DMEM_addr(DMEM_addr));

    ALU ALU(.operation(ALU_op), .alu_in1(ALU_IN), .alu_in2(MUX_out), .alu_out(ALU_out), .neg_flag(neg_flag));

    ALU_MUX ALU_MUX(.clk(clk), .mux(alu_mux), .ALU_out(ALU_out), .Bus_out(B_Bus), .MUX_out(C_Bus));

    Controller Controller(.clk(clk), .neg_flag(neg_flag), .IR(FROM_IRAM), .IR_write(IR_write), .L_read(L_read),
    .IRAM_read(IRAM_read), .PC_inc(PC_inc), .DRAM_read(DRAM_read), .DRAM_write(DRAM_write), .MDR_read(MDR_read),
    .MDR_write(MDR_write), .AC_write(AC_write), .ALU_MUX(alu_mux), .AC_read(AC_read), .IR_read(IR_read),
    .AC_reset(AC_reset), .L_write(L_write), .X_read(X_read), .X_write(X_write), .CenterP_write(CenterP_write), 
    .CenterP_read(CenterP_read), .J_read(J_read), .J_write(J_write), .MAR_write(MAR_write), .MAR_read(MAR_read), 
    .T_write(T_write), .T_read(T_read), .H_read(H_read), .H_write(H_write), .W_read(W_read), .W_write(W_write), 
    .PC_write(PC_write), .K_read(K_read), .K_write(K_write), .Count_write(Count_write), .Count_read(Count_read), 
    .ALU_op(ALU_op), .MUX(mux_ctrl));


endmodule //Datapath