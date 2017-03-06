iteration_count = 1;

sign_bit = 1;
before_decimal = 3;
after_decimal = 8; %% 8

consider_adder_saturation = 0;

% hidden_seed = 248; %% 242
% classi_seed= 182; %% 98
% hrnd = RandomGenerator(hidden_seed);
% crnd =  RandomGenerator(classi_seed);

load('./mat_data/1000.mat');
load('./mat_data/mnist_classify.mat'); 
load('./mat_data/model0503.mat');
fid = fopen('./generated_data/selected_mnist/image_2.txt');
input_data=textscan(fid,'%f');
input_data = input_data{1}';
fclose(fid);


data_range_int = 2^before_decimal;
data_range_float = after_decimal;
bitlength = sign_bit + before_decimal + after_decimal;
% test_data_id = test_data_id + 1;
scalei = 2 * data_range_int / (2^bitlength);
scaley = 1/(2^bitlength);

Wh  = model{1}.W;
Wc = model{1}.Wc';
bh = model{1}.b;
bc = model{1}.cc;

Wh  = limitbit(Wh  , 1, scalei , data_range_int);
Wc = limitbit(Wc , 1, scalei , data_range_int);
bh  = limitbit(bh  , 1, scalei , data_range_int);
bc = limitbit(bc , 1, scalei , data_range_int);

MAX = 2^(bitlength-1);

Wh(Wh>=MAX) = MAX-1;
Wc(Wc>=MAX) = MAX-1;
bh(bh>=MAX) = MAX-1;
bc(bc>=MAX) = MAX-1;

spikes = zeros(1, 10);

for i = 1:iteration_count
    fprintf('Iteration %d \n', i)
    %% hidden layer
    hidden_data = zeros(1, length(bh));
    for j = 1:length(bh)
        TempHidden = bh(j);
        for k = 1:length(input_data)
            TempHidden = TempHidden + input_data(k) * Wh(k, j);
            if consider_adder_saturation
                TempHidden = limitbit(TempHidden, 1, scalei, data_range_int);
            end
        end
        
          fprintf('1: (b=%d) %d => %d >< %d\n',bh(j)*2^data_range_float,  TempHidden*2^data_range_float,    (limitbit(logisticXX(TempHidden,'PLAN'),0,  1/2^data_range_float)*(2^data_range_float)), hidden_random(i,j))
        hidden_data(j) = (limitbit(logisticXX(TempHidden,'PLAN'), 0, 1/256)*(2^data_range_float)) > hidden_random(i,j);
    end
    
    
    %% classi layer
    classi_data = zeros(1, length(bc));
    for j = 1:length(bc)
       TempClassi = bc(j);
       for k = 1:length(hidden_data)
            TempClassi = limitbit(TempClassi + hidden_data(k) * Wc(k, j), 1, scalei, data_range_int);
%             if j == 1
%                 fprintf('layer 2, inputdata[%d] = %d, temp = %d\n', k-1, hidden_data(k), TempClassi*256)
%             end
       end
%        classi_data(j) = logisticXX(TempClassi,'PLAN') > (crnd.get()/(2^data_range_float));
        fprintf('2: %d => %d >< %d\n', TempClassi*2^data_range_float,(limitbit(logisticXX(TempClassi,'PLAN'),0,1/2^data_range_float)*(2^data_range_float)), classi_random(i,j))
       classi_data(j) = (limitbit(logisticXX(TempClassi,'PLAN'), 0, 1/256)*(2^data_range_float)) > classi_random(i,j);
    end
    spikes = classi_data + spikes;
end


disp('spikes = ');
spikes
disp('Is it matched? :)')