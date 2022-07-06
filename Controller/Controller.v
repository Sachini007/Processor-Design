//Controller

module Controller ( input clk, neg_flag,
                    input [23:0] IR,
                    output reg IR_write, IR_read, IRAM_read, DRAM_read, DRAM_write, MDR_write, MDR_read, AC_write, AC_read, ALU_MUX, AC_reset, 
                        L_write, L_read, X_read, X_write, CenterP_write, CenterP_read, J_read, J_write, MAR_write, MAR_read, T_write, T_read, H_read, H_write,
                        W_read, W_write, PC_write, K_read, K_write, Count_write, Count_read, PC_inc, PC_read, 
                    output reg [2:0] ALU_op,
                    output reg [2:0] MUX
);

    reg [4:0] state;
    reg [3:0] read_reg;
    reg [3:0] write_reg;
    wire [13:0] out_w;
    wire [13:0] out_r;

    Decoder write(write_reg, out_w);
    Decoder read(read_reg, out_r);
    
  
    initial begin
        state = 5'b1;
    end 

    always @(posedge clk) begin
        case (state)
            5'd1 : begin //FETCH 01
                PC_inc <= 1'b0; 
                AC_reset <= 0; 
                DRAM_write <= 1'b0;
                DRAM_read <= 1'b0;
                ALU_MUX <= 0;
                MUX <= 3'b111;
                write_reg <= 4'b0;
                read_reg <= 4'b0;
                {H_read, W_read, K_read, Count_read, X_read, J_read, L_read, CenterP_read, T_read, AC_read, PC_read, MDR_read, MAR_read, IR_read} <= 14'b0;
                {H_write, W_write, K_write, Count_write, X_write, J_write, L_write, CenterP_write, T_write, AC_write, PC_write, MDR_write, MAR_write, IR_write} <= 14'b0;

                IR_write <= 1'b1;
                IRAM_read <= 1'b1;
                state <= 5'd2;
                
            end

            5'd2 : begin //FETCH 02
                IR_write <= 1'b0;
                IRAM_read <= 1'b0;

                PC_inc = 1'b1;
//                IR_read = 1'b1;
                read_reg <= IR[12:9];
                write_reg <= IR[8:5];
                state <= IR[4:0];
            end

            5'd3 : begin //LDAC 01
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                DRAM_read <= 1'b1;
                MDR_write <= 1'b1;
                state <= 5'd4;
            end

            5'd4 : begin //LDAC 02
                DRAM_read <= 1'b0;
                MDR_write <= 1'b0;

                MDR_read <= 1'b1;
                AC_write <= 1'b1;
                ALU_MUX <= 1'b0;
                state <= 5'd1;
            end

            5'd5 : begin //STAC 01
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                AC_read <= 1'b1;
                ALU_MUX <= 1'b0;
                MDR_write <= 1'b1;
                state <= 5'd6;
            end

            5'd6 : begin //STAC 02
                AC_read <= 1'b0;
                MDR_write <= 1'b0;

                DRAM_write <= 1'b1;
                state <= 5'd1;
            end

            5'd7 : begin //CLAC
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                AC_reset <= 1'b1;
                state <= 5'd1;
            end

            5'd8 : begin //MV 
                PC_inc <= 1'b0;
                // IR_read = 1'b0;

                ALU_MUX <= 1'b0;
                {H_write, W_write, K_write, Count_write, X_write, J_write, L_write, CenterP_write, T_write, AC_write, PC_write, MDR_write, MAR_write, IR_write} <= {out_w};
                {H_read, W_read, K_read, Count_read, X_read, J_read, L_read, CenterP_read, T_read, AC_read, PC_read, MDR_read, MAR_read, IR_read} <= {out_r};
                state <= 5'd1;
            end 

            5'd9 : begin //INC AC
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                ALU_op <= 3'b110;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end

            5'd10 : begin //DEC AC
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                ALU_op <= 3'b111;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end

            5'd11 : begin //ADD
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                MUX <= write_reg[3:0];
                ALU_op <= 3'b000;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end

            5'd12 : begin //SUB
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                MUX <= write_reg[3:0];
                ALU_op <= 3'b001;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end

            5'd13 : begin //DIV16
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                ALU_op <= 3'b101;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end

            5'd14 : begin //MUL2
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                ALU_op <= 3'b010;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end            

            5'd15 : begin //MUL4
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                ALU_op <= 3'b011;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end

            5'd16 : begin //MUL
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                MUX <= write_reg[3:0];
                ALU_op <= 3'b100;
                ALU_MUX <= 1'b1;
                AC_write <= 1'b1;
                state <= 5'd1;
            end

            5'd17 : begin //JUMPN 01
                PC_inc <= 1'b0;
//                IR_read = 1'b0;

                MUX <= write_reg[3:0];
                ALU_op <= 3'b001;
                state <= 5'd18;
            end 

            5'd18 : begin //JUMPN 02
                if (neg_flag) begin
                    PC_inc <= 1'b1;
                    state <= 5'd1;
                end
                else begin
                    IR_write <= 1'b1;
                    IRAM_read <= 1'b1;
                    state <= 5'd19;                    
                end
            end
            5'd19 : begin  //JUMP 03
                IR_write <= 1'b0;
                IRAM_read <= 1'b0;

                IR_read <= 1'b1;
                PC_write <= 1'b1;
                state <= 5'd1;
            end 

            5'd20 : begin //CONST 01
//                IR_read = 1'b0;

                PC_inc <= 1'b1;
                IR_write <= 1'b1;
                IRAM_read <= 1'b1;
                state <= 5'd21;
            end

            5'd21 : begin //CONST 02
                PC_inc = 1'b0;
                IR_write = 1'b0;
                IRAM_read = 1'b0;

                IR_read = 1'b1; 
                ALU_MUX <= 1'b0;
                {H_write, W_write, K_write, Count_write, X_write, J_write, L_write, CenterP_write, T_write, AC_write, PC_write, MDR_write, MAR_write, IR_write} <= {out_w};
                state <= 5'd1;
            end

        endcase
    end

endmodule //Controller