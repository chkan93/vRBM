`define TEST_BENCH
`include "../config.v"
`include "../RandomGenerator.v"


// RandomGenerator(reset, clk, seed, dataOut);

module test_RandomGenerator;

reg reset = 0;
reg clock;
reg[7:0] seed;
wire[7:0] rvalue;

integer clock_counter = 0;
integer clock_period = 5;
integer reset_begin = 40;
integer reset_perid = 10;

RandomGenerator #(8) rnd(reset, clock, seed, rvalue);

initial begin
  clock = 0;
  reset = 0;
  seed = `TB_SEED;
end
initial begin
  $dumpfile (`TB_RG_DUMPFILE);
  $dumpvars;
end

initial  begin
  $display("Seed = %d",seed);
  $display("\t\ttime, \treset, \trand");
  $monitor("%d, \t%b, \t%d", $time,  reset, rvalue);
  #200 $finish;
end



always begin
  clock = !clock;

  if (clock == 1) begin
    if (clock_counter == reset_begin) begin
      reset <= 1;
    end
    clock_counter = clock_counter + clock_period;

    if (clock_counter == (reset_begin+reset_perid)) begin
      reset <= 0;
    end
  end

  #clock_period;
end



endmodule
