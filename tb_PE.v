`timescale 1ns / 1ps

module PE_tb;

    reg clk;
    reg rst_n;
    reg en;
    reg [7:0] A_in, B_in;
    
    wire done, start;
    wire [7:0] A_out, B_out;
    wire [15:0] C_out;
    
    // Instantiate PE module
    PE uut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .A_in(A_in),
        .B_in(B_in),
        .done(done),
        .start(start),
        .A_out(A_out),
        .B_out(B_out),
        .C_out(C_out)
    );

    // Clock generation (50MHz)
    always #10 clk = ~clk;  // 20ns period

    // Stimulus
    initial begin
        $dumpfile("PE_tb.vcd");
        $dumpvars(0, PE_tb);

        clk = 0;
        rst_n = 0;
        en = 0;
        A_in = 0;
        B_in = 0;

        #20;
        rst_n = 1;
        #10;

         
        en = 1;
        A_in = 8'd5;
        B_in = 8'd8;
        #20;  
        wait(done); 

        #10;         

        
        A_in = 8'd2;
        B_in = 8'd5;
        #20;
        wait(done);
        #10;

        A_in = 8'd255;
        B_in = 8'd255;
        #20;
        wait(done);
        #10;
        A_in = 8'd8;
        B_in = 8'd7;
        #20;
        wait(done);
        #10;
        A_in = 8'd4;
        B_in = 8'd5;
        #20;
        wait(done);
        #10;
        A_in = 8'd29;
        B_in = 8'd121;
        #20;
        wait(done);
        #10;
        A_in = 8'd69;
        B_in = 8'd16;
        #20;
        wait(done);
        #10;
        A_in = 8'd120;
        B_in = 8'd255;
        #20;
        wait(done);
        #10;
        A_in = 8'd147;
        B_in = 8'd51;
        #20;
        wait(done);
        #10;
        A_in = 8'd120;
        B_in = 8'd129;
        #20;
        wait(done);
        #10;
        A_in = 8'd221;
        B_in = 8'd237;
        #20;
        wait(done);
        #10;

       
        // Final wait
        #100;
        en =0;
        $finish;
    end

endmodule
