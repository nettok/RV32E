`timescale 1ns / 1ps

`include "rv32e_soc.v"
`include "test_program_rom_1.v"

module testbench;
    reg  clk;
    reg  reset;

    wire [31:0] program_addr_bus;
    wire [31:0] program_data_bus;

    reg [7:0] i, o;

    rv32e_soc rv32e_soc0(
        .clk(clk),
        .reset(reset),
        .program_addr_bus(program_addr_bus),
        .program_data_bus(program_data_bus),
        .i(i), .o(o)
    );

    program_rom program_rom0(
        .addr_bus(program_addr_bus),
        .data_bus(program_data_bus)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("rv32e_testbench_1.vcd"); 
        $dumpvars(); 
        clk = 0;
        reset = 1;

        #10 reset = 0; #10 reset = 1;

        #900
        $finish;
    end

endmodule
