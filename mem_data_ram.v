`timescale 1ns / 1ps

module mem_data_ram(
    input  [31:0] addr_bus,
    
    input [31:0] write_data_bus,
    input write_signal,

    output [31:0] read_data_bus,

    // memory-mapped IO ports
    input  [7:0] i,
    output [7:0] o
);

    reg [7:0] mem [99:0];
    assign read_data_bus = {mem[addr_bus], mem[addr_bus+1], mem[addr_bus+2], mem[addr_bus+3]};   // byte-addressable with 32-bit bus

    always @(posedge write_signal) begin
        mem[addr_bus]   <= write_data_bus[31:24];
        mem[addr_bus+1] <= write_data_bus[23:16];
        mem[addr_bus+2] <= write_data_bus[15:8];
        mem[addr_bus+3] <= write_data_bus[7:0];
    end

    // memory-mapped IO registers (word 0) (input-only)
    initial mem[0] = 0;    // reserved
    initial mem[1] = 0;    // reserved
    initial mem[2] = 0;    // reserved
    initial mem[3] = i;

    always @(i[7]) mem[3][7] <= i[7];
    always @(i[6]) mem[3][6] <= i[6];
    always @(i[5]) mem[3][5] <= i[5];
    always @(i[4]) mem[3][4] <= i[4];
    always @(i[3]) mem[3][3] <= i[3];
    always @(i[2]) mem[3][2] <= i[2];
    always @(i[1]) mem[3][1] <= i[1];
    always @(i[0]) mem[3][0] <= i[0];

    // memory-mapped IO registers (word 1) (output-only)
    initial mem[4] = 0;    // reserved
    initial mem[5] = 0;    // reserved
    initial mem[6] = 0;    // reserved
    initial mem[7] = 0;    // wired to "o"

    assign o = mem[7];
    
    // user memory (heap) (from word 2)
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
    initial mem[81] = 0;
    initial mem[82] = 0;
    initial mem[83] = 0;

    initial mem[84] = 0;
    initial mem[85] = 0;
    initial mem[86] = 0;
    initial mem[87] = 0;

    initial mem[88] = 0;
    initial mem[89] = 0;
    initial mem[90] = 0;
    initial mem[91] = 0;

    initial mem[92] = 0;
    initial mem[93] = 0;
    initial mem[94] = 0;
    initial mem[95] = 0;

    initial mem[96] = 0;
    initial mem[97] = 0;
    initial mem[98] = 0;
    initial mem[99] = 0;

    // Stack pointer initial position (word 25) (grows to lower memory addresses ^)

    always @(mem[96], mem[97], mem[98], mem[99]) begin
        // debug, delete later
        $display("First stack value: %d", {mem[96], mem[97], mem[98], mem[99]});
    end

endmodule
