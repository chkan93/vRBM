module sigmoid
  #(parameter bitlength = 8)
  (output reg[bitlength-1:0] s,
  input reg[15:0] sum);
  reg[bitlength:0] stmp;
  reg[11:0] z;//Q8.4
  always @(sum) begin
    if (sum[11]==1)begin
      z = ~sum;
      z = z+11'b00000000001;
    end
    else
      z = sum;
    if (z>8'b01010000)//z>5
      stmp = 9'b100000000; // s=1
    else if (z>8'b00100110) //2.375<z<5
      stmp = z[9:1] + 9'b011011000; //s=z/32+6'b011011/32
    else if (z>8'b00010000) //1<z<2.375
      stmp = {z[7:0], 1'b0} + 9'b010100000;
    else
      stmp = {z[6:0], 2'b00} + 9'b010000000;

    if(sum[11]==1)
      stmp = 9'b100000000 - stmp;
    if(stmp[8]==1)
      stmp = 9'b111111111;


    s=stmp[7:0];
  end
endmodule
