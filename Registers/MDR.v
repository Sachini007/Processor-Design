//Memory Data Register

module MDR (input clk, write, read_bus,
            input [23:0] data_in,
            output [23:0] Bus_out,
            output [23:0] DMEM 
);
    reg [23:0] register ;

    assign DMEM = register;

    always @(posedge clk ) begin
        if (write) begin
            register <= data_in;
        end    
        
    end
    assign Bus_out = read_bus ? register : 24'dz;

endmodule //MDR