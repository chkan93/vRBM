`ifndef  TEST_BENCH
  `include "config.v"
`endif

`ifndef sigmoid
`define sigmoid

module sigmoid
  #(parameter input_bitlength = 16, parameter sigmoid_bitlength = 8)
  (input [input_bitlength-1:0] sum,
   output reg[sigmoid_bitlength-1:0] s);


   wire sign;
   reg [input_bitlength-1:0] abs;
   assign sign = sum[input_bitlength-1];
   reg [sigmoid_bitlength:0] tmp;

  always @(sum) begin
    if (sign) begin
      abs = ~sum + 16'b0000_0000_0000_0001;
    end else begin
      abs = sum;
    end

    if (abs > 16'b0000_0101_0000_0000) begin  //5
      tmp = 9'b0_1111_1111;
    end else if (abs > 16'b0000_0010_0110_0000) begin //right 3bits, 216
      tmp = abs[13:5] +  9'b0_1101_1000;
    end else if (abs > 16'b0000_0001_0000_0000) begin // 5bits, 160
      tmp = abs[11:3] + 9'b0_1010_0000;
    end else begin // 8 bits, 128
      tmp = abs[10:2] + 9'b0_1000_0000;
    end


    if (sign) begin
      tmp = 9'b0_1111_1111 - tmp; // 256(1) - tmp
    end

    if (tmp[8] == 1) // overflow
      s = 8'b1111_1111;
    else
      s = tmp[7:0];
  end
endmodule


`endif


// y = ((xp >= 5) + ...
//           (xp < 5 & xp >= 2.375) .* (0.03125 * xp + 0.84375) + ...
//           (xp < 2.375 & xp >= 1) .* (0.125 * xp + 0.625) + ...
//           (xp < 1 ) .* (0.25 * xp + 0.5)) ...
//           .* sign(x) + (-sign(x) + 1)/2;
