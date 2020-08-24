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
    reg  [31:0] x [15:1];   // x1-x15 are general purpose  (x0 is defined below as it is hardwired to 0)
    reg  [31:0] pc;

    // wiring
    wire [31:0] x0;         // x0 is hardwired to 0
    assign x0 = 0;

    wire [31:0] x1;         // x1-x15 have wires for simulation visualization only
    wire [31:0] x2;
    wire [31:0] x3;
    wire [31:0] x4;
    wire [31:0] x5;
    wire [31:0] x6;
    wire [31:0] x7;
    wire [31:0] x8;
    wire [31:0] x9;
    wire [31:0] x10;
    wire [31:0] x11;
    wire [31:0] x12;
    wire [31:0] x13;
    wire [31:0] x14;
    wire [31:0] x15;

    assign x1 = x[1];
    assign x2 = x[2];
    assign x3 = x[3];
    assign x4 = x[4];
    assign x5 = x[5];
    assign x6 = x[6];
    assign x7 = x[7];
    assign x8 = x[8];
    assign x9 = x[9];
    assign x10 = x[10];
    assign x11 = x[11];
    assign x12 = x[12];
    assign x13 = x[13];
    assign x14 = x[14];
    assign x15 = x[15];
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
