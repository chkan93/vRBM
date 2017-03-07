`ifndef _my_incl_vh_
`define _my_incl_vh_


/*
For new version
*/

// `define SPARSE




`define GET_2D(regfile, D2, BL, i, j) regfile[((i)*D2 + (j))*BL+BL-1 -: BL]
`define GET_1D(regfile, BL, i) regfile[(i)*BL+BL-1 -: BL]
`define ASSERT(condition, msg) if(condition) begin $display(msg); $finish(1); end





/*
# For RandomGenerator

## Problem
- not fully configurable, number of xor is hard coded
*/
`define R_1 60-1  // #BIT_CHANGE 
`define R_2 59-1  // #BIT_CHANGE
`define SEED_CLASSI 60'b111000110111111100000001111100101110011100100100101011000000  // #BIT_CHANGE
`define SEED_RBM    60'b001000001000001110011101001001111110110010110010111000111010  // #BIT_CHANGE
`define TB_SEED 4
`define TB_RG_DUMPFILE "./dumpFolder/RG.vcd"


`define ReadMem(x,y) $readmemh(x,y)
`define DEFINE_READMEM_VAR     integer rm_file, rm_temp
// `define ReadMem(path, mem)              \
//         rm_file = $fopen(path, "r");    \
//         rm_temp = $fread(mem, rm_file); \
//         rm_temp = $fclose(rm_file)





/*
Utility
*/
`define PORT_2D(D1,D2,BL)  (BL*D1*D2)-1:0
`define PORT_1D(D,BL) (BL*D)-1:0
`define DIM_3D(D1,D2,D3) [0:D1-1][0:D2-1][0:D3-1]
`define DIM_2D(D1,D2) [0:D1-1][0:D2-1]
`define DIM_1D(D1) [0:D1-1]
`define DEFINE_PACK_VAR  genvar pk_i,pk_j

`define PACK_2D_ARRAY(D1,D2, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
          for(pk_j=1; pk_j<=D2; pk_j=pk_j+1)  \
            assign dst[(((pk_i-1)*D2 + (pk_j-1))*BL)+BL-1 -: BL] = src[pk_i-1][pk_j-1]; \
      endgenerate

`define UNPACK_2D_ARRAY(D1,D2, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
          for(pk_j=1; pk_j<=D2; pk_j=pk_j+1)  \
            assign dst[pk_i-1][pk_j-1] = src[(((pk_i-1)*D2 + (pk_j-1))*BL)+BL-1 -: BL]; \
      endgenerate

`define PACK_1D_ARRAY(D1, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
            assign dst[((pk_i-1)*BL)+BL-1 -: BL] = src[pk_i-1]; \
      endgenerate

`define UNPACK_1D_ARRAY(D1,BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
            assign dst[pk_i-1] = src[((pk_i-1)*BL)+BL-1 -: BL]; \
      endgenerate

`define D1_TO_D2_ARRAY(D1, D2, d1array, d2array) \
  generate                                       \
    for(pk_i=0;pk_i<D1;pk_i=pk_i+1)          \
      for(pk_j=0;pk_j<D2;pk_j=pk_j+1)       \
        assign d2array[pk_i][pk_j] = d1array[pk_i*D2+pk_j];  \
  endgenerate



//  array printing
`define DEFINE_PRINTING_VAR  integer pt_i, pt_j
`define DISPLAY_1D_ARRAY(D1,msg, array)    \
      $display("%s", msg);                               \
      for(pt_i = 0; pt_i < D1; pt_i=pt_i+1) begin       \
          $display("%0d ", array[pt_i]);                 \
      end                                               \
      $display("\n");


`define DISPLAY_2D_ARRAY(D1, D2,msg, array)           \
$display("%s", msg);   \
for(pt_i = 0; pt_i < D1; pt_i=pt_i+1)  begin      \
  for(pt_j = 0; pt_j < D2; pt_j=pt_j+1)   begin   \
      $display("%0d ", array[pt_i][pt_j]);         \
      end                                         \
    $display("\n====");                                \
  end                                             \
$display("\n");


`define DISPLAY_1D_BIT_ARRAY(D1, BL, msg, array)  \
    $display("%s", msg);                   \
    for(pt_i = 1 ;pt_i < D1+1; pt_i=pt_i+1) begin \
          $display("%0d ", array[((pt_i-1)*BL)+BL-1 -: BL]);                  \
    end                     \
    $display("\n");


`define DISPLAY_2D_BIT_ARRAY(D1,D2, BL, msg, array)  \
    $display("%s", msg);                   \
    for(pt_i = 1 ;pt_i <= D1; pt_i=pt_i+1)  \
        for(pt_j = 1; pt_j <= D2; pt_j=pt_j+1)  begin \
          $display("%0d ", array[(((pt_i-1)*D2 + (pt_j-1))*BL)+BL-1 -: BL]);                  \
        end                     \
        $display("\n====");

`endif
