//MUX 

module MUX ( input clk, 
             input [2:0] mux,
             input [23:0] L,
             input [23:0] W,
             input [23:0] K,
             input [23:0] T,
             input [23:0] X,
             input [23:0] J,
             output [23:0] MUX_out   
);
// 111 - L (default)
// 010 - W
// 011 - K
// 001 - T
// 101 - X
// 110 - J

    assign MUX_out = (mux == 3'b111) ? L  : (mux == 3'b010) ? W : (mux == 3'b011) ? K : (mux == 3'b001) ? T : (mux == 3'b101) ? X : (mux == 3'b110) ? J : L;
endmodule //MUX