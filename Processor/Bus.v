module Bus ( input clk, H_read, W_read, K_read, Count_read, X_read, J_read, L_read, CenterP_read, T_read, AC_read, PC_read, MDR_read, MAR_read, IR_read,
                H_write, W_write, K_write, Count_write, X_write, J_write, L_write, CenterP_write, T_write, AC_write, PC_write, MDR_write, MAR_write, IR_write, 
                DRAM_read, AC_reset, PC_inc,
             input [2:0] mux_ctrl,
             input [23:0] FROM_IRAM, //From IRAM
             input [23:0] FROM_DMEM,  //From DMEM
             input [23:0] C_Bus, 
             output [23:0] B_Bus, ALU_IN, TO_DMEM, IRAM_addr, MUX_out, DMEM_addr, IR_out
     );

    wire [23:0] MUX_J, MUX_L, MUX_K, MUX_T, MUX_X, MUX_W, MDR_out, H_out, CenterP_out, J_out, Count_out, X_out, L_out, W_out, K_out, T_out, AC_out, IR_out, ALU_IN_;

    MUX mux(.clk(clk), .mux(mux_ctrl), .L(MUX_L), .W(MUX_W), .K(MUX_K), .T(MUX_T), .X(MUX_X), .J(MUX_J), .MUX_out(MUX_out));

    MAR MAR(.clk(clk), .write(MAR_write), .addr_in(C_Bus), .DMEM(DMEM_addr)); //MAR
    MDR MDR(.clk(clk), .write(MDR_write), .read_bus(MDR_read), .data_in(C_Bus), .Bus_out(MDR_out), .DMEM(TO_DMEM)); //MDR
    PC PC(.clk(clk), .write(PC_write), .PC_INC(PC_inc), .ins_in(C_Bus), .ins_out(IRAM_addr)); //PC NUmber of bits different??
    IR IR(.clk(clk), .write(IR_write), .read(IR_read), .ins_in(FROM_IRAM), .ins_out(IR_out)); // IR
    GPR2 H(.clk(clk), .write(H_write), .read(H_read), .data_in(C_Bus), .data_out(H_out)); // H
    GPR2 CenterP(.clk(clk), .write(CenterP_write), .read(CenterP_read), .data_in(C_Bus), .data_out(CenterP_out)); //CenterP
    GPR1 J(.clk(clk), .write(J_write), .read_bus(J_read), .data_in(C_Bus), .MUX(MUX_J), .BUS_OUT(J_out)); // J
    GPR2 Count(.clk(clk), .write(Count_write), .read(Count_read), .data_in(C_Bus), .data_out(Count_out)); // Count
    GPR1 X(.clk(clk), .write(X_write), .read_bus(X_read), .data_in(C_Bus), .MUX(MUX_X), .BUS_OUT(X_out)); // X
    GPR1 L(.clk(clk), .write(L_write), .read_bus(L_read), .data_in(C_Bus), .MUX(MUX_L), .BUS_OUT(L_out)); // L
    GPR1 W(.clk(clk), .write(W_write), .read_bus(W_read), .data_in(C_Bus), .MUX(MUX_W), .BUS_OUT(W_out)); // W
    GPR1 K(.clk(clk), .write(K_write), .read_bus(K_read), .data_in(C_Bus), .MUX(MUX_K), .BUS_OUT(K_out)); // K
    GPR1 T(.clk(clk), .write(T_write), .read_bus(T_read), .data_in(C_Bus), .MUX(MUX_T), .BUS_OUT(T_out)); // T
    AC AC(.clk(clk), .read_bus(AC_read), .write(AC_write), .reset(AC_reset), .data_in(C_Bus), .BUS_OUT(AC_out), .ALU_IN(ALU_IN)); // AC

//    assign B_Bus = DRAM_read ? FROM_DMEM : MDR_read ? MDR_out : H_read ? H_out : CenterP_read ? CenterP_out : J_read ? J_out : Count_read ? Count_out : X_read ? X_out : L_read ? L_out : W_read ? W_out : K_read ? K_out : T_read ? T_out : AC_read ? AC_out : IR_read ? IR_out : 24'bz;   
//    assign B_Bus = DRAM_read ? FROM_DMEM : H_read ? H_out : MDR_read ? MDR_out : CenterP_read ? CenterP_out : J_read ? J_out : Count_read ? Count_out : X_read ? X_out : L_read ? L_out : W_read ? W_out : K_read ? K_out : T_read ? T_out : AC_read ? AC_out : IR_read ? IR_out : 24'dz;
    assign B_Bus = DRAM_read ? FROM_DMEM : Count_read ? Count_out : W_read ? W_out : IR_read ? IR_out : K_read ? K_out : AC_read ? AC_out : H_read ? H_out : T_read ? T_out : CenterP_read ? CenterP_out : J_read ? J_out : X_read ? X_out : L_read ? L_out : MDR_read ? MDR_out : T_read ? T_out : AC_read ? AC_out : 24'bz;
//    assign B_Bus = AC_read ? AC_out : 24'dz;
//    assign B_Bus = DRAM_read ? FROM_DMEM : MDR_read ? MDR_out : IR_read ? IR_out : H_read ? H_out : CenterP_read ? CenterP_out : J_read ? J_out : Count_read ? Count_out : X_read ? X_out : L_read ? L_out : W_read ? W_out : K_read ? K_out : T_read ? T_out : AC_read ? AC_out : 24'dz;

endmodule //Bus