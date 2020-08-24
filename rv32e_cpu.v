`timescale 1ns / 1ps

// // Opcodes
// `define ADD_REG  6'b000000
// `define MUL      6'b000010
// `define MOV      6'b000100
// `define NOP      6'b000111
// `define LD_IMM   6'b100000
// `define CMP_IMM  6'b100011
// `define DEC      6'b100101
// `define INPUT    6'b100110
// `define OUTPUT   6'b100111
// `define BRA      6'b101010
// `define BHI      6'b101100
// `define BEQ      6'b101101

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
    // registers
    reg [31:0] x [15:0];    // RV32E has 16 registers (x0-x15)
    reg [31:0] pc;

    // wiring
    assign mem_program_addr_bus = pc;

    // state machine
    reg [3:0]  state;
    reg [31:0] inst;

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
                    state <= `ST_EXECUTE;
                end
                `ST_EXECUTE: begin
                    state <= `ST_WRITE_BACK;
                end
                `ST_WRITE_BACK: begin
                    pc <= pc + 1;
                    state <= `ST_FETCH;
                end
            endcase
        end
    end

endmodule
