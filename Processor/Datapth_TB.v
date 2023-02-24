`timescale 1ns/1ps

module Datapth_TB ();
    reg clk;
//    wire IRAM_read, IR_write;

    Datapath processor(.clk(clk));

    //Clock
    always begin
        clk = 1; #1; clk = 0; #1;
    end

    initial begin
        #360000000;
        $finish;
    end
 
endmodule //Datapth_TB