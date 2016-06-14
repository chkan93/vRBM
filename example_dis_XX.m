
load 1000_new.mat
load mnist_classify.mat  
load model0503.mat


image_num = 1000;


data_range = 8;  %%%  ???? 2^3? +1????? ?????3+1?
data_rangei = 8; %%%  ?????
bitlength = 12;  %%%%  
numexperiments = 100; %% 45th iteration ??

model{1}.hidden_random = hidden_random;
model{1}.classi_random = classi_random;


% predict
tic
[yhat, spikes]=rbmPredict_spikingAAXX(model{1},testdata(1:image_num,:)>0.5,numexperiments,data_range,data_rangei,bitlength);
%yhat=rbmPredict_spikingAAstatXX(model{1},testdata>0.5,numexperiments,data_range,data_rangei,bitlength,appnum);
toc


classify_result = yhat~=testlabels(1:image_num);

%print error
fprintf('Classification error using RBM  is %f\n',sum(classify_result)/length(yhat))
