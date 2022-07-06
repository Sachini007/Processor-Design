//Arithmetic and Logic Unit

module ALU ( input [2:0] operation,
             input [23:0] alu_in1, // AC
             input [23:0] alu_in2, // General Purpose Register 
             output [23:0] alu_out,
             output neg_flag
);

    reg [23:0] result;

    always @(*) begin
        case (operation)
            3'b000: result = alu_in1 + alu_in2;
            3'b001: result = alu_in1 - alu_in2;
            3'b010: result = alu_in1 * 2;
            3'b011: result = alu_in1 * 4;
            3'b100: result = alu_in1 * alu_in2;
            3'b101: result = alu_in1 / 16;
            3'b110: result = alu_in1 + 1;
            3'b111: result = alu_in1 - 1;
            default : result = 24'dz;
        endcase
        
    end

    assign neg_flag = (result[23] == 1'b1) ? 1'b1: 1'b0;
    assign alu_out = result;

endmodule //ALU