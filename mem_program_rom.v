`timescale 1ns / 1ps

`include "instructions.v"

module mem_program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [511:0];
    assign data_bus = mem[addr_bus/4];  // byte-addressable with forced 32-bit aligned access

    initial mem[0000] = {12'b0, 5'b00, `F3_LW, 5'd5, `OP_LOAD};                     // LW x5, x0, 0
    initial mem[0001] = {20'b1, 5'b10, `OP_LUI};                                    // LUI  x2, 1
    initial mem[0002] = {12'b1, 5'b10, `F3_ORI,  5'b10, `OP_OP_IMM};                // ORI  x2, x2, 1
    initial mem[0003] = {12'd3, 5'b00, `F3_ORI,  5'b11, `OP_OP_IMM};                // ORI  x3, x0, 3
    initial mem[0004] = {12'd1, 5'b00, `F3_ORI,  5'd4, `OP_OP_IMM};                 // ORI  x4, x0, 1
    initial mem[0005] = {`F7_SUB, 5'd4, 5'd3, `F3_SUB, 5'd3, `OP_OP};               // SUB  x3, x3, x4
    initial mem[0006] = {7'b1111111, 5'd4, 5'b11, `F3_BGE, 5'b11110, `OP_BRANCH};   // BGE  x3, x0, -2 (1 instruction up)
    initial mem[0007] = {12'b1, 5'b00, `F3_ADDI, 5'b01, `OP_OP_IMM};                // ADDI x1, x0, 1
    initial mem[0008] = {12'b1, 5'b01, `F3_ADDI, 5'b01, `OP_OP_IMM};                // ADDI x1, x1, 1
    initial mem[0009] = {7'b1111111, 5'b00, 5'b01, `F3_BLT, 5'b11110, `OP_BRANCH};  // BLT  x1, x0, -2 (1 instruction up)
    initial mem[0010] = {20'b11111111111111111100, 5'b00, `OP_JAL};                 // JAL  x0, -4 (2 instructions up)
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

    // initial mem[0000] = `I_NOP;
    // initial mem[0001] = `I_NOP;
    // initial mem[0002] = `I_NOP;
    // initial mem[0003] = `I_NOP;
    // initial mem[0004] = `I_NOP;
    // initial mem[0005] = `I_NOP;
    // initial mem[0006] = `I_NOP;
    // initial mem[0007] = `I_NOP;
    // initial mem[0008] = `I_NOP;
    // initial mem[0009] = `I_NOP;
    // initial mem[0010] = `I_NOP;
    // initial mem[0011] = `I_NOP;
    // initial mem[0012] = `I_NOP;
    // initial mem[0013] = `I_NOP;
    // initial mem[0014] = `I_NOP;
    // initial mem[0015] = `I_NOP;
    // initial mem[0016] = `I_NOP;
    // initial mem[0017] = `I_NOP;
    // initial mem[0018] = `I_NOP;
    // initial mem[0019] = `I_NOP;
    // initial mem[0020] = `I_NOP;
endmodule
