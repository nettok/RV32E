`timescale 1ns / 1ps

module mem_data_ram(
    input  [31:0] addr_bus,
    output [31:0] read_data_bus
);

    reg [7:0] mem [511:0];
    assign read_data_bus = {mem[addr_bus], mem[addr_bus+1], mem[addr_bus+2], mem[addr_bus+3]};   // byte-addressable with 32-bit bus

    initial mem[0] = 'hCA;
    initial mem[1] = 'hC0;
    initial mem[2] = 'hCA;
    initial mem[3] = 'hFE;
    initial mem[4] = 0;
    initial mem[5] = 0;
    initial mem[6] = 0;
    initial mem[7] = 0;
    initial mem[8] = 0;
    initial mem[9] = 0;
    initial mem[10] = 0;
    initial mem[11] = 0;
    initial mem[12] = 0;
    initial mem[13] = 0;
    initial mem[14] = 0;
    initial mem[15] = 0;
    initial mem[16] = 0;
    initial mem[17] = 0;
    initial mem[18] = 0;
    initial mem[19] = 0;
    initial mem[20] = 0;
    initial mem[21] = 0;
    initial mem[22] = 0;
    initial mem[23] = 0;
    initial mem[24] = 0;
    initial mem[25] = 0;
    initial mem[26] = 0;
    initial mem[27] = 0;
    initial mem[28] = 0;
    initial mem[29] = 0;
    initial mem[30] = 0;
    initial mem[31] = 0;
    initial mem[32] = 0;
    initial mem[33] = 0;
    initial mem[34] = 0;
    initial mem[35] = 0;
    initial mem[36] = 0;
    initial mem[37] = 0;
    initial mem[38] = 0;
    initial mem[39] = 0;
    initial mem[40] = 0;
    initial mem[41] = 0;
    initial mem[42] = 0;
    initial mem[43] = 0;
    initial mem[44] = 0;
    initial mem[45] = 0;
    initial mem[46] = 0;
    initial mem[47] = 0;
    initial mem[48] = 0;
    initial mem[49] = 0;
    initial mem[50] = 0;
    initial mem[51] = 0;
    initial mem[52] = 0;
    initial mem[53] = 0;
    initial mem[54] = 0;
    initial mem[55] = 0;
    initial mem[56] = 0;
    initial mem[57] = 0;
    initial mem[58] = 0;
    initial mem[59] = 0;
    initial mem[60] = 0;
    initial mem[61] = 0;
    initial mem[62] = 0;
    initial mem[63] = 0;
    initial mem[64] = 0;
    initial mem[65] = 0;
    initial mem[66] = 0;
    initial mem[67] = 0;
    initial mem[68] = 0;
    initial mem[69] = 0;
    initial mem[70] = 0;
    initial mem[71] = 0;
    initial mem[72] = 0;
    initial mem[73] = 0;
    initial mem[74] = 0;
    initial mem[75] = 0;
    initial mem[76] = 0;
    initial mem[77] = 0;
    initial mem[78] = 0;
    initial mem[79] = 0;
    initial mem[80] = 0;

endmodule
