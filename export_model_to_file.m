load('./mat_data/mnist_classify.mat'); 
% load('./model0307.mat');
load ./mat_data/model0503.mat

W  = model{1}.W;
Wc = model{1}.Wc;
bh = model{1}.b;
bc = model{1}.cc;

data_range = 8;
data_rangei = 8; 
bitlength = 12;

numexperiments = 40;
scale = 2 * data_range / (2^bitlength);
scaley = 1/(2^data_range);
W  = limitbit(W  , 1, scale , data_range);
Wc = limitbit(Wc , 1, scale , data_range);
bh  = limitbit(bh  , 1, scale , data_range);
bc = limitbit(bc , 1, scale , data_range);


%%% don't change here!!
export_data('generated_data/W_h.txt', W', 8);
export_data('generated_data/W_c.txt', Wc, 8);
export_data('generated_data/b_h.txt', bh, 8);
export_data('generated_data/b_c.txt', bc, 8);




