//Memory adress register

module MAR (input clk, write,
            input [23:0] addr_in,
            output [23:0] DMEM    
);
    reg [23:0] register ;

    assign DMEM = register ;

    always @(posedge clk ) begin
        if (write) begin
            register <= addr_in ;
        end
    end

endmodule //MAR