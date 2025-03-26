module PE (
    input               clk,
    input               rst_n,
    input               en,
    input  [7:0]        A_in,
    input  [7:0]        B_in,
    
    output reg          done,
    output reg          start,
    output reg [7:0]    A_out,
    output reg [7:0]    B_out,
    output reg [15:0]   C_out
);

    parameter IDLE    = 2'b00;
    parameter READ    = 2'b01;
    parameter COMPUTE = 2'b10;
    parameter DONE    = 2'b11;

    reg [1:0] CurrentState, NextState;
    reg [7:0] A_reg, B_reg;
    reg [15:0]  product;
    reg [15:0]  accumulate;
    reg finish;

    // State Transition
    always @(posedge clk) begin
        if (!rst_n) begin
            CurrentState <= IDLE;
        end else begin
            CurrentState <= NextState;
        end
    end

    // State Logic
    always @(*) begin
        case (CurrentState)
            IDLE:
                if (en) begin
                    NextState <= READ;
                end else begin
                    NextState = IDLE;
                end

            READ:
                NextState = COMPUTE;

            COMPUTE:
                if (finish) begin
                    NextState = DONE;
                end else begin
                    NextState = COMPUTE;    
                end

            DONE:
                     NextState = IDLE;

            default:
                NextState = IDLE;
        endcase
    end

    // Output and Register Logic
    always @(posedge clk) begin
        if (!rst_n) begin
            product <= 0;
            accumulate <= 0;
            A_out <= 0;
            B_out <= 0;
            C_out <= 0;
            start <= 0;
            done <= 0;
            finish <= 0;
        end else begin
            case (CurrentState)
                IDLE: begin
                    start <= 1;
                    done <= 0;
                    finish <= 0; // Reset for next operation
                end

                READ: begin
                    start <= 0;
                    A_reg <= A_in;
                    B_reg <= B_in;
                end

                COMPUTE: begin
                    if(!finish) begin
                    product <= (A_reg * B_reg);
                    accumulate <= accumulate + product;
                    finish <= 1;
                    end
                    
                end

                DONE: begin
                    A_out <= A_reg;
                    B_out <= B_reg;
                    C_out <= accumulate;
                    done <= 1;
                    finish <= 0;  // Reset finish
                end

                default: begin
                    product <= 0;
                    accumulate <= 0;
                end
            endcase
        end
    end

endmodule

/*
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
*/

