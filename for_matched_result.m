test_data_id = 0;
iteration_count = 2;
% hidden_seed = 248; %% 242
% classi_seed= 182; %% 98
% hrnd = RandomGenerator(hidden_seed);
% crnd =  RandomGenerator(classi_seed);

load('./mat_data/1000.mat');
load('./mat_data/mnist_classify.mat'); 
load('./mat_data/model0503.mat');


testdata = testdata > 0.5;
data_range_int = 8;
data_range_float = 8;
bitlength = 12;
test_data_id = test_data_id + 1;
scalei = 2 * data_range_float / (2^bitlength);
scaley = 1/(2^bitlength);
input_data = testdata(test_data_id,:);
Wh  = model{1}.W;
Wc = model{1}.Wc';
bh = model{1}.b;
bc = model{1}.cc;

Wh  = limitbit(Wh  , 1, scalei , 8);
Wc = limitbit(Wc , 1, scalei , 8);
bh  = limitbit(bh  , 1, scalei , 8);
bc = limitbit(bc , 1, scalei , 8);

Wh_v = Wh*256;
Wc_v = Wc*256;

spikes = zeros(1, 10);

for i = 1:iteration_count
    fprintf('Iteration %d \n', i)
    %% hidden layer
    hidden_data = zeros(1, length(bh));
    for j = 1:length(bh)
        TempHidden = bh(j);
        for k = 1:length(input_data)
            TempHidden = limitbit(TempHidden + input_data(k) * Wh(k, j), 1, scalei, 2^(data_range_int-1));
%              if j == 2
%                 fprintf('layer 1, inputdata[%d] = %d, temp = %d\n', k-1, input_data(k), TempHidden*256)
%             end

        end
%         hidden_data(j) = logisticXX(TempHidden,'PLAN') > (hrnd.get()/(2^data_range_float));
          fprintf('1: %d => %d >< %d\n',TempHidden*2^data_range_float,(limitbit(logisticXX(TempHidden,'PLAN'),0,1/256)*(2^data_range_float)), hidden_random(i,j))
        hidden_data(j) = (limitbit(logisticXX(TempHidden,'PLAN'), 0, 1/256)*(2^data_range_float)) > hidden_random(i,j);
    end
    
    
    %% classi layer
    classi_data = zeros(1, length(bc));
    for j = 1:length(bc)
       TempClassi = bc(j);
       for k = 1:length(hidden_data)
            TempClassi = limitbit(TempClassi + hidden_data(k) * Wc(k, j), 1, scalei, 2^(data_range_int-1));
%             if j == 1
%                 fprintf('layer 2, inputdata[%d] = %d, temp = %d\n', k-1, hidden_data(k), TempClassi*256)
%             end
       end
%        classi_data(j) = logisticXX(TempClassi,'PLAN') > (crnd.get()/(2^data_range_float));
        fprintf('2: %d => %d >< %d\n', TempClassi*2^data_range_float,(limitbit(logisticXX(TempClassi,'PLAN'),0,1/256)*(2^data_range_float)), classi_random(i,j))
       classi_data(j) = (limitbit(logisticXX(TempClassi,'PLAN'), 0, 1/256)*(2^data_range_float)) > classi_random(i,j);
    end
    spikes = classi_data + spikes;
end


disp('spikes = ');
spikes
disp('Is it matched? :)')