//Accumulator

module AC ( input clk, read_bus, write, reset,
            input [23:0] data_in,
            output [23:0] BUS_OUT, 
            output [23:0] ALU_IN 
);

    reg [23:0] register ;

    always @(posedge clk ) begin
        if (write) begin
            register <= data_in;
        end 

        if (reset) begin
            register = 24'b0;
        end
    end

    assign ALU_IN = register;
    assign BUS_OUT = read_bus ? register : 24'dz;


endmodule //AC