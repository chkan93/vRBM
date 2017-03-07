`ifndef sigmoid
`define sigmoid

`ifndef  TEST_BENCH
  `include "config.v"
`endif


// #BIT_CHANGE
module sigmoid 
  (input [67:0] sum,
   output reg[59:0] s);

`define B 1'b0

   wire sign;
   reg [67:0] abs; // #TEMPLAET: reg[input_bitwidth-1:0] abs 
   assign sign = sum[67]; // #TEMPLAET: sum[input_bitwidth-1] 
   reg [60:0] tmp;  // #TEMPLATE: reg [output_bitwidth:0] tmp

  always @(sum) begin
    if (sign) begin
      abs = ~sum + 68'b0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0001; //#Template abs=~sum + 1(represented in input_bitwidth)
    end else begin
      abs = sum;
    end


              // #TEMPLATE: 5 represented in your input bitwidth plus decimal point
    if (abs > 68'b0000__0____000_0101___0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000) begin  
      tmp = 61'b0_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111;
      //#TEMPLATE: tmp = maximum number in output bitwidth(represented in output_width+1) 

              // #TEMPLATE: 2.375 represented in your input bitwidth plus decimal point
    end else if (abs > 68'b0000__0____000_0010___0110_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000) begin //right 3bits, 216

              // #TEMPLATE: right shift by 5(0.03125) and then fit into (output_bitwidth+1) + 0.84375 
      tmp = abs[61:1] +  61'b0_1101_1000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000;


              //#TEMPLATE: abs > 1
    end else if (abs > 68'b0000__0____000_0001___0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000) begin // 5bits, 160

        //#template (0.125(right shitft by 3) * abs + 0.625) 
      tmp = {abs[59:0], `B} + 61'b0_1010_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000;
    end else begin 
        //(0.25(right shift by 2) * xp + 0.5)
      tmp = {abs[58:0], `B, `B}  + 61'b0_1000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000__0000_0000_0000_0000;

    end


    if (sign) begin //#TEMPLATE: maximum number in output bitwidth(represented in output_width+1) - tmp
      tmp = 61'b0_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111 - tmp; 
    end

    if (tmp[60] == 1) // check overflow, #TEMPLATE: if(tmp[output_bit_width] == 1)
      s = 60'b1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111__1111_1111_1111_1111; // #TEMPLATE: maximum number in output_bit_width
    else
      s = tmp[59:0]; // #TEMPLATE: s = tmp[output_bit_width-1:0]
  end
endmodule


`endif


// y = ((xp >= 5) + ...
//           (xp < 5 & xp >= 2.375) .* (0.03125 * xp + 0.84375) + ...
//           (xp < 2.375 & xp >= 1) .* (0.125 * xp + 0.625) + ...
//           (xp < 1 ) .* (0.25 * xp + 0.5)) ...
//           .* sign(x) + (-sign(x) + 1)/2;