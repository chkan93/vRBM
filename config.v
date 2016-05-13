`ifndef _my_incl_vh_
`define _my_incl_vh_






/*
# For RandomGenerator

## Problem
- not fully configurable, number of xor is hard coded
*/
`define R_1 8-1
`define R_2 6-1
`define R_3 5-1
`define R_4 4-1
`define TB_SEED 4
`define TB_RG_DUMPFILE "../dumpFolder/RG.vcd"





/*
Utility
*/
`define PORT_2D(D1,D2,BL)  (BL*D1*D2)-1:0
`define PORT_1D(D,BL) (BL*D)-1:0
`define DIM_2D(D1,D2) [1:D1][1:D2]
`define DIM_1D(D1) [1:D1]
`define DEFINE_PACK_VAR  genvar pk_i,pk_j

`define PACK_2D_ARRAY(D1,D2, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
          for(pk_j=1; pk_j<=D2; pk_j=pk_j+1)  \
            assign dst[(((pk_i-1)*D1 + (pk_j-1))*BL)+BL-1 -: BL] = src[pk_i][pk_j]; \
      endgenerate

`define UNPACK_2D_ARRAY(D1,D2, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
          for(pk_j=1; pk_j<=D2; pk_j=pk_j+1)  \
            assign dst[pk_i][pk_j] = src[(((pk_i-1)*D1 + (pk_j-1))*BL)+BL-1 -: BL]; \
      endgenerate

`define PACK_1D_ARRAY(D1, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
            assign dst[((pk_i-1)*BL)+BL-1 -: BL] = src[pk_i]; \
      endgenerate

`define UNPACK_1D_ARRAY(D1,BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
            assign dst[pk_i] = src[((pk_i-1)*BL)+BL-1 -: BL]; \
      endgenerate


// reg version

`define PACK_2D_REG_ARRAY(D1,D2, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
          for(pk_j=1; pk_j<=D2; pk_j=pk_j+1)  \
            dst[(((pk_i-1)*D1 + (pk_j-1))*BL)+BL-1 -: BL] = src[pk_i][pk_j]; \
      endgenerate

`define UNPACK_2D_REG_ARRAY(D1,D2, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
          for(pk_j=1; pk_j<=D2; pk_j=pk_j+1)  \
            dst[pk_i][pk_j] = src[(((pk_i-1)*D1 + (pk_j-1))*BL)+BL-1 -: BL]; \
      endgenerate

`define PACK_1D_REG_ARRAY(D1, BL,src,dst)   \
      generate                              \
        for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
            dst[((pk_i-1)*BL)+BL-1 -: BL] = src[pk_i]; \
      endgenerate

`define UNPACK_1D_REG_ARRAY(D1,BL,src,dst)   \
      generate                              \
          for(pk_i=1; pk_i<=D1; pk_i=pk_i+1)  \
              dst[pk_i] = src[((pk_i-1)*BL)+BL-1 -: BL]; \
      endgenerate


`endif