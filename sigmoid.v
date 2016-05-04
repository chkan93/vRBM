module sigmoid
  #(parameter bitlength = 8)
  (output reg[bitlength-1:0] s,
  input [11:0] sum);
  reg sign;
  reg[11:0] z;
  always @(sum) begin
    sign = sum[11];
    if (sign==1)
      z = ~sum+1;
    else
      z = sum;
    if (z>8'b01010000)//z>5
      s = 8'b10000000; // s=1
    else if (z>8'b00100110) //2.375<z<5
      s = z[9:2] + 8'b01101100; //s=z/32+6'b011011/32
    else if (z>1) //1<z<2.375
      s = z[7:0] + 8'b01010000;
    else
      s = {z[6:0], 1'b0} + 8'b01000000;

    if(sign==1)
      s = 8'b10000000 - s;
  end
endmodule
