`timescale 1ns / 1ps

module mem_program_rom(
    input  [31:0] addr_bus,
    output [31:0] data_bus
);

    reg [31:0] mem [512:0];
    assign data_bus = mem[addr_bus];

    initial mem[0000] = 'b0;
    initial mem[0001] = 'b0;
    initial mem[0002] = 'b0;
    initial mem[0003] = 'b0;
    initial mem[0004] = 'b0;
    initial mem[0005] = 'b0;
    initial mem[0006] = 'b0;
    initial mem[0007] = 'b0;
    initial mem[0008] = 'b0;
    initial mem[0009] = 'b0;
    initial mem[0010] = 'b0;
    initial mem[0011] = 'b0;
    initial mem[0012] = 'b0;
    initial mem[0013] = 'b0;
    initial mem[0014] = 'b0;
    initial mem[0016] = 'b0;
    initial mem[0017] = 'b0;
    initial mem[0018] = 'b0;
    initial mem[0019] = 'b0;
    initial mem[0020] = 'b0;
endmodule
