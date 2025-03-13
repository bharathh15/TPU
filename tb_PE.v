`timescale 1ns / 1ps

module tb_PE;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter ACC_WIDTH  = 16;

    // Testbench signals
    reg                   clk;
    reg                   rst_n;
    reg                   en;
    reg  [DATA_WIDTH-1:0] A_in;
    reg  [DATA_WIDTH-1:0] B_in;
    wire [DATA_WIDTH-1:0] A_out;
    wire [DATA_WIDTH-1:0] B_out;
    wire [ACC_WIDTH-1:0]  C_out;

    // Instantiate the PE module
    PE uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .A_in(A_in),
        .B_in(B_in),
        .A_out(A_out),
        .B_out(B_out),
        .C_out(C_out)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk   = 0;
        rst_n = 0;
        en    = 0;
        A_in  = 0;
        B_in  = 0;

        // Reset pulse
        #10;
        rst_n = 1;

        // Wait a cycle
        #10;

        // Enable PE and apply inputs
        en = 1;

        // Test vector 1
        A_in = 8'd3;  // A = 3
        B_in = 8'd4;  // B = 4
        #10;          // Wait for 1 clock

        // Test vector 2
        A_in = 8'd2;  // A = 2
        B_in = 8'd5;  // B = 5
        #10;          // Wait for 1 clock

        // Test vector 3
        A_in = 8'd1;  // A = 1
        B_in = 8'd6;  // B = 6
        #10;          // Wait for 1 clock

        // Test vector 4
        A_in = 8'd0;  // A = 0 (end of data)
        B_in = 8'd0;  // B = 0
        #10;          // Wait for 1 clock

        // Disable PE
        en = 0;

        // Wait for a few more cycles to observe outputs
        #20;

        // Finish simulation
        $finish;
    end

    // Monitor for debug (optional console output)
    initial begin
        $monitor("Time = %0t | A_in = %d, B_in = %d | A_out = %d, B_out = %d | C_out = %d", 
                  $time, A_in, B_in, A_out, B_out, C_out);
    end

    // VCD Dump for waveform viewing
    initial begin
        $dumpfile("tb_PE.vcd");   // Name of VCD file to generate
        $dumpvars(0, tb_PE);     // Dump all variables in this module (recursive)
    end

endmodule
