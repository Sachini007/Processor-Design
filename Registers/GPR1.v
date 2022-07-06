// General Purpose (W,K,L,T)

module GPR1 ( input clk, read_bus, write,
              input [23:0] data_in,
              output [23:0] MUX,
              output [23:0] BUS_OUT
);

    reg [23:0] register;

    always @(posedge clk ) begin
        if (write) begin
            register <= data_in;
        end
    end

    assign MUX = register;
    assign BUS_OUT = read_bus ? register : 24'dz;

endmodule //GPR1