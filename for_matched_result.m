% iteration must be one!!!!!
iteration_count = 1;


sign_bit = 1;
before_decimal = 7;
after_decimal = 56; %% 8

consider_adder_saturation = 0;


bitlength = sign_bit + before_decimal + after_decimal;
load('./mat_data/mnist_classify.mat'); 
load('./mat_data/model0503.mat');
input_data = read_file('./generated_data/selected_mnist/image_2.txt');
classi_random = read_file(strcat('./mat_data/random/bit_', num2str(bitlength), '/10.txt'));
hidden_random = read_file(strcat('./mat_data/random/bit_', num2str(bitlength), '/441.txt'));


data_range_int = 2^before_decimal;
data_range_float = after_decimal;

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
        
           activation = (limitbit(logisticXX(TempHidden,'PLAN'),0,  1/2^(bitlength-4))*(2^(bitlength-4)));
        
          fprintf('RBM: %d => %d >< %d\n', TempHidden*2^data_range_float,    activation, hidden_random(j))
        hidden_data(j) = activation > hidden_random(j);
    end
    
    
    %% classi layer
    classi_data = zeros(1, length(bc));
    for j = 1:length(bc)
       TempClassi = bc(j);
       for k = 1:length(hidden_data)
            TempClassi = TempClassi + hidden_data(k) * Wc(k, j);
            if consider_adder_saturation
                TempClassi = limitbit(TempClassi, 1, scalei, data_range_int);
            end
       end

        activation = (limitbit(logisticXX(TempClassi,'PLAN'),0,1/2^(bitlength-4))*(2^(bitlength-4)));
        fprintf('CLASS: %d => %d >< %d\n', TempClassi*2^data_range_float, activation, classi_random(j))
       classi_data(j) = activation > classi_random(j);
    end
    spikes = classi_data + spikes;
end


disp('spikes = ');
spikes
disp('Is it matched? :)')



function v = read_file(p)
fid = fopen(p);
v=textscan(fid,'%f');
v = v{1}';
fclose(fid);
end