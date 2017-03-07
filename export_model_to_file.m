%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
before_decimal = 7; %% bit number for whole number
after_decimal = 56; %% bit number for decimal

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sign_bit = 1;
load('./mat_data/mnist_classify.mat'); 
% load('./model0307.mat');
load ./mat_data/model0503.mat

W_u  = model{1}.W;
Wc_u = model{1}.Wc;
bh_u = model{1}.b;
bc_u = model{1}.cc;


bitlength = sign_bit + before_decimal + after_decimal; % 1 sign bit, 3 bit, decimal, 8 bit
% bitlenght = 


tmp = 2^before_decimal;
scale = 2 * tmp / (2^bitlength);
% limitbit(matrix, signOrUnsign, scale, tmp)
% consider split the W,bh, if first 200 12bit, rest 241 4bit, then 200x784 ->
% 12bit, 241x784 -> 4bit, then recombine, how to split the weight depends
% on order.mat
W  = limitbit(W_u  , 1, scale , tmp); 
bh  = limitbit(bh_u , 1, scale , tmp);

%%% bit precision won't affect classification layer
Wc = limitbit(Wc_u , 1, scale , tmp);
bc = limitbit(bc_u , 1, scale , tmp);



% the weight matrix passed to export_data function, must have size like 10x441,
% 441x784 (first dim < second dim)
%%% don't change here!!
export_data(sprintf('generated_data/W_h.%d.txt', bitlength), W', after_decimal, bitlength);
export_data(sprintf('generated_data/W_c.%d.txt', bitlength), Wc, after_decimal, bitlength);
export_data(sprintf('generated_data/b_h.%d.txt', bitlength), bh, after_decimal, bitlength);
export_data(sprintf('generated_data/b_c.%d.txt', bitlength), bc, after_decimal, bitlength);




