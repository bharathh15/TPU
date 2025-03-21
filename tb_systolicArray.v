`timescale 1ns / 1ps

module tb_systolicArray;

    // Inputs
    reg clk;
    reg rst_n;
    reg en;
    reg [7:0] A_W0, A_W1, A_W2;
    reg [7:0] B_N0, B_N1, B_N2;

    // Outputs
    wire [143:0] Z;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    systolicArray uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .A_W0(A_W0),
        .A_W1(A_W1),
        .A_W2(A_W2),
        .B_N0(B_N0),
        .B_N1(B_N1),
        .B_N2(B_N2),
        .Z(Z),
        .done(done)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        // Dumping the waveform to VCD file
        $dumpfile("systolicArray_tb.vcd");
        $dumpvars(0, tb_systolicArray);
    end
                
        initial begin
           
            #3  A_W0 <= 8'd3;
                B_N0 <= 8'd12;
            #10 A_W0 <= 8'd2;
                B_N0 <= 8'd8;
            #10 A_W0 <= 8'd1;
                B_N0 <= 8'd4;
            #10 A_W0 <= 8'd0;
                B_N0 <= 8'd0;
            #10 A_W0 <= 8'd0;
                B_N0 <= 8'd0;
           
            
        end

        initial begin
            #3  A_W1 <= 8'd0;
                B_N1 <= 8'd0;
            #10 A_W1 <= 8'd2;
                B_N1 <= 8'd8;
            #10 A_W1 <= 8'd1;
                B_N1 <= 8'd4;
            #10 A_W1 <= 8'd3;
                B_N1 <= 8'd6;
            #10 A_W1 <= 8'd0;
                B_N1 <= 8'd0;
        end

        initial begin
            #3  A_W2 <= 8'd0;
                B_N2 <= 8'd0;
            #10 A_W2 <= 8'd0;
                B_N2 <= 8'd0;
            #10 A_W2 <= 8'd1;
                B_N2 <= 8'd4;
            #10 A_W2 <= 8'd3;
                B_N2 <= 8'd6;
            #10 A_W2 <= 8'd2;
                B_N2 <= 8'd8;
        end


        initial begin
        en <= 0;
        rst_n <= 0;
        clk <= 0;
        #10
        rst_n <= 1;
        en <= 1;
        end

        initial begin
            // Some simulation tasks
            #500 $finish; // End simulation after 100 time units
          end
initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0, tb_systolicArray);
end
    

endmodule
