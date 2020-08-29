`timescale 1ns / 1ps

`include "instructions.v"

module program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [99:0];
    assign data_bus = mem[addr_bus/4];  // byte-addressable with forced 32-bit aligned access

    initial mem[0000] = {12'b1, 5'd0, `F3_ORI,  5'd7, `OP_OP_IMM};
    initial mem[0001] = `I_NOP;
    initial mem[0002] = {12'b0, 5'd0, `F3_LW, 5'd8, `OP_LOAD};          // x8 = input (7)
    initial mem[0003] = {7'b0, 5'd7, 5'd0, `F3_SW, 5'd4, `OP_STORE};    // posedge output[0]
    initial mem[0004] = {7'b0, 5'd0, 5'd0, `F3_SW, 5'd4, `OP_STORE};
    initial mem[0005] = `I_NOP;
    initial mem[0006] = {12'b0, 5'd0, `F3_LW, 5'd9, `OP_LOAD};          // x9 = input (9)
    initial mem[0007] = {7'b0, 5'd7, 5'd0, `F3_SW, 5'd4, `OP_STORE};    // posedge output[0]
    initial mem[0008] = {7'b0, 5'd0, 5'd0, `F3_SW, 5'd4, `OP_STORE};
    initial mem[0009] = `I_NOP;
    initial mem[0010] = {`F7_30_1, 5'd8, 5'd9, `F3_SUB, 5'd10, `OP_OP}; // x10 = x9 - x8
    initial mem[0011] = {7'b0, 5'd10, 5'd0, `F3_SW, 5'd4, `OP_STORE};   // output = x10
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
