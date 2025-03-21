module PE (
    input               clk,
    input               rst_n,
    input               en,
    input  [7:0]        A_in,
    input  [7:0]        B_in,
    
    output reg          done,
    output reg          start,
    output reg [7:0]    A_out,   // Correct: declare as reg because assigned in always block
    output reg [7:0]    B_out,   // Correct: declare as reg because assigned in always block
    output reg [15:0]   C_out    // Correct: declare as reg to hold result
);

    // Internal registers
    //reg [7:0]   A_reg;
    //reg [7:0]   B_reg;
    reg [15:0]  product;
    reg [15:0]  accumulate;

    always @(posedge clk ) begin
        if (!rst_n) begin
          //  A_reg <= 0;
          //  B_reg <= 0;
            product <= 0;
            accumulate   <= 0;
            A_out <= 0;
            B_out <= 0;
            C_out <= 0;
            start <= 0;
            done  <= 0;
           

        end else if (en) begin
        
            //A_reg <= A_in;
            //B_reg <= B_in;

            // Multiply and accumulate
            start <= 1;
            product <=  (A_in * B_in);
            accumulate <= accumulate + product;
            
            
            // Pass registered A and B to next PE
            A_out <= A_in;
            B_out <= B_in;

            // Output accumulated result
            C_out <= accumulate;
            start <=0;
        end
    end

endmodule
