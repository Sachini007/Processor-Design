//Program Counter

module PC (input clk, write, PC_INC,
           input [23:0] ins_in,      // C bus to PC
           output [23:0] ins_out     // PC to IMEM 
);
    reg [23:0] register ;
    
    initial begin
        register = 24'b0;
    end

    assign ins_out = register;

    always @(posedge clk ) begin
        if (write) begin
            register <= ins_in;
        end

        if (PC_INC) begin
            register <= register + 24'b1;
        end
    end


endmodule //PC