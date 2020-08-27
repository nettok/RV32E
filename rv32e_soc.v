`timescale 1ns / 1ps

`include "rv32e_cpu.v"
`include "mem_program_rom.v"
`include "mem_data_ram.v"

module rv32e_soc(
    input clk,
    input reset
);

    wire [31:0] mem_program_data_bus;
    wire [31:0] mem_program_addr_bus;

    wire [31:0] mem_read_data_bus;
    wire [31:0] mem_write_data_bus;
    wire mem_write_signal;
    wire [31:0] mem_addr_bus;

    rv32e_cpu rv32e_cpu0(
        .clk(clk),
        .reset(reset),
        .mem_program_data_bus(mem_program_data_bus),
        .mem_program_addr_bus(mem_program_addr_bus),
        .mem_read_data_bus(mem_read_data_bus),
        .mem_write_data_bus(mem_write_data_bus),
        .mem_write_signal(mem_write_signal),
        .mem_addr_bus(mem_addr_bus)
    );

    mem_program_rom mem_program_rom0(
        .addr_bus(mem_program_addr_bus),
        .data_bus(mem_program_data_bus)
    );

    mem_data_ram mem_data_ram0(
        .addr_bus(mem_addr_bus),
        .read_data_bus(mem_read_data_bus),
        .write_data_bus(mem_write_data_bus),
        .write_signal(mem_write_signal)
    );

endmodule
