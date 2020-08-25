// I-type OP-IMM
`define OP_OP_IMM  7'b0010011
`define F3_ADDI    3'b000

`define I_NOP      {12'b0, 5'b0, `F3_ADDI, 5'b0, `OP_OP_IMM}   // ADDI x0, x0, 0

// J-type
`define OP_JAL     7'b1101111

// B-type
`define OP_BRANCH  7'b1100011
`define F3_BEQ     3'b000
`define F3_BNE     3'b001
`define F3_BLT     3'b100
`define F3_BGE     3'b101
`define F3_BLTU    3'b110
`define F3_BGEU    3'b111
