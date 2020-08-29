`timescale 1ns / 1ps

`include "rv32e_cpu.v"
`include "mem_data_ram.v"

module rv32e_soc(
    input clk,
    input reset,

    // program ROM
    output [31:0] program_addr_bus,
    input [31:0] program_data_bus,

    // memory-mapped IO ports
    input  [7:0] i,
    output [7:0] o
);

    wire [31:0] mem_read_data_bus;
    wire [31:0] mem_write_data_bus;
    wire mem_write_signal;
    wire [31:0] mem_addr_bus;

    rv32e_cpu rv32e_cpu0(
        .clk(clk),
        .reset(reset),
        .program_data_bus(program_data_bus),
        .program_addr_bus(program_addr_bus),
        .mem_read_data_bus(mem_read_data_bus),
        .mem_write_data_bus(mem_write_data_bus),
        .mem_write_signal(mem_write_signal),
        .mem_addr_bus(mem_addr_bus)
    );

    mem_data_ram mem_data_ram0(
        .clk(clk),
        .reset(reset),
        .addr_bus(mem_addr_bus),
        .read_data_bus(mem_read_data_bus),
        .write_data_bus(mem_write_data_bus),
        .write_signal(mem_write_signal),
        .i(i), .o(o)
    );

endmodule
