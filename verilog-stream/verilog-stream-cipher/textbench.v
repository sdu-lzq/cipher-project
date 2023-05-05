`timescale 1ns/1ps
`include "stream_cipher.v"


module text();
    reg  clk;
    reg rest;
    wire  dataout;
    reg [63:0] Key;

    //clock generating
    real CYCLE_200MHZ =5;
    always begin
        clk = 0;#(CYCLE_200MHZ/2);
        clk = 1;#(CYCLE_200MHZ/2);
    end

    initial begin
        Key = 64'h3170604015ABCDEF;
        //initialize the key and h express the hex .
        rest = 1;
        #100 //after 100ns end the reset process.
        rest = 0;
    end
    

    A5 A5text(
        .rest      (rest),
        .clk       (clk),
        .Key    (Key),
        .code     (dataout)

    );

    initial begin
        forever begin
            #100
            if($time >= 1000) $finish;
        end
    end

    initial begin
        $dumpfile("wave.vcd");
        //check the wave of the module.
        $dumpvars;
    end



endmodule