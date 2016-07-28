`ifndef sigmoid
`define sigmoid

`ifndef  TEST_BENCH
  `include "config.v"
`endif



module sigmoid  // this needs to be tested!!!
  (input [__bitlm1__:0] sum,
   output reg[__bitlm1__:0] s);

`define B 1'b0

   wire sign;
   reg [__bitlbf__+__bitlm1__:0] abs; // 4+64 => use all 64 bit to represent floating number. same principle for 3 bit, 2,3
   wire [__bitlbf__+__bitlm1__:0] esum; //4+64
   assign sign = sum[__bitlm1__];//sum[63]
   assign esum = {sum, __bitlbf__{B}}; 
   reg [__bitl__:0] tmp; //1, 64


  always @(sum) begin
    if (sign) begin
      abs = ~esum + 1;
    end else begin
      abs = esum;
    end

    if (abs > __sgmde5__) begin  //5 in 68 bit, or 5 bit
      tmp = __sgmdv1__; //value 1 in 65 bit, 4bit
      //0111111111111111111111111111111111111111111111111111111111111

    end else if (abs > __sgmd2.375__) begin //2.375 in 68bit, or 5 bit

      tmp =  __sgmd_div_5__ __sgmdv0.84375__; //abs[65:5] + 


    end else if (abs > 64'b0001000000000000000000000000000000000000000000000000000000000000) begin // 5bits, 160
      tmp = abs[63:3] + 61'b0_101000000000000000000000000000000000000000000000000000000000;


    end else begin // 8 bits, 128
      tmp = abs[62:2] + 61'b0_100000000000000000000000000000000000000000000000000000000000;

    end

    if (sign) begin
      tmp = 61'b0_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111 - tmp; 
    end

    if (tmp[60] == 1) // overflow
      s = 60'b1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111;
    else
      s = tmp[59:0];
  end
endmodule


`endif


// y = ((xp >= 5) + ...
//           (xp < 5 & xp >= 2.375) .* (0.03125 * xp + 0.84375) + ...
//           (xp < 2.375 & xp >= 1) .* (0.125 * xp + 0.625) + ...
//           (xp < 1 ) .* (0.25 * xp + 0.5)) ...
//           .* sign(x) + (-sign(x) + 1)/2;
