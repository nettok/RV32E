`timescale 1ns / 1ps

`include "instructions.v"

module program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [99:0];
    assign data_bus = mem[addr_bus/4];  // byte-addressable with forced 32-bit aligned access

    // int sum(int num1, int num2) {
    //     return num1 + num2;
    // }
    //
    // int main() {
    //     int o = sum(3, 4);
    // }

    initial mem[0000] = {12'd100, 5'd0, `F3_ADDI, 5'd2, `OP_OP_IMM};            // ADDI sp, x0, 100     ; initialize stack pointer  (sp = x2)
    initial mem[0001] = {12'd3, 5'd0, `F3_ADDI, 5'd10, `OP_OP_IMM};             // ADDI a0, x0, 3       ; main:                     (a0 = x10)
    initial mem[0002] = {12'd4, 5'd0, `F3_ADDI, 5'd11, `OP_OP_IMM};             // ADDI a1, x0, 4                                   (a1 = x11)
    initial mem[0003] = {20'd20, 5'd1, `OP_JAL};                                // JAL  ra, 20 (10 instructions down) (mem[0013])   (ra = x1)
    initial mem[0004] = {7'd0, 5'd10, 5'd0, `F3_SW, 5'd4, `OP_STORE};           // SW   a0, 4           ; output result
    initial mem[0005] = {20'd0, 5'd0, `OP_JAL};                                 // infinite loop (halt)
    initial mem[0006] = `I_NOP;
    initial mem[0007] = `I_NOP;
    initial mem[0008] = `I_NOP;
    initial mem[0009] = `I_NOP;
    initial mem[0010] = `I_NOP;
    initial mem[0011] = `I_NOP;
    initial mem[0012] = `I_NOP;
    initial mem[0013] = {-12'sd4, 5'd2, `F3_ADDI, 5'd2, `OP_OP_IMM};            // ADDI sp, sp, -4      ; sum:  (reserve stack)
    initial mem[0014] = {7'b0, 5'd1, 5'd2, `F3_SW, 5'b0, `OP_STORE};            // SW   ra, 0(sp)       ; store ra in the stack
    initial mem[0015] = {`F7_30_0, 5'd11, 5'd10, `F3_ADD, 5'd10, `OP_OP};       // ADD  a0, a0, a1
    initial mem[0016] = {12'b0, 5'd2, `F3_LW, 5'd1, `OP_LOAD};                  // LW   ra, 0(sp)       ; restore ra from stack
    initial mem[0017] = {12'd4, 5'd2, `F3_ADDI, 5'd2, `OP_OP_IMM};              // ADDI sp, sp, 4       ; free stack
    initial mem[0018] = {12'd0, 5'd1, 3'b0,  5'd0, `OP_JALR};                   // RET
    initial mem[0019] = `I_NOP;
    initial mem[0020] = `I_NOP;
    
endmodule
