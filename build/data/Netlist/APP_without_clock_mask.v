/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP4
// Date      : Sun Jun 26 21:45:14 2016
/////////////////////////////////////////////////////////////


module RandomGenerator_0 ( reset, clk, seed, dataOut );
  input [7:0] seed;
  output [7:0] dataOut;
  input reset, clk;
  wire   shiftIn, n18, n19, n20, n21, n22, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17;

  xor3a1 U31 ( .A(dataOut[4]), .B(n18), .C(n19), .Y(shiftIn) );
  xnor2a2 U32 ( .A(dataOut[5]), .B(dataOut[7]), .Y(n19) );
  and3d1 U33 ( .A(dataOut[0]), .B(dataOut[2]), .C(dataOut[1]), .Y(n22) );
  fd4a2 shiftReg_reg_3_ ( .D(dataOut[2]), .CLK(clk), .CLR(n5), .PRE(n13), .Q(
        dataOut[3]) );
  fd4a2 shiftReg_reg_0_ ( .D(shiftIn), .CLK(clk), .CLR(n8), .PRE(n16), .Q(
        dataOut[0]) );
  fd4a2 shiftReg_reg_2_ ( .D(dataOut[1]), .CLK(clk), .CLR(n6), .PRE(n14), .Q(
        dataOut[2]) );
  fd4a2 shiftReg_reg_6_ ( .D(dataOut[5]), .CLK(clk), .CLR(n2), .PRE(n10), .Q(
        dataOut[6]) );
  fd4a2 shiftReg_reg_1_ ( .D(dataOut[0]), .CLK(clk), .CLR(n7), .PRE(n15), .Q(
        dataOut[1]) );
  fd4a2 shiftReg_reg_7_ ( .D(dataOut[6]), .CLK(clk), .CLR(n1), .PRE(n9), .Q(
        dataOut[7]) );
  fd4a2 shiftReg_reg_5_ ( .D(dataOut[4]), .CLK(clk), .CLR(n3), .PRE(n11), .Q(
        dataOut[5]) );
  fd4a2 shiftReg_reg_4_ ( .D(dataOut[3]), .CLK(clk), .CLR(n4), .PRE(n12), .Q(
        dataOut[4]) );
  and2c0 U3 ( .A(dataOut[5]), .B(dataOut[4]), .Y(n20) );
  oa3h0 U4 ( .A(n20), .B(n21), .C(n22), .D(dataOut[3]), .Y(n18) );
  and2c0 U5 ( .A(dataOut[7]), .B(dataOut[6]), .Y(n21) );
  inv1a1 U6 ( .A(reset), .Y(n17) );
  nand2c2 U7 ( .A(seed[7]), .B(n17), .Y(n1) );
  nand2c2 U8 ( .A(seed[6]), .B(n17), .Y(n2) );
  nand2c2 U9 ( .A(seed[5]), .B(n17), .Y(n3) );
  nand2c2 U10 ( .A(seed[4]), .B(n17), .Y(n4) );
  nand2c2 U11 ( .A(seed[3]), .B(n17), .Y(n5) );
  nand2c2 U12 ( .A(seed[2]), .B(n17), .Y(n6) );
  nand2c2 U13 ( .A(seed[1]), .B(n17), .Y(n7) );
  nand2c2 U14 ( .A(seed[0]), .B(n17), .Y(n8) );
  nand2a0 U15 ( .A(seed[7]), .B(reset), .Y(n9) );
  nand2a0 U16 ( .A(seed[6]), .B(reset), .Y(n10) );
  nand2a0 U17 ( .A(seed[5]), .B(reset), .Y(n11) );
  nand2a0 U18 ( .A(seed[4]), .B(reset), .Y(n12) );
  nand2a0 U19 ( .A(seed[3]), .B(reset), .Y(n13) );
  nand2a0 U20 ( .A(seed[2]), .B(reset), .Y(n14) );
  nand2a0 U21 ( .A(seed[1]), .B(reset), .Y(n15) );
  nand2a0 U22 ( .A(seed[0]), .B(reset), .Y(n16) );
endmodule


module sigmoid_0 ( sum, s );
  input [15:0] sum;
  output [7:0] s;
  wire   N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18, N19,
         N27, N28, N29, N31, N32, N33, N34, N35, N37, N38, N42, N43, N44, N45,
         N46, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N62, N65, N66,
         N67, N68, N69, N70, N71, N72, N73, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59;
  wire   [13:9] abs;
  wire   [8:7] add_30_carry;
  wire   [8:5] add_28_carry;
  wire   [15:2] sub_add_20_b0_carry;

  oa1d1 U3 ( .A(n53), .B(n50), .C(n49), .Y(n1) );
  mx2d2 U4 ( .D0(N73), .D1(N73), .S(n4), .Y(n22) );
  inv1a1 U5 ( .A(n50), .Y(abs[10]) );
  xor2b2 U6 ( .A(add_28_carry[6]), .B(abs[11]), .Y(N33) );
  or2c0 U7 ( .A(n21), .B(n22), .Y(s[7]) );
  or2c0 U8 ( .A(n26), .B(n22), .Y(s[3]) );
  or2c0 U9 ( .A(n28), .B(n22), .Y(s[1]) );
  and2c1 U10 ( .A(n47), .B(n37), .Y(n38) );
  inv1a1 U11 ( .A(N59), .Y(N69) );
  inv1a1 U12 ( .A(N60), .Y(N70) );
  inv1a1 U13 ( .A(N61), .Y(N71) );
  inv1a1 U14 ( .A(N57), .Y(N67) );
  and3b1 U15 ( .B(n53), .C(n50), .A(n49), .Y(n37) );
  inv1a1 U16 ( .A(N56), .Y(N66) );
  inv1a1 U17 ( .A(N58), .Y(N68) );
  inv1a1 U18 ( .A(N62), .Y(N72) );
  inv1a1 U19 ( .A(abs[9]), .Y(N53) );
  inv1a1 U20 ( .A(N52), .Y(N42) );
  inv1a1 U21 ( .A(n5), .Y(n3) );
  inv1a1 U22 ( .A(n5), .Y(n4) );
  inv1a1 U23 ( .A(n5), .Y(n2) );
  inv1a1 U24 ( .A(sum[15]), .Y(n5) );
  inv1a1 U25 ( .A(sum[0]), .Y(n20) );
  inv1a1 U26 ( .A(sum[1]), .Y(n14) );
  inv1a1 U27 ( .A(sum[2]), .Y(n13) );
  inv1a1 U28 ( .A(sum[3]), .Y(n12) );
  inv1a1 U29 ( .A(sum[4]), .Y(n11) );
  inv1a1 U30 ( .A(sum[5]), .Y(n10) );
  inv1a1 U31 ( .A(sum[6]), .Y(n9) );
  inv1a1 U32 ( .A(sum[7]), .Y(n8) );
  inv1a1 U33 ( .A(sum[8]), .Y(n7) );
  inv1a1 U34 ( .A(sum[9]), .Y(n6) );
  inv1a1 U35 ( .A(sum[10]), .Y(n19) );
  inv1a1 U36 ( .A(sum[11]), .Y(n18) );
  inv1a1 U37 ( .A(sum[12]), .Y(n17) );
  inv1a1 U38 ( .A(sum[13]), .Y(n16) );
  inv1a1 U39 ( .A(sum[14]), .Y(n15) );
  inv1a1 U40 ( .A(N55), .Y(N65) );
  xor2a2 U41 ( .A(abs[11]), .B(add_30_carry[8]), .Y(N45) );
  xor2a2 U42 ( .A(abs[10]), .B(abs[9]), .Y(N54) );
  xor2a2 U43 ( .A(abs[13]), .B(add_28_carry[8]), .Y(N35) );
  nand2c2 U44 ( .A(abs[10]), .B(add_30_carry[7]), .Y(add_30_carry[8]) );
  xnor2a2 U45 ( .A(add_30_carry[7]), .B(abs[10]), .Y(N44) );
  and2a2 U46 ( .A(N52), .B(abs[9]), .Y(add_30_carry[7]) );
  xor2a2 U47 ( .A(abs[9]), .B(N52), .Y(N43) );
  nand2c2 U48 ( .A(abs[12]), .B(add_28_carry[7]), .Y(add_28_carry[8]) );
  xnor2a2 U49 ( .A(add_28_carry[7]), .B(abs[12]), .Y(N34) );
  nand2c2 U50 ( .A(abs[11]), .B(add_28_carry[6]), .Y(add_28_carry[7]) );
  and2a2 U51 ( .A(add_28_carry[5]), .B(abs[10]), .Y(add_28_carry[6]) );
  xor2a2 U52 ( .A(abs[10]), .B(add_28_carry[5]), .Y(N32) );
  nand2c2 U53 ( .A(abs[9]), .B(N52), .Y(add_28_carry[5]) );
  xnor2a2 U54 ( .A(N52), .B(abs[9]), .Y(N31) );
  xor2a2 U55 ( .A(n5), .B(sub_add_20_b0_carry[15]), .Y(N19) );
  and2a2 U56 ( .A(sub_add_20_b0_carry[14]), .B(n15), .Y(
        sub_add_20_b0_carry[15]) );
  xor2a2 U57 ( .A(n15), .B(sub_add_20_b0_carry[14]), .Y(N18) );
  and2a2 U58 ( .A(sub_add_20_b0_carry[13]), .B(n16), .Y(
        sub_add_20_b0_carry[14]) );
  xor2a2 U59 ( .A(n16), .B(sub_add_20_b0_carry[13]), .Y(N17) );
  and2a2 U60 ( .A(sub_add_20_b0_carry[12]), .B(n17), .Y(
        sub_add_20_b0_carry[13]) );
  xor2a2 U61 ( .A(n17), .B(sub_add_20_b0_carry[12]), .Y(N16) );
  and2a2 U62 ( .A(sub_add_20_b0_carry[11]), .B(n18), .Y(
        sub_add_20_b0_carry[12]) );
  xor2a2 U63 ( .A(n18), .B(sub_add_20_b0_carry[11]), .Y(N15) );
  and2a2 U64 ( .A(sub_add_20_b0_carry[10]), .B(n19), .Y(
        sub_add_20_b0_carry[11]) );
  xor2a2 U65 ( .A(n19), .B(sub_add_20_b0_carry[10]), .Y(N14) );
  and2a2 U66 ( .A(sub_add_20_b0_carry[9]), .B(n6), .Y(sub_add_20_b0_carry[10])
         );
  xor2a2 U67 ( .A(n6), .B(sub_add_20_b0_carry[9]), .Y(N13) );
  and2a2 U68 ( .A(sub_add_20_b0_carry[8]), .B(n7), .Y(sub_add_20_b0_carry[9])
         );
  xor2a2 U69 ( .A(n7), .B(sub_add_20_b0_carry[8]), .Y(N12) );
  and2a2 U70 ( .A(sub_add_20_b0_carry[7]), .B(n8), .Y(sub_add_20_b0_carry[8])
         );
  xor2a2 U71 ( .A(n8), .B(sub_add_20_b0_carry[7]), .Y(N11) );
  and2a2 U72 ( .A(sub_add_20_b0_carry[6]), .B(n9), .Y(sub_add_20_b0_carry[7])
         );
  xor2a2 U73 ( .A(n9), .B(sub_add_20_b0_carry[6]), .Y(N10) );
  and2a2 U74 ( .A(sub_add_20_b0_carry[5]), .B(n10), .Y(sub_add_20_b0_carry[6])
         );
  xor2a2 U75 ( .A(n10), .B(sub_add_20_b0_carry[5]), .Y(N9) );
  and2a2 U76 ( .A(sub_add_20_b0_carry[4]), .B(n11), .Y(sub_add_20_b0_carry[5])
         );
  xor2a2 U77 ( .A(n11), .B(sub_add_20_b0_carry[4]), .Y(N8) );
  and2a2 U78 ( .A(sub_add_20_b0_carry[3]), .B(n12), .Y(sub_add_20_b0_carry[4])
         );
  xor2a2 U79 ( .A(n12), .B(sub_add_20_b0_carry[3]), .Y(N7) );
  and2a2 U80 ( .A(sub_add_20_b0_carry[2]), .B(n13), .Y(sub_add_20_b0_carry[3])
         );
  xor2a2 U81 ( .A(n13), .B(sub_add_20_b0_carry[2]), .Y(N6) );
  and2a2 U82 ( .A(n20), .B(n14), .Y(sub_add_20_b0_carry[2]) );
  xor2a2 U83 ( .A(n14), .B(n20), .Y(N5) );
  mx2d0 U84 ( .D0(N62), .D1(N72), .S(n3), .Y(n21) );
  nand2a0 U85 ( .A(n23), .B(n22), .Y(s[6]) );
  mx2d0 U86 ( .D0(N61), .D1(N71), .S(sum[15]), .Y(n23) );
  nand2a0 U87 ( .A(n24), .B(n22), .Y(s[5]) );
  mx2d0 U88 ( .D0(N60), .D1(N70), .S(n4), .Y(n24) );
  nand2a0 U89 ( .A(n25), .B(n22), .Y(s[4]) );
  mx2d0 U90 ( .D0(N59), .D1(N69), .S(n4), .Y(n25) );
  mx2d0 U91 ( .D0(N58), .D1(N68), .S(n4), .Y(n26) );
  nand2a0 U92 ( .A(n27), .B(n22), .Y(s[2]) );
  mx2d0 U93 ( .D0(N57), .D1(N67), .S(n4), .Y(n27) );
  mx2d0 U94 ( .D0(N56), .D1(N66), .S(n4), .Y(n28) );
  nand2a0 U95 ( .A(n29), .B(n22), .Y(s[0]) );
  mx2d0 U96 ( .D0(N55), .D1(N65), .S(n3), .Y(n29) );
  inv1a0 U97 ( .A(n30), .Y(N29) );
  inv1a0 U98 ( .A(n31), .Y(N28) );
  inv1a0 U99 ( .A(n32), .Y(N27) );
  inv1a0 U100 ( .A(n33), .Y(abs[13]) );
  inv1a0 U101 ( .A(n34), .Y(abs[12]) );
  inv1a0 U102 ( .A(n35), .Y(abs[11]) );
  ao7a1 U103 ( .A(N35), .B(n36), .C(N54), .D(n37), .E(N45), .F(n38), .Y(N73)
         );
  ao8a0 U104 ( .A(N53), .B(n37), .C(N34), .D(n36), .E(n39), .Y(N62) );
  ao1d1 U105 ( .A(N44), .B(n38), .C(n1), .Y(n39) );
  ao8a0 U106 ( .A(N52), .B(n37), .C(N33), .D(n36), .E(n40), .Y(N61) );
  ao1d1 U107 ( .A(N43), .B(n38), .C(n1), .Y(n40) );
  ao8a0 U108 ( .A(N29), .B(n37), .C(N32), .D(n36), .E(n41), .Y(N60) );
  ao1d1 U109 ( .A(N42), .B(n38), .C(n1), .Y(n41) );
  ao8a0 U110 ( .A(N28), .B(n37), .C(N31), .D(n36), .E(n42), .Y(N59) );
  ao1d1 U111 ( .A(N29), .B(n38), .C(n1), .Y(n42) );
  ao8a0 U112 ( .A(N27), .B(n37), .C(N42), .D(n36), .E(n43), .Y(N58) );
  ao1d1 U113 ( .A(N28), .B(n38), .C(n1), .Y(n43) );
  ao8a0 U114 ( .A(N38), .B(n37), .C(N29), .D(n36), .E(n44), .Y(N57) );
  ao1d1 U115 ( .A(N27), .B(n38), .C(n1), .Y(n44) );
  ao8a0 U116 ( .A(N37), .B(n37), .C(N28), .D(n36), .E(n45), .Y(N56) );
  ao1d1 U117 ( .A(N38), .B(n38), .C(n1), .Y(n45) );
  ao8a0 U118 ( .A(N46), .B(n37), .C(N27), .D(n36), .E(n46), .Y(N55) );
  ao1d1 U119 ( .A(N37), .B(n38), .C(n1), .Y(n46) );
  and2a2 U120 ( .A(n1), .B(n47), .Y(n36) );
  ao2b0 U121 ( .B(abs[9]), .A(n48), .C(n49), .D(abs[10]), .Y(n47) );
  and2c0 U122 ( .A(N52), .B(n51), .Y(n48) );
  ao3h0 U123 ( .A(n31), .B(n52), .C(n32), .D(n30), .Y(n51) );
  nand4a0 U124 ( .A(n54), .B(n33), .C(n34), .D(n35), .Y(n49) );
  mx2d0 U125 ( .D0(sum[11]), .D1(N15), .S(n3), .Y(n35) );
  mx2d0 U126 ( .D0(sum[12]), .D1(N16), .S(n3), .Y(n34) );
  mx2d0 U127 ( .D0(sum[13]), .D1(N17), .S(n3), .Y(n33) );
  mx2d0 U128 ( .D0(sum[14]), .D1(n55), .S(n3), .Y(n54) );
  nand2c2 U129 ( .A(N18), .B(N19), .Y(n55) );
  mx2d0 U130 ( .D0(sum[10]), .D1(N14), .S(n2), .Y(n50) );
  oa1f1 U131 ( .A(N52), .B(n56), .C(abs[9]), .Y(n53) );
  mx2a2 U132 ( .D0(sum[9]), .D1(N13), .S(n4), .Y(abs[9]) );
  nand4a0 U133 ( .A(n30), .B(n52), .C(n32), .D(n31), .Y(n56) );
  mx2d0 U134 ( .D0(sum[6]), .D1(N10), .S(n2), .Y(n31) );
  mx2d0 U135 ( .D0(sum[5]), .D1(N9), .S(n2), .Y(n32) );
  and4b1 U136 ( .B(n57), .C(n58), .D(n59), .A(N46), .Y(n52) );
  mx2a2 U137 ( .D0(sum[2]), .D1(N6), .S(n2), .Y(N46) );
  and2c0 U138 ( .A(N38), .B(N37), .Y(n59) );
  mx2a2 U139 ( .D0(sum[3]), .D1(N7), .S(n3), .Y(N37) );
  mx2a2 U140 ( .D0(sum[4]), .D1(N8), .S(n4), .Y(N38) );
  mx2d0 U141 ( .D0(sum[1]), .D1(N5), .S(n2), .Y(n58) );
  mx2d0 U142 ( .D0(sum[0]), .D1(sum[0]), .S(n2), .Y(n57) );
  mx2d0 U143 ( .D0(sum[7]), .D1(N11), .S(n2), .Y(n30) );
  mx2a2 U144 ( .D0(sum[8]), .D1(N12), .S(sum[15]), .Y(N52) );
endmodule


module ap_adder_0_DW01_add_1 ( A, B, CI, SUM, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94;

  ao1c1 U2 ( .A(n64), .B(n65), .C(n66), .Y(n63) );
  and2c1 U3 ( .A(n86), .B(n7), .Y(n25) );
  nand2a0 U4 ( .A(n52), .B(n50), .Y(n42) );
  and2b1 U5 ( .B(n43), .A(n6), .Y(n45) );
  and2c0 U6 ( .A(n89), .B(n90), .Y(n19) );
  and2c0 U7 ( .A(n67), .B(n68), .Y(n64) );
  nand2b1 U8 ( .A(n7), .B(n34), .Y(n37) );
  and2c1 U9 ( .A(n83), .B(n84), .Y(n12) );
  and2c0 U10 ( .A(n19), .B(n87), .Y(n83) );
  ao1a0 U11 ( .A(n63), .B(n2), .C(n3), .Y(n61) );
  nand2a0 U12 ( .A(n40), .B(n45), .Y(n91) );
  inv1a1 U13 ( .A(n35), .Y(n86) );
  oa1a0 U14 ( .A(n86), .B(n34), .C(n36), .Y(n1) );
  nand2a0 U15 ( .A(B[5]), .B(A[5]), .Y(n34) );
  nor2a2 U16 ( .A(n12), .B(n72), .Y(n67) );
  nand2c2 U17 ( .A(A[13]), .B(B[13]), .Y(n2) );
  and2a2 U18 ( .A(B[13]), .B(A[13]), .Y(n3) );
  inv1a0 U19 ( .A(n63), .Y(n62) );
  nor2a0 U20 ( .A(n89), .B(n90), .Y(n5) );
  inv1a2 U21 ( .A(n56), .Y(n94) );
  nor2a2 U22 ( .A(n51), .B(n91), .Y(n89) );
  inv1a1 U23 ( .A(n28), .Y(n85) );
  inv1a1 U24 ( .A(n79), .Y(n77) );
  inv1a1 U25 ( .A(n80), .Y(n13) );
  and2c0 U26 ( .A(n6), .B(n51), .Y(n48) );
  nand2b1 U27 ( .A(n6), .B(n50), .Y(n53) );
  xor2a2 U28 ( .A(n11), .B(n12), .Y(SUM[9]) );
  or2a2 U29 ( .A(n92), .B(n93), .Y(n8) );
  and3b2 U30 ( .B(A[0]), .C(B[0]), .A(n94), .Y(n93) );
  nor2a0 U31 ( .A(n67), .B(n68), .Y(n4) );
  inv1a0 U32 ( .A(n12), .Y(n76) );
  xnor2a2 U33 ( .A(n38), .B(n39), .Y(SUM[4]) );
  xor2a2 U34 ( .A(n37), .B(n5), .Y(SUM[5]) );
  xor2a2 U35 ( .A(n30), .B(n31), .Y(SUM[6]) );
  inv1a0 U36 ( .A(n34), .Y(n33) );
  inv1a0 U37 ( .A(n50), .Y(n49) );
  xor2a2 U38 ( .A(n53), .B(n51), .Y(SUM[2]) );
  xor2a2 U39 ( .A(n46), .B(n47), .Y(SUM[3]) );
  xor2a2 U40 ( .A(n15), .B(n16), .Y(SUM[8]) );
  xor2a2 U41 ( .A(n81), .B(n82), .Y(SUM[10]) );
  xor2a2 U42 ( .A(n54), .B(n55), .Y(SUM[1]) );
  xor2a2 U43 ( .A(n74), .B(n75), .Y(SUM[11]) );
  and2c0 U44 ( .A(n13), .B(n77), .Y(n73) );
  and2c0 U45 ( .A(n17), .B(n18), .Y(n16) );
  and2c0 U46 ( .A(n5), .B(n20), .Y(n17) );
  ao1f1 U47 ( .A(n86), .B(n34), .C(n36), .Y(n27) );
  ao1f1 U48 ( .A(n85), .B(n1), .C(n29), .Y(n18) );
  nand2a0 U49 ( .A(n21), .B(n88), .Y(n87) );
  nand2a0 U50 ( .A(n70), .B(n73), .Y(n72) );
  ao1f1 U51 ( .A(n77), .B(n14), .C(n78), .Y(n69) );
  oa1c0 U52 ( .A(n80), .B(n76), .C(n14), .Y(n82) );
  and2c0 U53 ( .A(n32), .B(n33), .Y(n31) );
  and2c0 U54 ( .A(n7), .B(n5), .Y(n32) );
  xor2a2 U55 ( .A(n23), .B(n24), .Y(SUM[7]) );
  nand2a0 U56 ( .A(n28), .B(n29), .Y(n23) );
  inv1a1 U57 ( .A(n5), .Y(n26) );
  nand2a0 U58 ( .A(n45), .B(n8), .Y(n44) );
  and2c0 U59 ( .A(n48), .B(n49), .Y(n47) );
  nand2a0 U60 ( .A(n70), .B(n71), .Y(n74) );
  nand2a0 U61 ( .A(n35), .B(n36), .Y(n30) );
  nand2a0 U62 ( .A(n79), .B(n78), .Y(n81) );
  nand2a0 U63 ( .A(n56), .B(n57), .Y(n54) );
  nand2a0 U64 ( .A(n40), .B(n41), .Y(n39) );
  nand2a0 U65 ( .A(n21), .B(n22), .Y(n15) );
  nand2a0 U66 ( .A(n43), .B(n52), .Y(n46) );
  nand2c2 U67 ( .A(A[3]), .B(B[3]), .Y(n43) );
  nand2a0 U68 ( .A(B[2]), .B(A[2]), .Y(n50) );
  nand2a0 U69 ( .A(B[1]), .B(A[1]), .Y(n57) );
  nand2a0 U70 ( .A(B[6]), .B(A[6]), .Y(n36) );
  nand2a0 U71 ( .A(B[3]), .B(A[3]), .Y(n52) );
  nand2c2 U72 ( .A(A[1]), .B(B[1]), .Y(n56) );
  nand2c2 U73 ( .A(A[6]), .B(B[6]), .Y(n35) );
  xor2a2 U74 ( .A(n58), .B(n59), .Y(SUM[15]) );
  xor2b2 U75 ( .A(B[15]), .B(A[15]), .Y(n58) );
  oa4e0 U76 ( .C(B[14]), .D(A[14]), .B(n60), .A(n61), .Y(n59) );
  nor2a0 U77 ( .A(A[14]), .B(B[14]), .Y(n60) );
  nor2a0 U78 ( .A(A[12]), .B(B[12]), .Y(n65) );
  and2a2 U79 ( .A(B[12]), .B(A[12]), .Y(n66) );
  and2c0 U80 ( .A(A[2]), .B(B[2]), .Y(n6) );
  and2c0 U81 ( .A(A[5]), .B(B[5]), .Y(n7) );
  nand2c2 U82 ( .A(A[4]), .B(B[4]), .Y(n40) );
  nand2a0 U83 ( .A(B[9]), .B(A[9]), .Y(n14) );
  nand2c2 U84 ( .A(A[8]), .B(B[8]), .Y(n21) );
  nand2a0 U85 ( .A(B[7]), .B(A[7]), .Y(n29) );
  nand2a0 U86 ( .A(B[10]), .B(A[10]), .Y(n78) );
  nand2a0 U87 ( .A(B[4]), .B(A[4]), .Y(n41) );
  nand2c2 U88 ( .A(A[9]), .B(B[9]), .Y(n80) );
  nand2c2 U89 ( .A(A[7]), .B(B[7]), .Y(n28) );
  nand2c2 U90 ( .A(A[10]), .B(B[10]), .Y(n79) );
  or2c0 U91 ( .A(B[11]), .B(A[11]), .Y(n71) );
  nand2c2 U92 ( .A(A[11]), .B(B[11]), .Y(n70) );
  nand2a0 U93 ( .A(B[8]), .B(A[8]), .Y(n22) );
  nand2a0 U94 ( .A(B[0]), .B(A[0]), .Y(n55) );
  and2a2 U95 ( .A(n10), .B(n55), .Y(SUM[0]) );
  nand2c2 U96 ( .A(A[0]), .B(B[0]), .Y(n10) );
  nand2b1 U97 ( .A(n13), .B(n14), .Y(n11) );
  oa1f1 U98 ( .A(n25), .B(n26), .C(n27), .Y(n24) );
  ao1d1 U99 ( .A(n42), .B(n43), .C(n44), .Y(n38) );
  xor3a1 U100 ( .A(B[14]), .B(A[14]), .C(n61), .Y(SUM[14]) );
  xnor3a1 U101 ( .A(B[13]), .B(A[13]), .C(n62), .Y(SUM[13]) );
  xnor3a1 U102 ( .A(B[12]), .B(A[12]), .C(n4), .Y(SUM[12]) );
  ao1d1 U103 ( .A(n69), .B(n70), .C(n71), .Y(n68) );
  oa1f1 U104 ( .A(n73), .B(n76), .C(n69), .Y(n75) );
  ao1d1 U105 ( .A(n18), .B(n21), .C(n22), .Y(n84) );
  inv1a1 U106 ( .A(n20), .Y(n88) );
  nand2b1 U107 ( .A(n85), .B(n25), .Y(n20) );
  ao3e1 U108 ( .A(n40), .B(n43), .C(n42), .D(n41), .Y(n90) );
  inv1a1 U109 ( .A(n8), .Y(n51) );
  inv1a1 U110 ( .A(n57), .Y(n92) );
endmodule


module ap_adder_0 ( x, y, z );
  input [15:0] x;
  input [15:0] y;
  output [15:0] z;
  wire   n3, n1, n2, n4, n5, n6, n7, n8, n9;
  wire   [15:0] tmp;

  ap_adder_0_DW01_add_1 add_12 ( .A(y), .B(x), .CI(n3), .SUM(tmp) );
  or2c2 U3 ( .A(n1), .B(n7), .Y(n8) );
  inv1a0 U4 ( .A(tmp[15]), .Y(n9) );
  or3d1 U5 ( .A(x[15]), .B(y[15]), .C(n9), .Y(n7) );
  inv1a2 U6 ( .A(n8), .Y(n6) );
  gnd U7 ( .Y(n3) );
  buf1a4 U8 ( .A(n5), .Y(n1) );
  or3d1 U9 ( .A(tmp[15]), .B(n4), .C(n2), .Y(n5) );
  inv1a1 U10 ( .A(y[15]), .Y(n4) );
  inv1a1 U11 ( .A(x[15]), .Y(n2) );
  ao1d1 U12 ( .A(tmp[0]), .B(n6), .C(n1), .Y(z[0]) );
  ao1d1 U13 ( .A(tmp[1]), .B(n6), .C(n1), .Y(z[1]) );
  ao1d1 U14 ( .A(tmp[2]), .B(n6), .C(n1), .Y(z[2]) );
  ao1d1 U15 ( .A(tmp[3]), .B(n6), .C(n1), .Y(z[3]) );
  ao1d1 U16 ( .A(tmp[4]), .B(n6), .C(n1), .Y(z[4]) );
  ao1d1 U17 ( .A(tmp[5]), .B(n6), .C(n1), .Y(z[5]) );
  ao1d1 U18 ( .A(tmp[6]), .B(n6), .C(n1), .Y(z[6]) );
  ao1d1 U19 ( .A(tmp[7]), .B(n6), .C(n1), .Y(z[7]) );
  ao1d1 U20 ( .A(tmp[8]), .B(n6), .C(n1), .Y(z[8]) );
  ao1d1 U21 ( .A(tmp[9]), .B(n6), .C(n1), .Y(z[9]) );
  ao1d1 U22 ( .A(tmp[10]), .B(n6), .C(n1), .Y(z[10]) );
  ao1d1 U23 ( .A(tmp[11]), .B(n6), .C(n1), .Y(z[11]) );
  ao1d1 U24 ( .A(tmp[12]), .B(n6), .C(n1), .Y(z[12]) );
  ao1d1 U25 ( .A(tmp[13]), .B(n6), .C(n1), .Y(z[13]) );
  ao1d1 U26 ( .A(tmp[14]), .B(n6), .C(n1), .Y(z[14]) );
  ao1f1 U27 ( .A(n9), .B(n8), .C(n7), .Y(z[15]) );
endmodule


module i_ap_adder_DW01_add_0 ( A, B, CI, SUM, CO );
  input [11:0] A;
  input [11:0] B;
  output [11:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7;
  wire   [11:4] carry;

  fa1a0 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  fa1a0 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  fa1a0 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  fa1a0 U1_10 ( .A(A[10]), .B(B[10]), .CI(carry[10]), .CO(carry[11]), .S(
        SUM[10]) );
  fa1a0 U1_8 ( .A(A[8]), .B(B[8]), .CI(carry[8]), .CO(carry[9]), .S(SUM[8]) );
  fa1a0 U1_7 ( .A(A[7]), .B(B[7]), .CI(carry[7]), .CO(carry[8]), .S(SUM[7]) );
  xor3a1 U1_11 ( .A(A[11]), .B(B[11]), .C(carry[11]), .Y(SUM[11]) );
  fa1a1 U1_9 ( .A(A[9]), .B(B[9]), .CI(carry[9]), .CO(carry[10]), .S(SUM[9])
         );
  inv1a1 U1 ( .A(B[3]), .Y(n1) );
  ao1c1 U2 ( .A(A[3]), .B(n2), .C(n1), .Y(n3) );
  ao1d1 U3 ( .A(A[2]), .B(n4), .C(n5), .Y(n2) );
  ao6a1 U4 ( .A(CI), .B(A[0]), .C(B[0]), .Y(n6) );
  ao1d1 U5 ( .A(A[3]), .B(n2), .C(n3), .Y(carry[4]) );
  ao1f1 U6 ( .A(A[2]), .B(n4), .C(B[2]), .Y(n5) );
  ao1d1 U7 ( .A(A[1]), .B(n6), .C(n7), .Y(n4) );
  ao1f1 U8 ( .A(A[1]), .B(n6), .C(B[1]), .Y(n7) );
endmodule


module i_ap_adder_DW01_add_1 ( A, B, CI, SUM, CO );
  input [7:0] A;
  input [7:0] B;
  output [7:0] SUM;
  input CI;
  output CO;
  wire   n1;
  wire   [7:2] carry;

  fa1a0 U1_1 ( .A(A[1]), .B(B[1]), .CI(n1), .CO(carry[2]), .S(SUM[1]) );
  fa1a0 U1_2 ( .A(A[2]), .B(B[2]), .CI(carry[2]), .CO(carry[3]), .S(SUM[2]) );
  fa1a0 U1_3 ( .A(A[3]), .B(B[3]), .CI(carry[3]), .CO(carry[4]), .S(SUM[3]) );
  fa1a0 U1_4 ( .A(A[4]), .B(B[4]), .CI(carry[4]), .CO(carry[5]), .S(SUM[4]) );
  fa1a0 U1_6 ( .A(A[6]), .B(B[6]), .CI(carry[6]), .CO(carry[7]), .S(SUM[6]) );
  fa1a0 U1_5 ( .A(A[5]), .B(B[5]), .CI(carry[5]), .CO(carry[6]), .S(SUM[5]) );
  xor3a2 U1_7 ( .A(A[7]), .B(B[7]), .C(carry[7]), .Y(SUM[7]) );
  xor2a2 U1 ( .A(B[0]), .B(A[0]), .Y(SUM[0]) );
  and2a2 U2 ( .A(B[0]), .B(A[0]), .Y(n1) );
endmodule


module i_ap_adder ( A, B, SUM );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  wire   n1, SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2,
         SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4;

  i_ap_adder_DW01_add_0 add_1_root_add_19_2 ( .A(A[15:4]), .B(B[15:4]), .CI(
        A[0]), .SUM({SUM[15:8], SYNOPSYS_UNCONNECTED_1, SYNOPSYS_UNCONNECTED_2, 
        SYNOPSYS_UNCONNECTED_3, SYNOPSYS_UNCONNECTED_4}) );
  i_ap_adder_DW01_add_1 add_17 ( .A(A[7:0]), .B(B[7:0]), .CI(n1), .SUM(
        SUM[7:0]) );
  gnd U1 ( .Y(n1) );
endmodule


module RBMLayer ( reset, clock, Value, pixel_id, pixel, adder_type, result, 
        finish );
  input [11:0] Value;
  input [9:0] pixel_id;
  input reset, clock, pixel, adder_type;
  output result, finish;
  wire   n_Logic1_, n_Logic0_, N2, n_1_net__15_, n_1_net__14_, n_1_net__13_,
         n_1_net__12_, n_1_net__11_, n_1_net__10_, n_1_net__9_, n_1_net__8_,
         n_1_net__7_, n_1_net__6_, n_1_net__5_, n_1_net__4_, n_1_net__3_,
         n_1_net__2_, n_1_net__1_, n_1_net__0_, n_2_net__15_, n_2_net__10_,
         n_2_net__9_, n_2_net__8_, n_2_net__7_, n_2_net__6_, n_2_net__5_,
         n_2_net__4_, n_2_net__3_, n_2_net__2_, n_2_net__1_, n_2_net__0_,
         n_3_net__15_, n_3_net__14_, n_3_net__13_, n_3_net__12_, n_3_net__11_,
         n_3_net__10_, n_3_net__9_, n_3_net__8_, n_3_net__7_, n_3_net__6_,
         n_3_net__5_, n_3_net__4_, n_3_net__3_, n_3_net__2_, n_3_net__1_,
         n_3_net__0_, n_4_net__15_, n_4_net__10_, n_4_net__9_, n_4_net__8_,
         n_4_net__7_, n_4_net__6_, n_4_net__5_, n_4_net__4_, n_4_net__3_,
         n_4_net__2_, n_4_net__1_, n_4_net__0_, N20, N21, N22, N23, N24, N25,
         N26, N27, N28, N29, N30, N31, N32, N33, N34, N35, n6, n7, n8, n9, n10,
         n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n51, n52, n57,
         n58, n59, n1, n2, n3, n4, n5, n22, n23, n24, n25, n26, n27, n28, n29,
         n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n47, n48, n49, n50, n53, n54, n55, n56, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86;
  wire   [7:0] RandomData;
  wire   [15:0] activate_temp;
  wire   [7:0] SigmoidOutput;
  wire   [15:0] temp_exact;
  wire   [15:0] temp_approximate;

  and2b1 U119 ( .B(Value[11]), .A(n37), .Y(n_4_net__15_) );
  and2a2 U129 ( .A(pixel_id[8]), .B(pixel_id[9]), .Y(n57) );
  nand2c2 U131 ( .A(pixel_id[9]), .B(pixel_id[8]), .Y(n59) );
  or6a1 U132 ( .A(pixel_id[3]), .B(pixel_id[2]), .C(pixel_id[1]), .D(
        pixel_id[7]), .E(pixel_id[6]), .F(pixel_id[5]), .Y(n58) );
  RandomGenerator_0 rnd ( .reset(reset), .clk(clock), .seed({n_Logic0_, 
        n_Logic1_, n_Logic1_, n_Logic1_, n_Logic1_, n_Logic1_, n_Logic0_, 
        n_Logic0_}), .dataOut(RandomData) );
  sigmoid_0 sg ( .sum(activate_temp), .s(SigmoidOutput) );
  ap_adder_0 adder_only ( .x({n_1_net__15_, n_1_net__14_, n_1_net__13_, 
        n_1_net__12_, n_1_net__11_, n_1_net__10_, n_1_net__9_, n_1_net__8_, 
        n_1_net__7_, n_1_net__6_, n_1_net__5_, n_1_net__4_, n_1_net__3_, 
        n_1_net__2_, n_1_net__1_, n_1_net__0_}), .y({n_2_net__15_, 
        n_2_net__15_, n_2_net__15_, n_2_net__15_, n_2_net__15_, n_2_net__10_, 
        n_2_net__9_, n_2_net__8_, n_2_net__7_, n_2_net__6_, n_2_net__5_, 
        n_2_net__4_, n_2_net__3_, n_2_net__2_, n_2_net__1_, n_2_net__0_}), .z(
        temp_exact) );
  i_ap_adder iadder_only ( .A({n_3_net__15_, n_3_net__14_, n_3_net__13_, 
        n_3_net__12_, n_3_net__11_, n_3_net__10_, n_3_net__9_, n_3_net__8_, 
        n_3_net__7_, n_3_net__6_, n_3_net__5_, n_3_net__4_, n_3_net__3_, 
        n_3_net__2_, n_3_net__1_, n_3_net__0_}), .B({n_4_net__15_, 
        n_4_net__15_, n_4_net__15_, n_4_net__15_, n_4_net__15_, n_4_net__10_, 
        n_4_net__9_, n_4_net__8_, n_4_net__7_, n_4_net__6_, n_4_net__5_, 
        n_4_net__4_, n_4_net__3_, n_4_net__2_, n_4_net__1_, n_4_net__0_}), 
        .SUM(temp_approximate) );
  fd2c2 temp_reg_15_ ( .D(N35), .CLK(clock), .CLR(n74), .QN(n6) );
  fd2c2 temp_reg_14_ ( .D(N34), .CLK(clock), .CLR(n74), .QN(n7) );
  fd2c2 temp_reg_13_ ( .D(N33), .CLK(clock), .CLR(n74), .QN(n8) );
  fd2c2 temp_reg_11_ ( .D(N31), .CLK(clock), .CLR(n74), .QN(n10) );
  fd2c2 temp_reg_12_ ( .D(N32), .CLK(clock), .CLR(n74), .QN(n9) );
  fd2c1 temp_reg_5_ ( .D(N25), .CLK(clock), .CLR(n74), .QN(n16) );
  fd2c1 temp_reg_6_ ( .D(N26), .CLK(clock), .CLR(n74), .QN(n15) );
  fd2c1 temp_reg_8_ ( .D(N28), .CLK(clock), .CLR(n74), .QN(n13) );
  fd2c1 temp_reg_9_ ( .D(N29), .CLK(clock), .CLR(n74), .QN(n12) );
  fd2c1 temp_reg_10_ ( .D(N30), .CLK(clock), .CLR(n74), .QN(n11) );
  fd2c1 temp_reg_7_ ( .D(N27), .CLK(clock), .CLR(n74), .QN(n14) );
  fd2c1 temp_reg_2_ ( .D(N22), .CLK(clock), .CLR(n74), .QN(n19) );
  fd2c1 temp_reg_3_ ( .D(N23), .CLK(clock), .CLR(n74), .QN(n18) );
  fd2c2 temp_reg_4_ ( .D(N24), .CLK(clock), .CLR(n74), .QN(n17) );
  fd2c1 temp_reg_1_ ( .D(N21), .CLK(clock), .CLR(n74), .QN(n20) );
  fd2c2 temp_reg_0_ ( .D(N20), .CLK(clock), .CLR(n74), .QN(n21) );
  or2a2 U3 ( .A(temp_exact[15]), .B(temp_approximate[15]), .Y(n45) );
  and2c1 U4 ( .A(adder_type), .B(n21), .Y(n_1_net__0_) );
  and2c1 U5 ( .A(n19), .B(adder_type), .Y(n_1_net__2_) );
  and2c0 U6 ( .A(n8), .B(adder_type), .Y(n_1_net__13_) );
  and2c0 U7 ( .A(n7), .B(adder_type), .Y(n_1_net__14_) );
  and2c0 U8 ( .A(temp_exact[1]), .B(temp_approximate[1]), .Y(n31) );
  and2c0 U9 ( .A(temp_exact[4]), .B(temp_approximate[4]), .Y(n2) );
  and2c0 U10 ( .A(temp_exact[3]), .B(temp_approximate[3]), .Y(n26) );
  and2c0 U11 ( .A(temp_exact[2]), .B(temp_approximate[2]), .Y(n25) );
  and2c0 U12 ( .A(temp_exact[10]), .B(temp_approximate[10]), .Y(n29) );
  and2c0 U13 ( .A(temp_exact[9]), .B(temp_approximate[9]), .Y(n28) );
  and2c0 U14 ( .A(temp_exact[8]), .B(temp_approximate[8]), .Y(n27) );
  and2c0 U15 ( .A(temp_exact[6]), .B(temp_approximate[6]), .Y(n4) );
  and2c0 U16 ( .A(temp_exact[5]), .B(temp_approximate[5]), .Y(n3) );
  and2c0 U17 ( .A(temp_exact[11]), .B(temp_approximate[11]), .Y(n5) );
  ao1e0 U18 ( .B(n45), .A(n32), .C(n46), .Y(N35) );
  and2c0 U19 ( .A(temp_exact[7]), .B(temp_approximate[7]), .Y(n1) );
  and2b2 U20 ( .B(Value[11]), .A(n36), .Y(n_2_net__15_) );
  inv1a4 U21 ( .A(reset), .Y(n74) );
  and2c2 U22 ( .A(n86), .B(n21), .Y(n_3_net__0_) );
  and2c2 U23 ( .A(n86), .B(n17), .Y(n_3_net__4_) );
  inv1a0 U24 ( .A(n45), .Y(n48) );
  nor2a0 U25 ( .A(temp_exact[0]), .B(temp_approximate[0]), .Y(n30) );
  nor2a0 U26 ( .A(n14), .B(adder_type), .Y(n_1_net__7_) );
  and2c0 U27 ( .A(n11), .B(adder_type), .Y(n_1_net__10_) );
  and2c0 U28 ( .A(n12), .B(adder_type), .Y(n_1_net__9_) );
  and2c0 U29 ( .A(n13), .B(adder_type), .Y(n_1_net__8_) );
  nor2a0 U30 ( .A(n17), .B(adder_type), .Y(n_1_net__4_) );
  nor2a2 U31 ( .A(n15), .B(adder_type), .Y(n_1_net__6_) );
  nor2a2 U32 ( .A(n18), .B(adder_type), .Y(n_1_net__3_) );
  nor2a2 U33 ( .A(n16), .B(adder_type), .Y(n_1_net__5_) );
  nor2a2 U34 ( .A(n20), .B(adder_type), .Y(n_1_net__1_) );
  inv1a1 U35 ( .A(SigmoidOutput[6]), .Y(n72) );
  and2c0 U36 ( .A(n35), .B(n30), .Y(activate_temp[0]) );
  and2c0 U37 ( .A(n35), .B(n25), .Y(activate_temp[2]) );
  and2c0 U38 ( .A(n34), .B(n26), .Y(activate_temp[3]) );
  and2c0 U39 ( .A(n35), .B(n2), .Y(activate_temp[4]) );
  and2c0 U40 ( .A(n34), .B(n3), .Y(activate_temp[5]) );
  and2c0 U41 ( .A(n35), .B(n4), .Y(activate_temp[6]) );
  and2c0 U42 ( .A(n34), .B(n1), .Y(activate_temp[7]) );
  and2c0 U43 ( .A(n35), .B(n27), .Y(activate_temp[8]) );
  and2c0 U44 ( .A(n34), .B(n28), .Y(activate_temp[9]) );
  and2c0 U45 ( .A(n35), .B(n29), .Y(activate_temp[10]) );
  and2c0 U46 ( .A(n34), .B(n5), .Y(activate_temp[11]) );
  and2c0 U47 ( .A(n35), .B(n22), .Y(activate_temp[12]) );
  and2c0 U48 ( .A(n34), .B(n23), .Y(activate_temp[13]) );
  and2c0 U49 ( .A(n35), .B(n24), .Y(activate_temp[14]) );
  and2c0 U50 ( .A(n34), .B(n31), .Y(activate_temp[1]) );
  buf1a2 U51 ( .A(n52), .Y(n36) );
  and2c0 U52 ( .A(n34), .B(n48), .Y(activate_temp[15]) );
  and2c0 U53 ( .A(temp_exact[12]), .B(temp_approximate[12]), .Y(n22) );
  and2c0 U54 ( .A(temp_exact[13]), .B(temp_approximate[13]), .Y(n23) );
  and2c0 U55 ( .A(temp_exact[14]), .B(temp_approximate[14]), .Y(n24) );
  and2c0 U56 ( .A(n85), .B(n52), .Y(n_2_net__0_) );
  and2c0 U57 ( .A(n51), .B(n85), .Y(n_4_net__0_) );
  and2c0 U58 ( .A(n37), .B(n80), .Y(n_4_net__5_) );
  and2c0 U59 ( .A(n37), .B(n79), .Y(n_4_net__6_) );
  and2c0 U60 ( .A(n37), .B(n78), .Y(n_4_net__7_) );
  and2c0 U61 ( .A(n84), .B(n52), .Y(n_2_net__1_) );
  and2c0 U62 ( .A(n83), .B(n52), .Y(n_2_net__2_) );
  and2c0 U63 ( .A(n82), .B(n36), .Y(n_2_net__3_) );
  and2c0 U64 ( .A(n81), .B(n36), .Y(n_2_net__4_) );
  and2c0 U65 ( .A(n78), .B(n36), .Y(n_2_net__7_) );
  and2c0 U66 ( .A(n79), .B(n36), .Y(n_2_net__6_) );
  and2c0 U67 ( .A(n80), .B(n36), .Y(n_2_net__5_) );
  and2c0 U68 ( .A(n75), .B(n36), .Y(n_2_net__10_) );
  and2c0 U69 ( .A(n76), .B(n36), .Y(n_2_net__9_) );
  and2c0 U70 ( .A(n77), .B(n36), .Y(n_2_net__8_) );
  and2c0 U71 ( .A(n51), .B(n81), .Y(n_4_net__4_) );
  buf1a2 U72 ( .A(n51), .Y(n37) );
  inv1a1 U73 ( .A(N2), .Y(n34) );
  inv1a1 U74 ( .A(N2), .Y(n35) );
  nand2a0 U75 ( .A(pixel), .B(n86), .Y(n52) );
  and2c0 U76 ( .A(n86), .B(n10), .Y(n_3_net__11_) );
  and2c0 U77 ( .A(n86), .B(n9), .Y(n_3_net__12_) );
  and2c0 U78 ( .A(n86), .B(n8), .Y(n_3_net__13_) );
  and2c0 U79 ( .A(n86), .B(n7), .Y(n_3_net__14_) );
  and2c0 U80 ( .A(n37), .B(n77), .Y(n_4_net__8_) );
  and2c0 U81 ( .A(n86), .B(n13), .Y(n_3_net__8_) );
  and2c0 U82 ( .A(n37), .B(n76), .Y(n_4_net__9_) );
  and2c0 U83 ( .A(n86), .B(n12), .Y(n_3_net__9_) );
  and2c0 U84 ( .A(n51), .B(n75), .Y(n_4_net__10_) );
  and2c0 U85 ( .A(n86), .B(n11), .Y(n_3_net__10_) );
  and2c0 U86 ( .A(n86), .B(n16), .Y(n_3_net__5_) );
  and2c0 U87 ( .A(n9), .B(adder_type), .Y(n_1_net__12_) );
  and2c0 U88 ( .A(n86), .B(n15), .Y(n_3_net__6_) );
  and2c0 U89 ( .A(n10), .B(adder_type), .Y(n_1_net__11_) );
  and2c0 U90 ( .A(n86), .B(n14), .Y(n_3_net__7_) );
  and2c0 U91 ( .A(n37), .B(n82), .Y(n_4_net__3_) );
  and2c0 U92 ( .A(n86), .B(n18), .Y(n_3_net__3_) );
  and2c0 U93 ( .A(n37), .B(n83), .Y(n_4_net__2_) );
  and2c0 U94 ( .A(n86), .B(n19), .Y(n_3_net__2_) );
  and2c0 U95 ( .A(n37), .B(n84), .Y(n_4_net__1_) );
  and2c0 U96 ( .A(n86), .B(n20), .Y(n_3_net__1_) );
  and2c0 U97 ( .A(n6), .B(adder_type), .Y(n_1_net__15_) );
  and2c0 U98 ( .A(n86), .B(n6), .Y(n_3_net__15_) );
  inv1a1 U99 ( .A(SigmoidOutput[5]), .Y(n73) );
  buf1a2 U100 ( .A(n47), .Y(n32) );
  ao3h0 U101 ( .A(n39), .B(pixel_id[0]), .C(n58), .D(n49), .Y(n47) );
  buf1a2 U102 ( .A(n43), .Y(n33) );
  nand4a0 U103 ( .A(pixel), .B(n42), .C(n41), .D(n40), .Y(n43) );
  nand2a0 U104 ( .A(pixel), .B(adder_type), .Y(n51) );
  inv1a1 U105 ( .A(RandomData[3]), .Y(n69) );
  inv1a1 U106 ( .A(RandomData[1]), .Y(n71) );
  inv1a1 U107 ( .A(RandomData[2]), .Y(n70) );
  vdd U108 ( .Y(n_Logic1_) );
  gnd U109 ( .Y(n_Logic0_) );
  inv1a4 U110 ( .A(adder_type), .Y(n86) );
  inv1a1 U111 ( .A(pixel_id[4]), .Y(n38) );
  nand2b1 U112 ( .A(n59), .B(n38), .Y(n39) );
  inv1a1 U113 ( .A(n58), .Y(n42) );
  nand4a0 U114 ( .A(pixel_id[4]), .B(n57), .C(pixel_id[0]), .D(n42), .Y(n49)
         );
  inv1a1 U115 ( .A(Value[0]), .Y(n85) );
  inv1a1 U116 ( .A(pixel_id[0]), .Y(n41) );
  inv1a1 U117 ( .A(n39), .Y(n40) );
  ao4f0 U118 ( .A(n30), .B(n32), .C(n85), .D(n33), .Y(N20) );
  inv1a1 U120 ( .A(Value[1]), .Y(n84) );
  ao4f0 U121 ( .A(n31), .B(n32), .C(n84), .D(n33), .Y(N21) );
  inv1a1 U122 ( .A(Value[2]), .Y(n83) );
  ao4f0 U123 ( .A(n25), .B(n32), .C(n83), .D(n33), .Y(N22) );
  inv1a1 U124 ( .A(Value[3]), .Y(n82) );
  ao4f0 U125 ( .A(n26), .B(n32), .C(n82), .D(n33), .Y(N23) );
  inv1a1 U126 ( .A(Value[4]), .Y(n81) );
  ao4f0 U127 ( .A(n2), .B(n32), .C(n81), .D(n33), .Y(N24) );
  inv1a1 U128 ( .A(Value[5]), .Y(n80) );
  ao4f0 U130 ( .A(n3), .B(n32), .C(n80), .D(n33), .Y(N25) );
  inv1a1 U133 ( .A(Value[6]), .Y(n79) );
  ao4f0 U134 ( .A(n4), .B(n32), .C(n79), .D(n33), .Y(N26) );
  inv1a1 U135 ( .A(Value[7]), .Y(n78) );
  ao4f0 U136 ( .A(n1), .B(n32), .C(n78), .D(n33), .Y(N27) );
  inv1a1 U137 ( .A(Value[8]), .Y(n77) );
  ao4f0 U138 ( .A(n27), .B(n32), .C(n77), .D(n33), .Y(N28) );
  inv1a1 U139 ( .A(Value[9]), .Y(n76) );
  ao4f0 U140 ( .A(n28), .B(n32), .C(n76), .D(n33), .Y(N29) );
  inv1a1 U141 ( .A(Value[10]), .Y(n75) );
  ao4f0 U142 ( .A(n29), .B(n32), .C(n75), .D(n33), .Y(N30) );
  inv1a1 U143 ( .A(n33), .Y(n44) );
  nand2a1 U144 ( .A(Value[11]), .B(n44), .Y(n46) );
  ao1f1 U145 ( .A(n5), .B(n32), .C(n46), .Y(N31) );
  ao1f1 U146 ( .A(n22), .B(n32), .C(n46), .Y(N32) );
  ao1f1 U147 ( .A(n23), .B(n32), .C(n46), .Y(N33) );
  ao1f1 U148 ( .A(n24), .B(n32), .C(n46), .Y(N34) );
  inv1a1 U149 ( .A(n49), .Y(finish) );
  ao2i0 U150 ( .A(pixel_id[0]), .B(pixel_id[1]), .C(pixel_id[2]), .D(
        pixel_id[3]), .Y(n53) );
  and3d1 U151 ( .A(pixel_id[5]), .B(pixel_id[7]), .C(pixel_id[6]), .Y(n50) );
  and3b1 U152 ( .B(n53), .C(n50), .A(pixel_id[4]), .Y(n54) );
  and3b1 U153 ( .B(pixel_id[8]), .C(pixel_id[9]), .A(n54), .Y(N2) );
  and2b1 U154 ( .B(RandomData[7]), .A(SigmoidOutput[7]), .Y(n68) );
  and2b1 U155 ( .B(SigmoidOutput[0]), .A(RandomData[0]), .Y(n56) );
  and2b1 U156 ( .B(n56), .A(RandomData[1]), .Y(n55) );
  oa7a1 U157 ( .A(n56), .B(n71), .C(SigmoidOutput[1]), .D(n55), .E(
        SigmoidOutput[2]), .F(n70), .Y(n60) );
  ao8a0 U158 ( .A(n69), .B(SigmoidOutput[3]), .C(n70), .D(SigmoidOutput[2]), 
        .E(n60), .Y(n61) );
  oa1a0 U159 ( .A(SigmoidOutput[3]), .B(n69), .C(n61), .Y(n63) );
  nand2b1 U160 ( .A(SigmoidOutput[4]), .B(RandomData[4]), .Y(n62) );
  oa4e0 U161 ( .C(n63), .D(n62), .B(RandomData[4]), .A(SigmoidOutput[4]), .Y(
        n65) );
  nand2c2 U162 ( .A(RandomData[5]), .B(n73), .Y(n64) );
  oa7g0 U163 ( .A(RandomData[6]), .B(n72), .C(n65), .D(n64), .E(RandomData[5]), 
        .F(n73), .Y(n66) );
  oa1d1 U164 ( .A(RandomData[6]), .B(n72), .C(n66), .Y(n67) );
  ao4e0 U165 ( .B(SigmoidOutput[7]), .A(RandomData[7]), .C(n68), .D(n67), .Y(
        result) );
endmodule


module RandomGenerator_1 ( reset, clk, seed, dataOut );
  input [7:0] seed;
  output [7:0] dataOut;
  input reset, clk;
  wire   shiftIn, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n23, n24, n25, n26, n27;

  xor3a1 U31 ( .A(dataOut[4]), .B(n27), .C(n26), .Y(shiftIn) );
  xnor2a2 U32 ( .A(dataOut[5]), .B(dataOut[7]), .Y(n26) );
  and3d1 U33 ( .A(dataOut[0]), .B(dataOut[2]), .C(dataOut[1]), .Y(n23) );
  fd4a2 shiftReg_reg_3_ ( .D(dataOut[2]), .CLK(clk), .CLR(n5), .PRE(n13), .Q(
        dataOut[3]) );
  fd4a2 shiftReg_reg_0_ ( .D(shiftIn), .CLK(clk), .CLR(n8), .PRE(n16), .Q(
        dataOut[0]) );
  fd4a2 shiftReg_reg_2_ ( .D(dataOut[1]), .CLK(clk), .CLR(n6), .PRE(n14), .Q(
        dataOut[2]) );
  fd4a2 shiftReg_reg_6_ ( .D(dataOut[5]), .CLK(clk), .CLR(n2), .PRE(n10), .Q(
        dataOut[6]) );
  fd4a2 shiftReg_reg_1_ ( .D(dataOut[0]), .CLK(clk), .CLR(n7), .PRE(n15), .Q(
        dataOut[1]) );
  fd4a2 shiftReg_reg_7_ ( .D(dataOut[6]), .CLK(clk), .CLR(n1), .PRE(n9), .Q(
        dataOut[7]) );
  fd4a2 shiftReg_reg_5_ ( .D(dataOut[4]), .CLK(clk), .CLR(n3), .PRE(n11), .Q(
        dataOut[5]) );
  fd4a2 shiftReg_reg_4_ ( .D(dataOut[3]), .CLK(clk), .CLR(n4), .PRE(n12), .Q(
        dataOut[4]) );
  and2c0 U3 ( .A(dataOut[5]), .B(dataOut[4]), .Y(n25) );
  oa3h0 U4 ( .A(n25), .B(n24), .C(n23), .D(dataOut[3]), .Y(n27) );
  and2c0 U5 ( .A(dataOut[7]), .B(dataOut[6]), .Y(n24) );
  inv1a1 U6 ( .A(reset), .Y(n17) );
  nand2c2 U7 ( .A(seed[7]), .B(n17), .Y(n1) );
  nand2c2 U8 ( .A(seed[6]), .B(n17), .Y(n2) );
  nand2c2 U9 ( .A(seed[5]), .B(n17), .Y(n3) );
  nand2c2 U10 ( .A(seed[4]), .B(n17), .Y(n4) );
  nand2c2 U11 ( .A(seed[3]), .B(n17), .Y(n5) );
  nand2c2 U12 ( .A(seed[2]), .B(n17), .Y(n6) );
  nand2c2 U13 ( .A(seed[1]), .B(n17), .Y(n7) );
  nand2c2 U14 ( .A(seed[0]), .B(n17), .Y(n8) );
  nand2a0 U15 ( .A(seed[7]), .B(reset), .Y(n9) );
  nand2a0 U16 ( .A(seed[6]), .B(reset), .Y(n10) );
  nand2a0 U17 ( .A(seed[5]), .B(reset), .Y(n11) );
  nand2a0 U18 ( .A(seed[4]), .B(reset), .Y(n12) );
  nand2a0 U19 ( .A(seed[3]), .B(reset), .Y(n13) );
  nand2a0 U20 ( .A(seed[2]), .B(reset), .Y(n14) );
  nand2a0 U21 ( .A(seed[1]), .B(reset), .Y(n15) );
  nand2a0 U22 ( .A(seed[0]), .B(reset), .Y(n16) );
endmodule


module sigmoid_1 ( sum, s );
  input [15:0] sum;
  output [7:0] s;
  wire   N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17, N18, N19,
         N27, N28, N29, N31, N32, N33, N34, N35, N37, N38, N42, N43, N44, N45,
         N46, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N62, N65, N66,
         N67, N68, N69, N70, N71, N72, N73, n1, n2, n3, n4, n5, n6, n7, n8, n9,
         n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59;
  wire   [13:9] abs;
  wire   [8:7] add_30_carry;
  wire   [8:5] add_28_carry;
  wire   [15:2] sub_add_20_b0_carry;

  oa1d1 U3 ( .A(n53), .B(n50), .C(n49), .Y(n1) );
  mx2d2 U4 ( .D0(N73), .D1(N73), .S(n4), .Y(n22) );
  inv1a1 U5 ( .A(n50), .Y(abs[10]) );
  xor2b2 U6 ( .A(add_28_carry[6]), .B(abs[11]), .Y(N33) );
  xor2b2 U7 ( .A(add_30_carry[7]), .B(abs[10]), .Y(N44) );
  or2c0 U8 ( .A(n21), .B(n22), .Y(s[7]) );
  or2c0 U9 ( .A(n26), .B(n22), .Y(s[3]) );
  or2c0 U10 ( .A(n28), .B(n22), .Y(s[1]) );
  inv1a1 U11 ( .A(N61), .Y(N71) );
  and2c1 U12 ( .A(n47), .B(n37), .Y(n38) );
  inv1a1 U13 ( .A(N59), .Y(N69) );
  inv1a1 U14 ( .A(N57), .Y(N67) );
  inv1a1 U15 ( .A(N60), .Y(N70) );
  inv1a1 U16 ( .A(N56), .Y(N66) );
  inv1a1 U17 ( .A(N58), .Y(N68) );
  inv1a1 U18 ( .A(N62), .Y(N72) );
  inv1a1 U19 ( .A(abs[9]), .Y(N53) );
  inv1a1 U20 ( .A(N52), .Y(N42) );
  inv1a1 U21 ( .A(n5), .Y(n3) );
  inv1a1 U22 ( .A(n5), .Y(n4) );
  inv1a1 U23 ( .A(n5), .Y(n2) );
  and3b1 U24 ( .B(n53), .C(n50), .A(n49), .Y(n37) );
  inv1a1 U25 ( .A(sum[15]), .Y(n5) );
  inv1a1 U26 ( .A(sum[0]), .Y(n20) );
  inv1a1 U27 ( .A(sum[1]), .Y(n14) );
  inv1a1 U28 ( .A(sum[2]), .Y(n13) );
  inv1a1 U29 ( .A(sum[3]), .Y(n12) );
  inv1a1 U30 ( .A(sum[4]), .Y(n11) );
  inv1a1 U31 ( .A(sum[5]), .Y(n10) );
  inv1a1 U32 ( .A(sum[6]), .Y(n9) );
  inv1a1 U33 ( .A(sum[7]), .Y(n8) );
  inv1a1 U34 ( .A(sum[8]), .Y(n7) );
  inv1a1 U35 ( .A(sum[9]), .Y(n6) );
  inv1a1 U36 ( .A(sum[10]), .Y(n19) );
  inv1a1 U37 ( .A(sum[11]), .Y(n18) );
  inv1a1 U38 ( .A(sum[12]), .Y(n17) );
  inv1a1 U39 ( .A(sum[13]), .Y(n16) );
  inv1a1 U40 ( .A(sum[14]), .Y(n15) );
  inv1a1 U41 ( .A(N55), .Y(N65) );
  xor2a2 U42 ( .A(abs[11]), .B(add_30_carry[8]), .Y(N45) );
  xor2a2 U43 ( .A(abs[10]), .B(abs[9]), .Y(N54) );
  xor2a2 U44 ( .A(abs[13]), .B(add_28_carry[8]), .Y(N35) );
  nand2c2 U45 ( .A(abs[10]), .B(add_30_carry[7]), .Y(add_30_carry[8]) );
  and2a2 U46 ( .A(N52), .B(abs[9]), .Y(add_30_carry[7]) );
  xor2a2 U47 ( .A(abs[9]), .B(N52), .Y(N43) );
  nand2c2 U48 ( .A(abs[12]), .B(add_28_carry[7]), .Y(add_28_carry[8]) );
  xnor2a2 U49 ( .A(add_28_carry[7]), .B(abs[12]), .Y(N34) );
  nand2c2 U50 ( .A(abs[11]), .B(add_28_carry[6]), .Y(add_28_carry[7]) );
  and2a2 U51 ( .A(add_28_carry[5]), .B(abs[10]), .Y(add_28_carry[6]) );
  xor2a2 U52 ( .A(abs[10]), .B(add_28_carry[5]), .Y(N32) );
  nand2c2 U53 ( .A(abs[9]), .B(N52), .Y(add_28_carry[5]) );
  xnor2a2 U54 ( .A(N52), .B(abs[9]), .Y(N31) );
  xor2a2 U55 ( .A(n5), .B(sub_add_20_b0_carry[15]), .Y(N19) );
  and2a2 U56 ( .A(sub_add_20_b0_carry[14]), .B(n15), .Y(
        sub_add_20_b0_carry[15]) );
  xor2a2 U57 ( .A(n15), .B(sub_add_20_b0_carry[14]), .Y(N18) );
  and2a2 U58 ( .A(sub_add_20_b0_carry[13]), .B(n16), .Y(
        sub_add_20_b0_carry[14]) );
  xor2a2 U59 ( .A(n16), .B(sub_add_20_b0_carry[13]), .Y(N17) );
  and2a2 U60 ( .A(sub_add_20_b0_carry[12]), .B(n17), .Y(
        sub_add_20_b0_carry[13]) );
  xor2a2 U61 ( .A(n17), .B(sub_add_20_b0_carry[12]), .Y(N16) );
  and2a2 U62 ( .A(sub_add_20_b0_carry[11]), .B(n18), .Y(
        sub_add_20_b0_carry[12]) );
  xor2a2 U63 ( .A(n18), .B(sub_add_20_b0_carry[11]), .Y(N15) );
  and2a2 U64 ( .A(sub_add_20_b0_carry[10]), .B(n19), .Y(
        sub_add_20_b0_carry[11]) );
  xor2a2 U65 ( .A(n19), .B(sub_add_20_b0_carry[10]), .Y(N14) );
  and2a2 U66 ( .A(sub_add_20_b0_carry[9]), .B(n6), .Y(sub_add_20_b0_carry[10])
         );
  xor2a2 U67 ( .A(n6), .B(sub_add_20_b0_carry[9]), .Y(N13) );
  and2a2 U68 ( .A(sub_add_20_b0_carry[8]), .B(n7), .Y(sub_add_20_b0_carry[9])
         );
  xor2a2 U69 ( .A(n7), .B(sub_add_20_b0_carry[8]), .Y(N12) );
  and2a2 U70 ( .A(sub_add_20_b0_carry[7]), .B(n8), .Y(sub_add_20_b0_carry[8])
         );
  xor2a2 U71 ( .A(n8), .B(sub_add_20_b0_carry[7]), .Y(N11) );
  and2a2 U72 ( .A(sub_add_20_b0_carry[6]), .B(n9), .Y(sub_add_20_b0_carry[7])
         );
  xor2a2 U73 ( .A(n9), .B(sub_add_20_b0_carry[6]), .Y(N10) );
  and2a2 U74 ( .A(sub_add_20_b0_carry[5]), .B(n10), .Y(sub_add_20_b0_carry[6])
         );
  xor2a2 U75 ( .A(n10), .B(sub_add_20_b0_carry[5]), .Y(N9) );
  and2a2 U76 ( .A(sub_add_20_b0_carry[4]), .B(n11), .Y(sub_add_20_b0_carry[5])
         );
  xor2a2 U77 ( .A(n11), .B(sub_add_20_b0_carry[4]), .Y(N8) );
  and2a2 U78 ( .A(sub_add_20_b0_carry[3]), .B(n12), .Y(sub_add_20_b0_carry[4])
         );
  xor2a2 U79 ( .A(n12), .B(sub_add_20_b0_carry[3]), .Y(N7) );
  and2a2 U80 ( .A(sub_add_20_b0_carry[2]), .B(n13), .Y(sub_add_20_b0_carry[3])
         );
  xor2a2 U81 ( .A(n13), .B(sub_add_20_b0_carry[2]), .Y(N6) );
  and2a2 U82 ( .A(n20), .B(n14), .Y(sub_add_20_b0_carry[2]) );
  xor2a2 U83 ( .A(n14), .B(n20), .Y(N5) );
  mx2d0 U84 ( .D0(N62), .D1(N72), .S(n3), .Y(n21) );
  nand2a0 U85 ( .A(n23), .B(n22), .Y(s[6]) );
  mx2d0 U86 ( .D0(N61), .D1(N71), .S(sum[15]), .Y(n23) );
  nand2a0 U87 ( .A(n24), .B(n22), .Y(s[5]) );
  mx2d0 U88 ( .D0(N60), .D1(N70), .S(n4), .Y(n24) );
  nand2a0 U89 ( .A(n25), .B(n22), .Y(s[4]) );
  mx2d0 U90 ( .D0(N59), .D1(N69), .S(n4), .Y(n25) );
  mx2d0 U91 ( .D0(N58), .D1(N68), .S(n4), .Y(n26) );
  nand2a0 U92 ( .A(n27), .B(n22), .Y(s[2]) );
  mx2d0 U93 ( .D0(N57), .D1(N67), .S(n4), .Y(n27) );
  mx2d0 U94 ( .D0(N56), .D1(N66), .S(n4), .Y(n28) );
  nand2a0 U95 ( .A(n29), .B(n22), .Y(s[0]) );
  mx2d0 U96 ( .D0(N55), .D1(N65), .S(n3), .Y(n29) );
  inv1a0 U97 ( .A(n30), .Y(N29) );
  inv1a0 U98 ( .A(n31), .Y(N28) );
  inv1a0 U99 ( .A(n32), .Y(N27) );
  inv1a0 U100 ( .A(n33), .Y(abs[13]) );
  inv1a0 U101 ( .A(n34), .Y(abs[12]) );
  inv1a0 U102 ( .A(n35), .Y(abs[11]) );
  ao7a1 U103 ( .A(N35), .B(n36), .C(N54), .D(n37), .E(N45), .F(n38), .Y(N73)
         );
  ao8a0 U104 ( .A(N53), .B(n37), .C(N34), .D(n36), .E(n39), .Y(N62) );
  ao1d1 U105 ( .A(N44), .B(n38), .C(n1), .Y(n39) );
  ao8a0 U106 ( .A(N52), .B(n37), .C(N33), .D(n36), .E(n40), .Y(N61) );
  ao1d1 U107 ( .A(N43), .B(n38), .C(n1), .Y(n40) );
  ao8a0 U108 ( .A(N29), .B(n37), .C(N32), .D(n36), .E(n41), .Y(N60) );
  ao1d1 U109 ( .A(N42), .B(n38), .C(n1), .Y(n41) );
  ao8a0 U110 ( .A(N28), .B(n37), .C(N31), .D(n36), .E(n42), .Y(N59) );
  ao1d1 U111 ( .A(N29), .B(n38), .C(n1), .Y(n42) );
  ao8a0 U112 ( .A(N27), .B(n37), .C(N42), .D(n36), .E(n43), .Y(N58) );
  ao1d1 U113 ( .A(N28), .B(n38), .C(n1), .Y(n43) );
  ao8a0 U114 ( .A(N38), .B(n37), .C(N29), .D(n36), .E(n44), .Y(N57) );
  ao1d1 U115 ( .A(N27), .B(n38), .C(n1), .Y(n44) );
  ao8a0 U116 ( .A(N37), .B(n37), .C(N28), .D(n36), .E(n45), .Y(N56) );
  ao1d1 U117 ( .A(N38), .B(n38), .C(n1), .Y(n45) );
  ao8a0 U118 ( .A(N46), .B(n37), .C(N27), .D(n36), .E(n46), .Y(N55) );
  ao1d1 U119 ( .A(N37), .B(n38), .C(n1), .Y(n46) );
  and2a2 U120 ( .A(n1), .B(n47), .Y(n36) );
  ao2b0 U121 ( .B(abs[9]), .A(n48), .C(n49), .D(abs[10]), .Y(n47) );
  and2c0 U122 ( .A(N52), .B(n51), .Y(n48) );
  ao3h0 U123 ( .A(n31), .B(n52), .C(n32), .D(n30), .Y(n51) );
  nand4a0 U124 ( .A(n54), .B(n33), .C(n34), .D(n35), .Y(n49) );
  mx2d0 U125 ( .D0(sum[11]), .D1(N15), .S(n3), .Y(n35) );
  mx2d0 U126 ( .D0(sum[12]), .D1(N16), .S(n3), .Y(n34) );
  mx2d0 U127 ( .D0(sum[13]), .D1(N17), .S(n3), .Y(n33) );
  mx2d0 U128 ( .D0(sum[14]), .D1(n55), .S(n3), .Y(n54) );
  nand2c2 U129 ( .A(N18), .B(N19), .Y(n55) );
  mx2d0 U130 ( .D0(sum[10]), .D1(N14), .S(n2), .Y(n50) );
  oa1f1 U131 ( .A(N52), .B(n56), .C(abs[9]), .Y(n53) );
  mx2a2 U132 ( .D0(sum[9]), .D1(N13), .S(n4), .Y(abs[9]) );
  nand4a0 U133 ( .A(n30), .B(n52), .C(n32), .D(n31), .Y(n56) );
  mx2d0 U134 ( .D0(sum[6]), .D1(N10), .S(n2), .Y(n31) );
  mx2d0 U135 ( .D0(sum[5]), .D1(N9), .S(n2), .Y(n32) );
  and4b1 U136 ( .B(n57), .C(n58), .D(n59), .A(N46), .Y(n52) );
  mx2a2 U137 ( .D0(sum[2]), .D1(N6), .S(n2), .Y(N46) );
  and2c0 U138 ( .A(N38), .B(N37), .Y(n59) );
  mx2a2 U139 ( .D0(sum[3]), .D1(N7), .S(n3), .Y(N37) );
  mx2a2 U140 ( .D0(sum[4]), .D1(N8), .S(n4), .Y(N38) );
  mx2d0 U141 ( .D0(sum[1]), .D1(N5), .S(n2), .Y(n58) );
  mx2d0 U142 ( .D0(sum[0]), .D1(sum[0]), .S(n2), .Y(n57) );
  mx2d0 U143 ( .D0(sum[7]), .D1(N11), .S(n2), .Y(n30) );
  mx2a2 U144 ( .D0(sum[8]), .D1(N12), .S(sum[15]), .Y(N52) );
endmodule


module ap_adder_1_DW01_add_1 ( A, B, CI, SUM, CO );
  input [15:0] A;
  input [15:0] B;
  output [15:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98;

  inv1a1 U2 ( .A(n42), .Y(n88) );
  nand2c2 U3 ( .A(A[1]), .B(B[1]), .Y(n64) );
  nand2a0 U4 ( .A(n47), .B(n52), .Y(n93) );
  nor2a1 U5 ( .A(n76), .B(n77), .Y(n73) );
  nand2a1 U6 ( .A(n6), .B(n1), .Y(n8) );
  nand2c2 U7 ( .A(A[12]), .B(B[12]), .Y(n1) );
  nand2a2 U8 ( .A(n8), .B(n72), .Y(n71) );
  nor2a0 U9 ( .A(n85), .B(n86), .Y(n2) );
  and2c2 U10 ( .A(n26), .B(n89), .Y(n85) );
  nand2a0 U11 ( .A(n9), .B(n71), .Y(n70) );
  ao1d1 U12 ( .A(B[13]), .B(A[13]), .C(n70), .Y(n68) );
  and2c0 U13 ( .A(n18), .B(n81), .Y(n76) );
  and2c1 U14 ( .A(n88), .B(n15), .Y(n32) );
  and2c0 U15 ( .A(A[5]), .B(B[5]), .Y(n15) );
  nor2a1 U16 ( .A(n85), .B(n86), .Y(n18) );
  xnor2a2 U17 ( .A(n11), .B(n66), .Y(SUM[15]) );
  nor2a2 U18 ( .A(n91), .B(n92), .Y(n26) );
  nand2a0 U19 ( .A(n3), .B(n4), .Y(n5) );
  nand2a0 U20 ( .A(n5), .B(n74), .Y(n6) );
  inv1a1 U21 ( .A(n16), .Y(n3) );
  inv1a1 U22 ( .A(n73), .Y(n4) );
  and2c0 U23 ( .A(A[11]), .B(B[11]), .Y(n16) );
  nand2a0 U24 ( .A(B[11]), .B(A[11]), .Y(n74) );
  inv1a0 U25 ( .A(n6), .Y(n12) );
  nand2a0 U26 ( .A(n28), .B(n90), .Y(n89) );
  nand2a1 U27 ( .A(B[5]), .B(A[5]), .Y(n41) );
  and2c0 U28 ( .A(A[2]), .B(B[2]), .Y(n14) );
  or2a2 U29 ( .A(A[3]), .B(B[3]), .Y(n50) );
  nand2c2 U30 ( .A(A[7]), .B(B[7]), .Y(n35) );
  nor2a2 U31 ( .A(n58), .B(n93), .Y(n91) );
  oa1a0 U32 ( .A(n88), .B(n41), .C(n43), .Y(n7) );
  nand2a0 U33 ( .A(n59), .B(n57), .Y(n49) );
  xor2a2 U34 ( .A(n17), .B(n2), .Y(SUM[9]) );
  xor2a2 U35 ( .A(n75), .B(n73), .Y(SUM[11]) );
  inv1a2 U36 ( .A(n95), .Y(n10) );
  nand2c2 U37 ( .A(A[4]), .B(B[4]), .Y(n47) );
  nand2a0 U38 ( .A(B[6]), .B(A[6]), .Y(n43) );
  nand2a0 U39 ( .A(B[1]), .B(A[1]), .Y(n65) );
  nand2a0 U40 ( .A(B[3]), .B(A[3]), .Y(n59) );
  nand2a0 U41 ( .A(B[4]), .B(A[4]), .Y(n48) );
  nand2a0 U42 ( .A(B[12]), .B(A[12]), .Y(n72) );
  inv1a0 U43 ( .A(n2), .Y(n84) );
  inv1a0 U44 ( .A(n41), .Y(n40) );
  inv1a0 U45 ( .A(n57), .Y(n56) );
  nand2c2 U46 ( .A(A[13]), .B(B[13]), .Y(n9) );
  nand2b2 U47 ( .A(n94), .B(n10), .Y(n13) );
  xor2a2 U48 ( .A(B[15]), .B(A[15]), .Y(n11) );
  or2a2 U49 ( .A(A[6]), .B(B[6]), .Y(n42) );
  inv1a1 U50 ( .A(n26), .Y(n33) );
  and2c0 U51 ( .A(n24), .B(n25), .Y(n23) );
  and2c0 U52 ( .A(n26), .B(n27), .Y(n24) );
  ao1f1 U53 ( .A(n88), .B(n41), .C(n43), .Y(n34) );
  and2b1 U54 ( .B(n50), .A(n14), .Y(n52) );
  xor2a2 U55 ( .A(n60), .B(n58), .Y(SUM[2]) );
  xor2a2 U56 ( .A(n53), .B(n54), .Y(SUM[3]) );
  nand2a0 U57 ( .A(n50), .B(n59), .Y(n53) );
  xnor2a2 U58 ( .A(n45), .B(n46), .Y(SUM[4]) );
  nand2a0 U59 ( .A(n47), .B(n48), .Y(n46) );
  xor2a2 U60 ( .A(n44), .B(n26), .Y(SUM[5]) );
  xor2a2 U61 ( .A(n37), .B(n38), .Y(SUM[6]) );
  nand2a0 U62 ( .A(n42), .B(n43), .Y(n37) );
  xor2a2 U63 ( .A(n30), .B(n31), .Y(SUM[7]) );
  nand2a0 U64 ( .A(n35), .B(n36), .Y(n30) );
  xor2a2 U65 ( .A(n22), .B(n23), .Y(SUM[8]) );
  nand2a0 U66 ( .A(n28), .B(n29), .Y(n22) );
  xor2a2 U67 ( .A(n82), .B(n83), .Y(SUM[10]) );
  nand2a0 U68 ( .A(n80), .B(n79), .Y(n82) );
  inv1a1 U69 ( .A(n97), .Y(SUM[0]) );
  xnor2a2 U70 ( .A(n61), .B(n62), .Y(SUM[1]) );
  ao1f1 U71 ( .A(n87), .B(n7), .C(n36), .Y(n25) );
  nand2a0 U72 ( .A(n21), .B(n80), .Y(n81) );
  oa1c0 U73 ( .A(n21), .B(n84), .C(n20), .Y(n83) );
  and2c0 U74 ( .A(n39), .B(n40), .Y(n38) );
  and2c0 U75 ( .A(n15), .B(n26), .Y(n39) );
  and2c0 U76 ( .A(n55), .B(n56), .Y(n54) );
  and2c0 U77 ( .A(n14), .B(n58), .Y(n55) );
  nand2a0 U78 ( .A(n52), .B(n13), .Y(n51) );
  nand2a0 U79 ( .A(n64), .B(n65), .Y(n61) );
  inv1a1 U80 ( .A(n63), .Y(n62) );
  and2a2 U81 ( .A(B[14]), .B(A[14]), .Y(n69) );
  nand2a0 U82 ( .A(B[2]), .B(A[2]), .Y(n57) );
  nand2a0 U83 ( .A(B[7]), .B(A[7]), .Y(n36) );
  nand2c2 U84 ( .A(A[9]), .B(B[9]), .Y(n21) );
  nand2c2 U85 ( .A(A[10]), .B(B[10]), .Y(n80) );
  nand2a0 U86 ( .A(B[9]), .B(A[9]), .Y(n20) );
  nand2c2 U87 ( .A(A[8]), .B(B[8]), .Y(n28) );
  nand2a0 U88 ( .A(B[10]), .B(A[10]), .Y(n79) );
  nand2a0 U89 ( .A(B[8]), .B(A[8]), .Y(n29) );
  nand2c2 U90 ( .A(A[14]), .B(B[14]), .Y(n67) );
  nand2a0 U91 ( .A(B[0]), .B(A[0]), .Y(n63) );
  and2c0 U92 ( .A(A[0]), .B(B[0]), .Y(n98) );
  nand2b1 U93 ( .A(n19), .B(n20), .Y(n17) );
  inv1a1 U94 ( .A(n21), .Y(n19) );
  oa1f1 U95 ( .A(n32), .B(n33), .C(n34), .Y(n31) );
  nand2b1 U96 ( .A(n15), .B(n41), .Y(n44) );
  ao1d1 U97 ( .A(n49), .B(n50), .C(n51), .Y(n45) );
  nand2b1 U98 ( .A(n14), .B(n57), .Y(n60) );
  oa1f1 U99 ( .A(n67), .B(n68), .C(n69), .Y(n66) );
  xor3a1 U100 ( .A(B[14]), .B(A[14]), .C(n68), .Y(SUM[14]) );
  xor3a1 U101 ( .A(B[13]), .B(A[13]), .C(n71), .Y(SUM[13]) );
  xnor3a1 U102 ( .A(B[12]), .B(A[12]), .C(n12), .Y(SUM[12]) );
  ao1f1 U103 ( .A(n78), .B(n20), .C(n79), .Y(n77) );
  inv1a1 U104 ( .A(n80), .Y(n78) );
  nand2b1 U105 ( .A(n16), .B(n74), .Y(n75) );
  ao1d1 U106 ( .A(n25), .B(n28), .C(n29), .Y(n86) );
  inv1a1 U107 ( .A(n27), .Y(n90) );
  nand2b1 U108 ( .A(n87), .B(n32), .Y(n27) );
  inv1a1 U109 ( .A(n35), .Y(n87) );
  ao3e1 U110 ( .A(n47), .B(n50), .C(n49), .D(n48), .Y(n92) );
  inv1a1 U111 ( .A(n13), .Y(n58) );
  and3b1 U112 ( .B(A[0]), .C(B[0]), .A(n96), .Y(n95) );
  inv1a1 U113 ( .A(n64), .Y(n96) );
  inv1a1 U114 ( .A(n65), .Y(n94) );
  nand2b1 U115 ( .A(n98), .B(n63), .Y(n97) );
endmodule


module ap_adder_1 ( x, y, z );
  input [15:0] x;
  input [15:0] y;
  output [15:0] z;
  wire   n1, n2, n4, n5, n6, n7, n8, n9, n10, n11;
  wire   [15:0] tmp;

  ap_adder_1_DW01_add_1 add_12 ( .A(y), .B(x), .CI(n11), .SUM(tmp) );
  or2c1 U3 ( .A(n4), .B(n8), .Y(n9) );
  inv1a1 U4 ( .A(n9), .Y(n2) );
  inv1a1 U5 ( .A(n9), .Y(n1) );
  ao1f1 U6 ( .A(n10), .B(n9), .C(n8), .Y(z[15]) );
  or3d1 U7 ( .A(x[15]), .B(y[15]), .C(n10), .Y(n8) );
  gnd U8 ( .Y(n11) );
  buf1a4 U9 ( .A(n7), .Y(n4) );
  or3d1 U10 ( .A(tmp[15]), .B(n6), .C(n5), .Y(n7) );
  inv1a1 U11 ( .A(y[15]), .Y(n6) );
  inv1a1 U12 ( .A(x[15]), .Y(n5) );
  inv1a1 U13 ( .A(tmp[15]), .Y(n10) );
  ao1d1 U14 ( .A(tmp[0]), .B(n2), .C(n4), .Y(z[0]) );
  ao1d1 U15 ( .A(tmp[1]), .B(n1), .C(n4), .Y(z[1]) );
  ao1d1 U16 ( .A(tmp[2]), .B(n2), .C(n4), .Y(z[2]) );
  ao1d1 U17 ( .A(tmp[3]), .B(n1), .C(n4), .Y(z[3]) );
  ao1d1 U18 ( .A(tmp[4]), .B(n1), .C(n4), .Y(z[4]) );
  ao1d1 U19 ( .A(tmp[5]), .B(n2), .C(n4), .Y(z[5]) );
  ao1d1 U20 ( .A(tmp[6]), .B(n2), .C(n4), .Y(z[6]) );
  ao1d1 U21 ( .A(tmp[7]), .B(n1), .C(n4), .Y(z[7]) );
  ao1d1 U22 ( .A(tmp[8]), .B(n1), .C(n4), .Y(z[8]) );
  ao1d1 U23 ( .A(tmp[9]), .B(n2), .C(n4), .Y(z[9]) );
  ao1d1 U24 ( .A(tmp[10]), .B(n2), .C(n4), .Y(z[10]) );
  ao1d1 U25 ( .A(tmp[11]), .B(n2), .C(n4), .Y(z[11]) );
  ao1d1 U26 ( .A(tmp[12]), .B(n1), .C(n4), .Y(z[12]) );
  ao1d1 U27 ( .A(tmp[13]), .B(n1), .C(n4), .Y(z[13]) );
  ao1d1 U28 ( .A(tmp[14]), .B(n2), .C(n4), .Y(z[14]) );
endmodule


module ClassiLayer ( reset, clock, Value, hidden_id, pixel, result, finish );
  input [11:0] Value;
  input [8:0] hidden_id;
  input reset, clock, pixel;
  output result, finish;
  wire   n_Logic1_, n_Logic0_, N2, N19, N20, N21, N22, N23, N24, N25, N26, N27,
         N28, N29, N30, N31, N32, N33, N34, n35, n38, n39, n40, n41, n42, n43,
         n44, n45, n46, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27,
         n28, n29, n30, n31, n32, n33, n34, n36, n37, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75;
  wire   [7:0] RandomData;
  wire   [15:0] activate_temp;
  wire   [7:0] SigmoidOutput;
  wire   [15:0] next_temp;
  wire   [15:0] temp;

  RandomGenerator_1 rnd ( .reset(reset), .clk(clock), .seed({n_Logic0_, 
        n_Logic0_, n_Logic1_, n_Logic1_, n_Logic1_, n_Logic1_, n_Logic1_, 
        n_Logic1_}), .dataOut(RandomData) );
  sigmoid_1 sg ( .sum(activate_temp), .s(SigmoidOutput) );
  ap_adder_1 adder_only ( .x(temp), .y({n4, n4, n4, n4, n4, n75, n2, n1, n74, 
        n73, n72, n71, n70, n69, n68, n67}), .z(next_temp) );
  fd2a2 temp_reg_15_ ( .D(N34), .CLK(clock), .CLR(n66), .Q(temp[15]) );
  fd2a2 temp_reg_14_ ( .D(N33), .CLK(clock), .CLR(n66), .Q(temp[14]) );
  fd2a2 temp_reg_13_ ( .D(N32), .CLK(clock), .CLR(n66), .Q(temp[13]) );
  fd2a2 temp_reg_12_ ( .D(N31), .CLK(clock), .CLR(n66), .Q(temp[12]) );
  fd2a2 temp_reg_11_ ( .D(N30), .CLK(clock), .CLR(n66), .Q(temp[11]) );
  fd2a2 temp_reg_8_ ( .D(N27), .CLK(clock), .CLR(n66), .Q(temp[8]) );
  fd2a2 temp_reg_9_ ( .D(N28), .CLK(clock), .CLR(n66), .Q(temp[9]) );
  fd2a2 temp_reg_10_ ( .D(N29), .CLK(clock), .CLR(n66), .Q(temp[10]) );
  fd2a2 temp_reg_0_ ( .D(N19), .CLK(clock), .CLR(n66), .Q(temp[0]) );
  fd2a1 temp_reg_5_ ( .D(N24), .CLK(clock), .CLR(n66), .Q(temp[5]) );
  fd2a1 temp_reg_4_ ( .D(N23), .CLK(clock), .CLR(n66), .Q(temp[4]) );
  fd2a1 temp_reg_7_ ( .D(N26), .CLK(clock), .CLR(n66), .Q(temp[7]) );
  fd2a1 temp_reg_6_ ( .D(N25), .CLK(clock), .CLR(n66), .Q(temp[6]) );
  fd2a1 temp_reg_2_ ( .D(N21), .CLK(clock), .CLR(n66), .Q(temp[2]) );
  fd2a1 temp_reg_1_ ( .D(N20), .CLK(clock), .CLR(n66), .Q(temp[1]) );
  fd2a1 temp_reg_3_ ( .D(N22), .CLK(clock), .CLR(n66), .Q(temp[3]) );
  inv1a2 U3 ( .A(next_temp[5]), .Y(n31) );
  inv1a2 U4 ( .A(next_temp[0]), .Y(n37) );
  inv1a2 U5 ( .A(next_temp[2]), .Y(n34) );
  inv1a2 U6 ( .A(next_temp[10]), .Y(n26) );
  inv1a2 U7 ( .A(next_temp[6]), .Y(n30) );
  inv1a1 U8 ( .A(next_temp[7]), .Y(n29) );
  ao4f0 U9 ( .A(n29), .B(n20), .C(n38), .D(n5), .Y(N26) );
  ao4f0 U10 ( .A(n26), .B(n6), .C(n45), .D(n5), .Y(N29) );
  and2a2 U11 ( .A(Value[8]), .B(pixel), .Y(n1) );
  and2a2 U12 ( .A(Value[9]), .B(pixel), .Y(n2) );
  inv1a4 U13 ( .A(reset), .Y(n66) );
  ao4f0 U14 ( .A(n36), .B(n6), .C(n44), .D(n5), .Y(N20) );
  ao4f0 U15 ( .A(n34), .B(n6), .C(n43), .D(n5), .Y(N21) );
  ao4b0 U16 ( .C(next_temp[8]), .D(n3), .B(n1), .A(n5), .Y(N27) );
  inv1a1 U17 ( .A(n20), .Y(n3) );
  inv1a0 U18 ( .A(next_temp[8]), .Y(n28) );
  ao4b0 U19 ( .C(next_temp[9]), .D(n3), .B(n2), .A(n5), .Y(N28) );
  inv1a0 U20 ( .A(next_temp[9]), .Y(n27) );
  ao4f0 U21 ( .A(n37), .B(n6), .C(n46), .D(n5), .Y(N19) );
  inv1a1 U22 ( .A(next_temp[15]), .Y(n21) );
  inv1a1 U23 ( .A(SigmoidOutput[6]), .Y(n64) );
  and2c0 U24 ( .A(n8), .B(n37), .Y(activate_temp[0]) );
  and2c0 U25 ( .A(n7), .B(n25), .Y(activate_temp[11]) );
  and2c0 U26 ( .A(n8), .B(n34), .Y(activate_temp[2]) );
  and2c0 U27 ( .A(n7), .B(n33), .Y(activate_temp[3]) );
  and2c0 U28 ( .A(n8), .B(n32), .Y(activate_temp[4]) );
  and2c0 U29 ( .A(n7), .B(n31), .Y(activate_temp[5]) );
  and2c0 U30 ( .A(n8), .B(n30), .Y(activate_temp[6]) );
  and2c0 U31 ( .A(n7), .B(n29), .Y(activate_temp[7]) );
  and2c0 U32 ( .A(n8), .B(n28), .Y(activate_temp[8]) );
  and2c0 U33 ( .A(n7), .B(n27), .Y(activate_temp[9]) );
  and2c0 U34 ( .A(n8), .B(n26), .Y(activate_temp[10]) );
  and2c0 U35 ( .A(n7), .B(n36), .Y(activate_temp[1]) );
  buf1a2 U36 ( .A(n20), .Y(n6) );
  and2c0 U37 ( .A(n7), .B(n21), .Y(activate_temp[15]) );
  and2c0 U38 ( .A(n8), .B(n24), .Y(activate_temp[12]) );
  and2c0 U39 ( .A(n7), .B(n23), .Y(activate_temp[13]) );
  and2c0 U40 ( .A(n8), .B(n22), .Y(activate_temp[14]) );
  nand2a0 U41 ( .A(n35), .B(n5), .Y(n20) );
  inv1a1 U42 ( .A(N2), .Y(n7) );
  inv1a1 U43 ( .A(N2), .Y(n8) );
  inv1a1 U44 ( .A(n46), .Y(n67) );
  inv1a1 U45 ( .A(n35), .Y(finish) );
  inv1a1 U46 ( .A(n43), .Y(n69) );
  inv1a1 U47 ( .A(n41), .Y(n71) );
  inv1a1 U48 ( .A(n39), .Y(n73) );
  inv1a1 U49 ( .A(n45), .Y(n75) );
  inv1a1 U50 ( .A(n44), .Y(n68) );
  inv1a1 U51 ( .A(n42), .Y(n70) );
  inv1a1 U52 ( .A(n40), .Y(n72) );
  inv1a1 U53 ( .A(n38), .Y(n74) );
  and2a2 U54 ( .A(pixel), .B(Value[11]), .Y(n4) );
  inv1a1 U55 ( .A(SigmoidOutput[5]), .Y(n65) );
  nand2a0 U56 ( .A(Value[0]), .B(pixel), .Y(n46) );
  nand2a0 U57 ( .A(Value[2]), .B(pixel), .Y(n43) );
  nand2a0 U58 ( .A(Value[4]), .B(pixel), .Y(n41) );
  nand2a0 U59 ( .A(Value[6]), .B(pixel), .Y(n39) );
  nand2a0 U60 ( .A(Value[10]), .B(pixel), .Y(n45) );
  nand2a0 U61 ( .A(Value[1]), .B(pixel), .Y(n44) );
  nand2a0 U62 ( .A(Value[3]), .B(pixel), .Y(n42) );
  nand2a0 U63 ( .A(Value[5]), .B(pixel), .Y(n40) );
  nand2a0 U64 ( .A(Value[7]), .B(pixel), .Y(n38) );
  buf1a2 U65 ( .A(n17), .Y(n5) );
  and2c0 U66 ( .A(hidden_id[1]), .B(hidden_id[4]), .Y(n16) );
  and2c0 U67 ( .A(hidden_id[3]), .B(n14), .Y(n15) );
  inv1a1 U68 ( .A(RandomData[3]), .Y(n61) );
  inv1a1 U69 ( .A(RandomData[1]), .Y(n63) );
  inv1a1 U70 ( .A(RandomData[2]), .Y(n62) );
  vdd U71 ( .Y(n_Logic1_) );
  gnd U72 ( .Y(n_Logic0_) );
  inv1a1 U73 ( .A(hidden_id[6]), .Y(n11) );
  inv1a1 U74 ( .A(hidden_id[2]), .Y(n10) );
  inv1a1 U75 ( .A(hidden_id[0]), .Y(n9) );
  nand3a1 U76 ( .A(n11), .B(n10), .C(n9), .Y(n14) );
  inv1a1 U77 ( .A(n14), .Y(n13) );
  and4a1 U78 ( .A(hidden_id[7]), .B(hidden_id[8]), .C(hidden_id[4]), .D(
        hidden_id[5]), .Y(n12) );
  nand4a0 U79 ( .A(hidden_id[1]), .B(hidden_id[3]), .C(n13), .D(n12), .Y(n35)
         );
  nand5d1 U80 ( .A(hidden_id[8]), .B(hidden_id[7]), .C(hidden_id[5]), .D(n16), 
        .E(n15), .Y(n17) );
  inv1a1 U81 ( .A(next_temp[1]), .Y(n36) );
  inv1a1 U82 ( .A(next_temp[3]), .Y(n33) );
  ao4f0 U83 ( .A(n33), .B(n6), .C(n42), .D(n5), .Y(N22) );
  inv1a1 U84 ( .A(next_temp[4]), .Y(n32) );
  ao4f0 U85 ( .A(n32), .B(n6), .C(n41), .D(n5), .Y(N23) );
  ao4f0 U86 ( .A(n31), .B(n6), .C(n40), .D(n5), .Y(N24) );
  ao4f0 U87 ( .A(n30), .B(n20), .C(n39), .D(n5), .Y(N25) );
  inv1a1 U88 ( .A(next_temp[11]), .Y(n25) );
  inv1a1 U89 ( .A(n5), .Y(n18) );
  nand2a1 U90 ( .A(n4), .B(n18), .Y(n19) );
  ao1f1 U91 ( .A(n25), .B(n6), .C(n19), .Y(N30) );
  inv1a1 U92 ( .A(next_temp[12]), .Y(n24) );
  ao1f1 U93 ( .A(n24), .B(n6), .C(n19), .Y(N31) );
  inv1a1 U94 ( .A(next_temp[13]), .Y(n23) );
  ao1f1 U95 ( .A(n23), .B(n6), .C(n19), .Y(N32) );
  inv1a1 U96 ( .A(next_temp[14]), .Y(n22) );
  ao1f1 U97 ( .A(n22), .B(n6), .C(n19), .Y(N33) );
  ao1f1 U98 ( .A(n21), .B(n6), .C(n19), .Y(N34) );
  nand3a1 U99 ( .A(hidden_id[3]), .B(hidden_id[2]), .C(hidden_id[0]), .Y(n47)
         );
  and3b1 U100 ( .B(hidden_id[5]), .C(hidden_id[1]), .A(n47), .Y(n48) );
  oa2i0 U101 ( .A(hidden_id[4]), .B(hidden_id[5]), .C(hidden_id[6]), .D(n48), 
        .Y(n49) );
  and3b1 U102 ( .B(hidden_id[7]), .C(hidden_id[8]), .A(n49), .Y(N2) );
  and2b1 U103 ( .B(RandomData[7]), .A(SigmoidOutput[7]), .Y(n60) );
  and2b1 U104 ( .B(SigmoidOutput[0]), .A(RandomData[0]), .Y(n51) );
  and2b1 U105 ( .B(n51), .A(RandomData[1]), .Y(n50) );
  oa7a1 U106 ( .A(n51), .B(n63), .C(SigmoidOutput[1]), .D(n50), .E(
        SigmoidOutput[2]), .F(n62), .Y(n52) );
  ao8a0 U107 ( .A(n61), .B(SigmoidOutput[3]), .C(n62), .D(SigmoidOutput[2]), 
        .E(n52), .Y(n53) );
  oa1a0 U108 ( .A(SigmoidOutput[3]), .B(n61), .C(n53), .Y(n55) );
  nand2b1 U109 ( .A(SigmoidOutput[4]), .B(RandomData[4]), .Y(n54) );
  oa4e0 U110 ( .C(n55), .D(n54), .B(RandomData[4]), .A(SigmoidOutput[4]), .Y(
        n57) );
  nand2c2 U111 ( .A(RandomData[5]), .B(n65), .Y(n56) );
  oa7g0 U112 ( .A(RandomData[6]), .B(n64), .C(n57), .D(n56), .E(RandomData[5]), 
        .F(n65), .Y(n58) );
  oa1d1 U113 ( .A(RandomData[6]), .B(n64), .C(n58), .Y(n59) );
  ao4e0 U114 ( .B(SigmoidOutput[7]), .A(RandomData[7]), .C(n60), .D(n59), .Y(
        result) );
endmodule


module Main ( reset, clock, Hvalue, pixel_id, pixel, adder_type, enable_hidden, 
        enable_classi, Cvalue, hidden_id, hidden_pixel, hidden, hidden_finish, 
        spike, finish );
  input [11:0] Hvalue;
  input [9:0] pixel_id;
  input [11:0] Cvalue;
  input [8:0] hidden_id;
  input reset, clock, pixel, adder_type, enable_hidden, enable_classi,
         hidden_pixel;
  output hidden, hidden_finish, spike, finish;
  wire   n_0_net_, n_1_net_;

  and2a2 U1 ( .A(hidden_pixel), .B(enable_classi), .Y(n_1_net_) );
  and2a2 U2 ( .A(pixel), .B(enable_hidden), .Y(n_0_net_) );
  RBMLayer rbm ( .reset(reset), .clock(clock), .Value(Hvalue), .pixel_id(
        pixel_id), .pixel(n_0_net_), .adder_type(adder_type), .result(hidden), 
        .finish(hidden_finish) );
  ClassiLayer classi ( .reset(reset), .clock(clock), .Value(Cvalue), 
        .hidden_id(hidden_id), .pixel(n_1_net_), .result(spike), .finish(
        finish) );
endmodule

