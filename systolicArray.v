            module systolicArray#(
                parameter N = 3,
                parameter DATA_WIDTH = 8  ,
                parameter ACC_WIDTH  = 16 
            )(

                input               clk,
                input               rst_n,
                input               en,

                input               [DATA_WIDTH-1:0]  A_W0,
                input               [DATA_WIDTH-1:0]  A_W1,
                input               [DATA_WIDTH-1:0]  A_W2,
                input               [DATA_WIDTH-1:0]  B_N0,
                input               [DATA_WIDTH-1:0]  B_N1,
                input               [DATA_WIDTH-1:0]  B_N2,
                output reg          [N*N*ACC_WIDTH - 1:0] Z,
                output reg          done
            );
                



            reg [7:0]  activation [0:5];
            always @(posedge clk) begin

                activation [0] <= A_W0;
                activation [1] <= A_W1;
                activation [2] <= A_W2;
                activation [3] <= B_N0;
                activation [4] <= B_N1;
                activation [5] <= B_N2;

            end


            // wire [DATA_WIDTH-1:0] A_East    [0:N-1][0:N-1];
            // wire [DATA_WIDTH-1:0] B_South   [0:N-1][0:N-1];
            // wire [ACC_WIDTH-1 :0] Z         [0:N-1][0:N-1];

            wire [7:0] A0_East, A1_East, A3_East, A4_East, A6_East, A7_East;
            wire [7:0] B0_South, B1_South, B2_South, B3_South, B4_South, B5_South;
            wire [15:0] Z00, Z01, Z02, Z10, Z11, Z12, Z20, Z21, Z22 ;
            reg [3:0] count;



            // genvar i,j;

    // // Generate for loop to instantiate N times
    // generate
    //     for (i = 0; i < N; i = i + 1) begin :ROW
    //       for (j = 0; j < N; j = j + 1) begin :COLUMN
    //         .clk        (clk),
    //         .rst_n      (rst_n),
    //         .en         (en),
    //         .A_in       (activation [0]),  
    //         .B_in       (activation [3]),
    //         .A_out      (A0_East),
    //         .B_out      (B0_South),
    //         .C_out      (Z00)
    //       end
    //     end
    // endgenerate




                PE PE00(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    //.A_in   (A_W0),
                    //.B_in   (B_N0),
                    .A_in     (activation [0]),  
                    .B_in     (activation [3]),
                    .A_out  (A0_East),
                    .B_out  (B0_South),
                    .C_out  (Z00)

                );

                PE PE01(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    .A_in   (A0_East),
                    //.B_in   (B_N1),  
                    .B_in     (activation [4]),
                    .A_out  (A1_East),
                    .B_out  (B1_South),
                    .C_out  (Z01)
                    
                );

                PE PE02(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    .A_in   (A1_East),
                    //.B_in   (B_N2),
                    //.A_in     (activation [0]),  
                    .B_in     (activation [5]),
                    .A_out  (),
                    .B_out  (B2_South),
                    .C_out  (Z02)
                    
                );

                PE PE10(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    //.A_in   (A_W1),
                    .A_in     (activation [1]),  
                    .B_in   (B1_South),
                    .A_out  (A3_East),
                    .B_out  (B3_South),
                    .C_out  (Z10)
                    
                );

                PE PE11(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    .A_in   (A3_East),
                    .B_in   (B1_South),
                    .A_out  (A4_East),
                    .B_out  (B4_South),
                    .C_out  (Z11)
                    
                );


                PE PE12(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    .A_in   (A4_East),
                    .B_in   (B2_South),
                    .A_out  (),
                    .B_out  (B5_South),
                    .C_out  (Z12)
                    
                );


                PE PE20(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    //.A_in   (A_W2),
                    .A_in     (activation [2]),  
                    .B_in   (B3_South),
                    .A_out  (A6_East),
                    .B_out  (),
                    .C_out  (Z20)
                    
                );

                PE PE21(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    .A_in   (A6_East),
                    .B_in   (B4_South),
                    .A_out  (A7_East),
                    .B_out  (),
                    .C_out  (Z21)
                    
                );

                PE PE22(

                    .clk    (clk),
                    .rst_n  (rst_n),
                    .en     (en),
                    .A_in   (A7_East),
                    .B_in   (B5_South),
                    .A_out  (),
                    .B_out  (),
                    .C_out  (Z22)
                    
                );

                //assign Z = { Z00, Z01, Z02, Z10, Z11, Z12, Z20, Z21, Z22};

                always @(posedge clk) begin
                    if(!rst_n) begin
                        done  <= 0;
                        count <= 0;
                    end else begin
                        if(count == 5) begin
                            done <=1;
                            count <= 0;

                        end else begin
                            count <= count +1;
                        end
                    end
                end
                endmodule

