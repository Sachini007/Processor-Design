//Mux connected with ALU output

module ALU_MUX (input clk, mux,
                input [23:0] ALU_out,
                input [23:0] Bus_out,
                output [23:0] MUX_out
);
 // 1 - ALU 
 // 0 - Bus (default)
    assign MUX_out = mux ? ALU_out : Bus_out ;

endmodule //ALU_MUX