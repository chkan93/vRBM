iteration = 10;
test_data_id = 1;
hidden_seed = 4;
classi_seed= 4;


load('./mnist_classify.mat'); 
load('./model0503.mat');

Wh  = model{1}.W;
Wc = model{1}.Wc';
bh = model{1}.b;
bc = model{1}.cc;

data_range = 8;  %%%  ???? 2^3? +1????? ?????3+1?
data_rangei = 8; %%%  ?????
bitlength = 12;  %%%%  
numexperiments = 40;

scale = 2 * data_range / (2^bitlength);
scaley = 1/(2^data_range);

Wh  = limitbit(Wh  , 1, scale , data_range) * 2^bitlength;
Wc = limitbit(Wc , 1, scale , data_range) * 2^bitlength;
bh  = limitbit(bh  , 1, scale , data_range) * 2^bitlength;
bc = limitbit(bc , 1, scale , data_range) * 2^bitlength;
testdata = testdata > 0.5;



%%
hrnd = RandomGenerator(hidden_seed);
crnd =  RandomGenerator(classi_seed);
inputdata = testdata(test_data_id,:);

my_spikes = zeros(1, length(bc));
TempHidden = 0;
TempClassi = 0;
for i = 1:iteration
    fprintf('iteration %d\n', i)
    hidden_data = zeros(1, length(bh));
    for j = 1:length(bh)
        TempHidden = bh(j);
        for k = 1:length(inputdata)
            TempHidden = saturate(TempHidden + inputdata(k) * Wh(k, j));
            
        end
        hidden_data(j) = logisticXX(TempHidden/(2^data_range),'PLAN') > limitbit(rand(1),1, scaley);
    end
    
    classi_data = zeros(1, length(bc));
    for j = 1:length(bc)
        TempClassi = bc(j);
        for k = 1:length(hidden_data)
            TempClassi = saturate(TempClassi + hidden_data(k) * Wc(k, j));
        end
        classi_data(j) = logisticXX(TempClassi/(2^data_range),'PLAN') >
    end
    my_spikes = my_spikes + classi_data;
end


[~, prediction]= max(my_spikes, [], 2);
% fprintf('Classification error using RBM  is %f\n',sum(prediction~=testlabels)/length(prediction))

