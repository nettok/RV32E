`timescale 1ns / 1ps

`include "instructions.v"

module program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [99:0];
    assign data_bus = mem[addr_bus/4];  // byte-addressable with forced 32-bit aligned access

    initial mem[0000] = {20'd12, 5'd1, `OP_AUIPC};                                  // AUIPC  x1, 0
    initial mem[0001] = {20'b0,  5'd2, `OP_AUIPC};                                  // AUIPC  x2, 0
    initial mem[0002] = {20'b0,  5'd3, `OP_AUIPC};                                  // AUIPC  x3, 0
    initial mem[0003] = `I_NOP;
    initial mem[0004] = {`F7_30_0, 5'd2, 5'd3, `F3_ADD, 5'd5, `OP_OP};              // ADD  x5, x3, x2
    initial mem[0005] = {`F7_30_1, 5'd2, 5'd3, `F3_SUB, 5'd6, `OP_OP};              // SUB  x6, x3, x2
    initial mem[0006] = {`F7_30_0, 5'd3, 5'd6, `F3_SLT, 5'd7, `OP_OP};              // SLT  x7, x6, x3
    initial mem[0007] = {`F7_30_0, 5'd0, 5'd7, `F3_XOR, 5'd8, `OP_OP};              // XOR  x8, x7, x0
    initial mem[0008] = {`F7_30_0, 5'd2, 5'd3, `F3_OR,  5'd9, `OP_OP};              // OR   x9, x3, x2
    initial mem[0009] = {`F7_30_0, 5'd5, 5'd9, `F3_AND, 5'd10, `OP_OP};             // AND  x10, x9, x5
    initial mem[0010] = {`F7_30_0, 5'd7, 5'd8, `F3_SLL, 5'd11, `OP_OP};             // SLL  x11, x8, x7
    initial mem[0011] = {`F7_30_0, 5'd7, 5'd11, `F3_SRL, 5'd12, `OP_OP};            // SRL  x12, x11, x7
    initial mem[0012] = {`F7_30_1, 5'd7, 5'd0, `F3_SUB, 5'd13, `OP_OP};             // SUB  x13, x0, x7
    initial mem[0013] = {`F7_30_1, 5'd7, 5'd13, `F3_SUB, 5'd13, `OP_OP};            // SUB  x13, x13, x7
    initial mem[0014] = {`F7_30_1, 5'd7, 5'd13, `F3_SRA, 5'd14, `OP_OP};            // SRA  x14, x13, x7
    initial mem[0015] = `I_NOP;
    initial mem[0016] = `I_NOP;
    initial mem[0017] = `I_NOP;
    initial mem[0018] = `I_NOP;
    initial mem[0019] = `I_NOP;
    initial mem[0020] = `I_NOP;
    
endmodule
