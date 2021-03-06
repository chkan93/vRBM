%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sign_bit = 1;
before_decimal = __before_decimal__;
after_decimal = __after_decimal__; %% 8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('../../data/mat/mnist_classify.mat'); 
load('../../data/mat/model0503.mat');

W_u  = model{1}.W;
Wc_u = model{1}.Wc;
bh_u = model{1}.b;
bc_u = model{1}.cc;


bitlength = sign_bit + before_decimal + after_decimal; % 1 sign bit, 3 bit, decimal, 8 bit
% bitlenght = 


tmp = 2^before_decimal;
scale = 2 * tmp / (2^bitlength);
W  = limitbit(W_u  , 1, scale , tmp);
Wc = limitbit(Wc_u , 1, scale , tmp);
bh  = limitbit(bh_u  , 1, scale , tmp);
bc = limitbit(bc_u , 1, scale , tmp);


%%% don't change here!!
export_data(sprintf('../../output/W_h.%d.txt', bitlength), W', after_decimal);
export_data(sprintf('../../output/W_c.%d.txt', bitlength), Wc, after_decimal);
export_data(sprintf('../../output/b_h.%d.txt', bitlength), bh, after_decimal);
export_data(sprintf('../../output/b_c.%d.txt', bitlength), bc, after_decimal);




