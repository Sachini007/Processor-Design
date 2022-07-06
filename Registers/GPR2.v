//General Purpose (H,X,J,CENTERP, COUNT)

module GPR2 (input clk, write, read,
             input [23:0] data_in,
             output [23:0] data_out
);

    reg [23:0] register ;

    always @(posedge clk ) begin
        if (write) begin
            register <= data_in;
        end
    end

    assign data_out = read ? register : 24'dz;

endmodule //GRP2

