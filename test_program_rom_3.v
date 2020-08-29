`timescale 1ns / 1ps

`include "instructions.v"

module program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [99:0];
    assign data_bus = mem[addr_bus/4];  // byte-addressable with forced 32-bit aligned access

    initial mem[0000] = {12'd1, 5'd0, `F3_ADDI,  5'd4, `OP_OP_IMM};             // ADDI x4, x0, 1
    initial mem[0001] = {12'd1, 5'd3, `F3_ADDI,  5'd3, `OP_OP_IMM};             // ADDI x3, x3, 1   <-
    initial mem[0002] = {20'd0,  5'd2, `OP_AUIPC};                              // AUIPC  x2, 0       |
    initial mem[0003] = {-12'sd4, 5'd2, 3'b0,  5'd1, `OP_JALR};                 // JALR x1, x2, -4  --
    initial mem[0004] = `I_NOP;
    initial mem[0005] = `I_NOP;
    initial mem[0006] = `I_NOP;
    initial mem[0007] = `I_NOP;
    initial mem[0008] = `I_NOP;
    initial mem[0009] = `I_NOP;
    initial mem[0010] = `I_NOP;
    initial mem[0011] = `I_NOP;
    initial mem[0012] = `I_NOP;
    initial mem[0013] = `I_NOP;
    initial mem[0014] = `I_NOP;
    initial mem[0015] = `I_NOP;
    initial mem[0016] = `I_NOP;
    initial mem[0017] = `I_NOP;
    initial mem[0018] = `I_NOP;
    initial mem[0019] = `I_NOP;
    initial mem[0020] = `I_NOP;
    
endmodule
