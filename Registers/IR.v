//Instruction Register

module IR ( input clk, write, read,
            input [23:0] ins_in,     //IMEM to IR
            output [23:0] ins_out    //IR to B Bus
);
    reg [23:0] register;

    always @(posedge clk ) begin
        if (write) begin
            register <= ins_in;
        end
    end

  assign ins_out = read ? register : 24'dz; 

endmodule //IR