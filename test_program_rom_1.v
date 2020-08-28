`timescale 1ns / 1ps

`include "instructions.v"

module program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [99:0];
    assign data_bus = mem[addr_bus/4];  // byte-addressable with forced 32-bit aligned access

    initial mem[0000] = {12'd3, 5'd0, `F3_ORI,  5'd1, `OP_OP_IMM};                  // ORI  x1, x0, 3
    initial mem[0001] = {12'd4, 5'd1, `F3_SLTI, 5'd2, `OP_OP_IMM};                  // SLTI x2, x1, 4   (x2 = 3 < 4 = 1)
    initial mem[0002] = {12'd3, 5'd1, `F3_SLTI, 5'd3, `OP_OP_IMM};                  // SLTI x3, x1, 3   (x3 = 3 < 3 = 0)
    initial mem[0003] = {12'd2, 5'd1, `F3_SLTI, 5'd4, `OP_OP_IMM};                  // SLTI x4, x1, 2   (x4 = 3 < 2 = 0)
    initial mem[0004] = {12'd5, 5'd1, `F3_SLTI, 5'd5, `OP_OP_IMM};                  // SLTI x5, x1, 5   (x5 = 3 < 5 = 1)
    initial mem[0005] = {-12'sd1, 5'd1, `F3_SLTI,  5'd6, `OP_OP_IMM};               // SLTI x6, x1, -1  (x6 = 3 < -1 = 0)
    initial mem[0006] = {-12'sd1, 5'd1, `F3_SLTIU, 5'd7, `OP_OP_IMM};               // SLTI x7, x1, -1  (x6 = 3 < unsigned(-1) = 1)
    initial mem[0007] = `I_NOP;
    initial mem[0008] = {12'b111111111111, 5'd0, `F3_ORI,  5'd9, `OP_OP_IMM};       // ORI  x9, x0, 0b111111111111
    initial mem[0009] = {12'b101010101010, 5'd9, `F3_XORI,  5'd10, `OP_OP_IMM};     // XORI x10, x9, 0b101010101010
    initial mem[0010] = {12'b101010101010, 5'd9, `F3_ANDI,  5'd11, `OP_OP_IMM};     // ANDI x11, x9, 0b101010101010
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
