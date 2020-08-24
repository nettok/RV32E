`timescale 1ns / 1ps

`include "rv32e_cpu.v"
`include "mem_program_rom.v"

module testbench;
    reg  clk;
    reg  reset;
    
    wire [31:0] mem_program_data_bus;
    wire [31:0] mem_program_addr_bus;

    rv32e_cpu rv32e_cpu0(
        .clk(clk),
        .reset(reset),
        .mem_program_data_bus(mem_program_data_bus),
        .mem_program_addr_bus(mem_program_addr_bus)
    );

    mem_program_rom mem_program_rom0(
        .addr_bus(mem_program_addr_bus),
        .data_bus(mem_program_data_bus)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("rv32e_testbench.vcd"); 
        $dumpvars(); 
        clk <= 0;
        reset <= 1;

        #50 reset <= 0; #50 reset <= 1;

        #830
        $finish;
    end

endmodule
