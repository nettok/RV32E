`timescale 1ns / 1ps

`include "instructions.v"

module program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [99:0];
    assign data_bus = mem[addr_bus/4];  // byte-addressable with forced 32-bit aligned access

    // int fibonacci(int n) {
    //     int a = 0, b = 1, next = 0;
    //     if (n < 2)
    //         return n;
    //     while (n--) {
    //         next = a + b;
    //         a = b;
    //         b = next;
    //     }
    //     return a;
    // }
    //
    // int main() {
    //     int i = 5;              // FROM I/O
    //     int o = fibonacci(i);   // TO I/O
    // }

    initial mem[0000] = {12'd100, 5'd0, `F3_ADDI, 5'd2, `OP_OP_IMM};                //              ADDI sp, x0, 100    ; initialize stack pointer  (sp = x2)
    initial mem[0001] = {12'b0, 5'd0, `F3_LW, 5'd10, `OP_LOAD};                     // main:        LW   a0, 0          ;                           (a0 = x10)
    initial mem[0002] = {20'd8, 5'd1, `OP_JAL};                                     //              CALL fibonacci(n) (4 instructions down) (mem[0006])  (ra = x1)
    initial mem[0003] = {7'd0, 5'd10, 5'd0, `F3_SW, 5'd4, `OP_STORE};               //              SW   a0, 4          ; output result
    initial mem[0004] = {20'd0, 5'd0, `OP_JAL};                                     //              infinite loop (halt)
    initial mem[0005] = `I_NOP; 
    initial mem[0006] = {-12'sd4, 5'd2, `F3_ADDI, 5'd2, `OP_OP_IMM};                // fibonacci:   ADDI sp, sp, -4     ; reserve stack
    initial mem[0007] = {7'b0, 5'd1, 5'd2, `F3_SW, 5'b0, `OP_STORE};                //              SW   ra, 0(sp)      ; store ra in the stack
    initial mem[0008] = {12'd2, 5'd0, `F3_ADDI, 5'd5, `OP_OP_IMM};                  //              ADDI t0, x0, 2                                  (t0 = x5)
    initial mem[0009] = {7'd0, 5'd5, 5'd10, `F3_BGE, 5'd6, `OP_BRANCH};             //              BGE  a0, t0, 6 (3 instructions down) continue
    initial mem[0010] = {`F7_30_0, 5'd0, 5'd10, `F3_ADD, 5'd5, `OP_OP};             //              MOV  t0, a0
    initial mem[0011] = {20'd16, 5'd0, `OP_JAL};                                    //              J return(16) (8 intructions down) (to mem[0017])
    initial mem[0012] = {12'd0, 5'd0, `F3_ADDI, 5'd5, `OP_OP_IMM};                  // continue:    ADDI t0, x0, 0      ; a = 0                     (t0 = x5)
    initial mem[0013] = {12'd1, 5'd0, `F3_ADDI, 5'd6, `OP_OP_IMM};                  //              ADDI t1, x0, 1      ; b = 1                     (t1 = x6)
    initial mem[0014] = {`F7_30_0, 5'd5, 5'd6, `F3_ADD, 5'd7, `OP_OP};              // loop:        ADD  t2, t0, t1     ; next = a + b              (t2 = x7)
    initial mem[0015] = {`F7_30_0, 5'd0, 5'd6, `F3_ADD, 5'd5, `OP_OP};              //              MOV  t0, t1         ; a = b
    initial mem[0016] = {`F7_30_0, 5'd0, 5'd7, `F3_ADD, 5'd6, `OP_OP};              //              MOV  t1, t2         ; b = next
    initial mem[0017] = {-12'sd1, 5'd10, `F3_ADDI, 5'd10, `OP_OP_IMM};              //              ADDI a0, a0, -1
    initial mem[0018] = {7'b1111111, 5'd0, 5'd10, `F3_BNE, -5'sd8, `OP_BRANCH};     //              BNE  a0, x0, -8 (to mem[0014]) loop
    initial mem[0019] = {`F7_30_0, 5'd0, 5'd5, `F3_ADD, 5'd10, `OP_OP};             // return:      MOV  a0, t0         ; ret = t0
    initial mem[0020] = {12'b0, 5'd2, `F3_LW, 5'd1, `OP_LOAD};                      //              LW   ra, 0(sp)      ; restore ra from stack
    initial mem[0021] = {12'd4, 5'd2, `F3_ADDI, 5'd2, `OP_OP_IMM};                  //              ADDI sp, sp, 4      ; free stack
    initial mem[0022] = {12'd0, 5'd1, 3'b0,  5'd0, `OP_JALR};                       //              RET
    
endmodule
