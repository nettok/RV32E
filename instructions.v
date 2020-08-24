`define OP_IMM  7'b0010011

`define F3_ADDI 3'b000

`define I_NOP   {12'b0, 5'b0, `F3_ADDI, 5'b0, `OP_IMM}     // ADDI x0, x0, 0