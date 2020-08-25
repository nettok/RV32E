`timescale 1ns / 1ps

`include "instructions.v"

module mem_program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [512:0];
    assign data_bus = mem[addr_bus/4];

    initial mem[0000] = {12'b1, 5'b0, `F3_ADDI, 5'b1, `OP_IMM};     // ADDI x1, x0, 1
    initial mem[0001] = {12'b1, 5'b1, `F3_ADDI, 5'b1, `OP_IMM};     // ADDI x1, x1, 1
    initial mem[0002] = {12'b1, 5'b1, `F3_ADDI, 5'b1, `OP_IMM};     // ADDI x1, x1, 1
    initial mem[0003] = `I_NOP;
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
