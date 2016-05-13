`ifndef  TEST_BENCH
  `include "config.v"
`endif

module sigmoid
  #(parameter input_bitlength = 12, parameter bitlength = 8)
  (
    input [input_bitlength-1:0] sum,
    output reg[bitlength-1:0] s

    );

  wire sign;
  reg[input_bitlength-1:0] z;
  assign   sign = sum[11]; //the sign bit
  always @(sum) begin

    if (sign==1)
      z = ~sum+1; //negligate and plus one, 如果输入是负数
    else
      z = sum;
    if (z>8'b01010000)//z>5
      s = 8'b10000000; // s=1
    else if (z>8'b0010_0110) //2.375<z<5
      s = z[9:2] + 8'b01101100; //s=z/32+6'b011011/32
    else if (z>1) //1<z<2.375
      s = z[7:0] + 8'b01010000;
    else
      s = {z[6:0], 1'b0} + 8'b01000000;

    if(sign==1)
      s = 8'b10000000 - s;
  end
endmodule

/*

有一些问题：

1）就是matlab代码里
 sumi = limitbit(sumi,1, scalei, data_rangei); data_rangei = 8, 但是sigmoid.v里面
 input = [11:0] sum, 这个是为啥呀，需不需要改过来? 还有， 输出的s是不是没有sign bit？

2）另外输出的s的范围是不是从 0100_0000-1000_0000, 然后把前者当做0， 后者当做1？ 如果是这样的
 话， random number generator是不是也要特殊设计（只生成0100_0000-1000_0000的平均分布？）



3）关于小数点的问题，我看了sigmoid.v里面似乎是 把4位当做小数点后，4位前，是不是这样？
 如果如此，那么rbm里面的 sumi = sumi + testdata(:,ele)*W(ele,:) 乘法，加法操作，
 是不是也要按照这个来设计？

4）还有matlab代码里是做了 100次iteration，然后把所有的score累加后做spike(classification),
 这样是不是为了渐进统计意义上的正确性？ 在verilog里面要不要也这样做（100次）？

Email 回复：
1）matlab里data_rangei是最终结果的range，8就够了，但是相加了784次有783个中间结果，这些中间结果的range大概要2^8，加上小数点后的4位一共12位
输出的s范围是0-1，都是正数，不需要sign bit
2）我记得s输出范围是0000 0000 - 1111 1111 ，至少在matlab里面我是这样想的。如果sigmoid.v里面不是这样，估计是哪里写错了= = 我的想法是尽量利用所有的bit，只要random number generator产生同样range的uniform random number就不会错
3）在sigmoid前是Q4.4（4位小数点前，4位小数点后），sigmoid后的输出是Q0.8 。加法操作用整数操作就行了吧。总之就是你自己记得小数点在哪里，最终结果不错就行，中间怎么实现我不管。。
4）对100次是为了最后收敛，verilog里也要做。（其实1000次才最终收敛）像bit-length，iteration这些参数写的时候最好考虑一下未来修改的可行性，因为很可能会变。

好的，既然这样，下面自己可以列出一个开发计划

1. random number 已经OK， 写test_bench
2. 实现Matrix Multiplication
3. 写Matrix Multiplication的Test Bench
4. 写一次iteration
5. 写一次iteration的test bench
6. 把iteration组成loop

http://epwave.readthedocs.io/, gtkwave

*/
