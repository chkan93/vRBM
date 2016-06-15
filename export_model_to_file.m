load('./mnist_classify.mat'); 
% load('./model0307.mat');
load model0503.mat

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
export_data('W_h.txt', W', 8);
export_data('W_c.txt', Wc, 8);
export_data('b_h.txt', bh, 8);
export_data('b_c.txt', bc, 8);

h_adder_1 = [1:2:440];
h_adder_2 = [0:2:440];

c_adder_1 = [1:2:9];
c_adder_2 = [0:2:9];

h_adder = create_ord({h_adder_1, h_adder_2});
c_adder = create_ord({c_adder_1,  c_adder_2});

export_data('h_adder_ord_example.txt', h_adder, 0);
export_data('c_adder_ord_example.txt', c_adder, 0);


