`timescale 1ns / 1ps

`include "instructions.v"

// States
`define ST_FETCH        4'b0001
`define ST_DECODE       4'b0010
`define ST_EXECUTE      4'b0100
`define ST_WRITE_BACK   4'b1000

module rv32e_cpu(
    input clk,
    input reset,

    input  [31:0] mem_program_data_bus,
    output [31:0] mem_program_addr_bus

    // TODO
    // input  [31:0] mem_read_data_bus,
    // output [31:0] mem_write_data_bus,
    // output [31:0] mem_addr_bus
);
    // registers (RV32E has 16 registers (x0-x15))
    reg  [31:0] x [15:1];       // x1-x15 are general purpose  (x0 is defined below as it is hardwired to 0)
    reg  [31:0] pc;

    // registers wiring
    wire [31:0] x0 = 0;         // x0 is hardwired to 0

    wire [31:0] x1 = x[1];      // x1-x15 have wires for simulation visualization only
    wire [31:0] x2 = x[2];
    wire [31:0] x3 = x[3];
    wire [31:0] x4 = x[4];
    wire [31:0] x5 = x[5];
    wire [31:0] x6 = x[6];
    wire [31:0] x7 = x[7];
    wire [31:0] x8 = x[8];
    wire [31:0] x9 = x[9];
    wire [31:0] x10 = x[10];
    wire [31:0] x11 = x[11];
    wire [31:0] x12 = x[12];
    wire [31:0] x13 = x[13];
    wire [31:0] x14 = x[14];
    wire [31:0] x15 = x[15];

    assign mem_program_addr_bus = pc;

    // state machine
    reg [3:0]  state;
    reg [31:0] inst;

    /* instruction decoding wiring
     *
     * Some ranges are overlapped given that different instruction types use different instruction formats.
     */
    wire [6:0]  opcode   = inst[6:0];
    wire [4:0]  rd       = inst[11:7];                  // destination register
    wire [2:0]  funct3   = inst[14:12];
    wire [4:0]  rs1      = inst[19:15];                 // source register 1
    wire [4:0]  rs2      = inst[24:20];                 // source register 2
    wire [11:0] i_imm    = inst[31:20];                 // I-type immediate (IMM)
    wire [19:0] j_imm    = inst[31:12];                 // J-type immediate offset (JAL)
    wire [11:0] b_imm    = {inst[31:25], inst[11:7]};   // B-type immediate offset (BRANCH)

    /* internal memory
     *
     * Execution is simplified by decoding all instruction operand types into common 32-bits operands.
     */
    reg [31:0] operand1;
    reg [31:0] operand2;
    reg [31:0] result;
    reg [31:0] offset;

    // logic
    always @(posedge(clk)) begin
        $monitor("state=%d, pc=%03d, inst=%032b", state, pc, inst);
        if (reset == 0) begin
            state <= `ST_FETCH;
            pc    <= 0;
        end
        else begin
            case (state)
                `ST_FETCH: begin
                    inst <= mem_program_data_bus;
                    state <= `ST_DECODE;
                end
                `ST_DECODE: begin
                    case (opcode)
                        `OP_OP_IMM: begin
                            operand1 <= rs1 == 0 ? x0 : x[rs1];
                            if (funct3 == `F3_ADDI) begin
                                operand2 <= i_imm;
                            end
                        end
                        `OP_JAL: begin
                            // the J-immediate encodes a signed offset (20 bits) in multiples of 2 bytes,
                            // so we multiply the offset by 2 by shifting it 1-bit left, and leaving
                            // the sign bit in the MSB of the operand.
                            //
                            // We store the final offset (32 bits) and fill the remaining bits in the center with
                            // 0's or 1's depending on the sign of the offset. (2's complement encoding).
                            offset <= {j_imm[19], j_imm[19] == 0 ? 11'b0 : 11'b11111111111, j_imm[18:0], 1'b0};
                        end
                        `OP_BRANCH: begin
                            operand1 <= rs1 == 0 ? x0 : x[rs1];
                            operand2 <= rs2 == 0 ? x0 : x[rs2];
                            offset   <= {b_imm[11], b_imm[11] == 0 ? 19'b0 : 19'b1111111111111111111, b_imm[10:0], 1'b0};
                        end
                    endcase
                    state <= `ST_EXECUTE;
                end
                `ST_EXECUTE: begin
                    case (opcode)
                        `OP_OP_IMM: begin
                            if (funct3 == `F3_ADDI) begin
                                result <= operand1 + operand2;
                            end
                            state <= `ST_WRITE_BACK;
                        end
                        `OP_JAL: begin
                            if (rd != 0) x[rd] <= pc + 4;   // return address
                            pc <= pc + offset;
                            state <= `ST_FETCH;
                        end
                        `OP_BRANCH: begin
                            case (funct3)
                                `F3_BEQ: begin
                                    if (operand1 == operand2)
                                        pc <= pc + offset;
                                    else
                                        pc <= pc + 4;
                                end
                                `F3_BNE: begin
                                    if (operand1 != operand2)
                                        pc <= pc + offset;
                                    else
                                        pc <= pc + 4;
                                end
                                `F3_BLT: begin
                                    if ($signed(operand1) < $signed(operand2))
                                        pc <= pc + offset;
                                    else
                                        pc <= pc + 4;
                                end
                                `F3_BGE: begin
                                    if ($signed(operand1) >= $signed(operand2))
                                        pc <= pc + offset;
                                    else
                                        pc <= pc + 4;
                                end
                                `F3_BLTU: begin
                                    if (operand1 < operand2)
                                        pc <= pc + offset;
                                    else
                                        pc <= pc + 4;
                                end
                                `F3_BGEU: begin
                                    if (operand1 >= operand2)
                                        pc <= pc + offset;
                                    else
                                        pc <= pc + 4;
                                end
                            endcase
                            state <= `ST_FETCH;
                        end
                    endcase
                end
                `ST_WRITE_BACK: begin
                    case (opcode)
                        `OP_OP_IMM: begin
                            if (rd != 0) x[rd] <= result;
                        end
                    endcase
                    pc <= pc + 4;
                    state <= `ST_FETCH;
                end
            endcase
        end
    end

endmodule
