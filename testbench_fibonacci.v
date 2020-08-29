`timescale 1ns / 1ps

`include "rv32e_soc.v"
`include "test_program_rom_fibonacci.v"

module testbench;
    reg  clk;
    reg  reset;

    wire [31:0] program_addr_bus;
    wire [31:0] program_data_bus;

    reg [7:0] i, o;

    rv32e_soc rv32e_soc0(
        .clk(clk),
        .reset(reset),
        .program_addr_bus(program_addr_bus),
        .program_data_bus(program_data_bus),
        .i(i), .o(o)
    );

    program_rom program_rom0(
        .addr_bus(program_addr_bus),
        .data_bus(program_data_bus)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("rv32e_testbench_fibonacci.vcd");
        $dumpvars();
        clk = 0;
        reset = 1;
        #10

        i = 1;
        reset = 0; #10 reset = 1;
        wait(o != 0);
        $display("fibonacci(1) = %02d  [%s]", o, o == 1 ? "OK" : "ER");
        i = 0;
        #100

        i = 3;
        reset = 0; #10 reset = 1;
        wait(o != 0);
        $display("fibonacci(3) = %02d  [%s]", o, o == 2 ? "OK" : "ER");
        i = 0;
        #100

        i = 5;
        reset = 0; #10 reset = 1;
        wait(o != 0);
        $display("fibonacci(5) = %02d  [%s]", o, o == 5 ? "OK" : "ER");
        i = 0;
        #100
        
        i = 8;
        reset = 0; #10 reset = 1;
        wait(o != 0);
        $display("fibonacci(8) = %02d  [%s]", o, o == 21 ? "OK" : "ER");
        i = 0;
        #100

        $finish;
    end

endmodule
