`timescale 1ns / 1ps

`include "rv32e_soc.v"

module testbench;
    reg  clk;
    reg  reset;

    rv32e_soc rv32e_soc0(
        .clk(clk),
        .reset(reset)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("rv32e_testbench.vcd"); 
        $dumpvars(); 
        clk <= 0;
        reset <= 1;

        #10 reset <= 0; #10 reset <= 1;

        #900
        $finish;
    end

endmodule
