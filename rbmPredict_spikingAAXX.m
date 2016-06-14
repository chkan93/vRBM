function [prediction,spikes] = rbmPredict_spikingAAXX(model, testdata, experiments, data_range, data_rangei, data_bits)
%Use RBM to predict discrete label for testdata with limited precision
%code by Xiaojing Xu based on code of Andrej Karpathy
%last edit: 05-02-2016
%INPUTS:
% model          ... rbm model learnt 
%{
model 1x1 cell
        1x1 struct
            W  784x441
            b  1x441
            c  1x784
            Wc 10x784
            cc 1x10
            labels 1x10
%}
% testdata       ... testdata ===> 1000x784
% experiments    ... numbers of sampling before the inference stops ===> 100
% data_range     ... the range of weight(W) and bias(b) ===> 8 bits
% data_rangei    ... the range of W*x+b  ===> 8 bits
% data_bits      ... number of bits used to represent data

% verilog tips: there are many bit-length constraint operations in this
% function. All of them can be done in a very easy and efficient way in
% verilog, and there is no need to follow exactly what is implemented in
% this code.

W  = model.W;
Wc = model.Wc;
b = model.b;
cc = model.cc;
hidden_random = model.hidden_random;
classi_random = model.classi_random;
% % parameters for adder
% integer_length = 8; % 8 at least
% fractional_length = 4;
% bpb = 2;
% k1 = 5;
% aca_k = 2;
% adder_type = 'ETAIIM';

% round data to fixed bit-width
% verilog tips: this can be done offline
scale = 2 * data_range / (2^data_bits);
W  = limitbit(W  , 1, scale , data_range);
Wc = limitbit(Wc , 1, scale , data_range);
b  = limitbit(b  , 1, scale , data_range);
cc = limitbit(cc , 1, scale , data_range);

% export_data('W_h.txt', W', 8);
% export_data('W_c.txt', Wc, 8);
% export_data('b_h.txt', b, 8);
% export_data('b_c.txt', cc, 8);

% range and scale for accumulation
scalei = 2 * data_rangei / (2^data_bits);
% range(0 to 1) and scale for probability
scaley = 1/(2^data_bits);
scale_sg = 1/(2^data_rangei);

testdata = testdata>0.5;
numcases = size(testdata, 1);

spikes = zeros(numcases, 10);

% sampling
for experiment=1:experiments
    
    fprintf('iteration %d \n',experiment);
    % v->h
    sumi = zeros(numcases,length(b));
    %{
    sumi: 1000x441, 441 hidden units
    %}
    %%% ele = 1:784
    for ele = 1: size(testdata,2)
        %%% why this part is commented out?
        %[sumi, ~, ~] = inexact_add(sumi,testdata(:,ele)*W(ele,:),adder_type,bpb,k1,aca_k,integer_length,fractional_length,1);
        
        % verilog tips: this is the only part that should be done with RTL
        %%% 1000x441  +  1000x1 * 1x441
        %%% is not sampling but weight accumulating
        
%         sumi = sumi + testdata(:,ele)*W(ele,:);

            sumi = limitbit(sumi + testdata(1:numcases,ele)*W(ele,:), 1, scalei, 128); %%% ???????? ?16?????bitlength
            %%%% weight?bias?bitlength???12?
    end
    
    %[sumi, ~, ~] = inexact_add(sumi,repmat(b,numcases,1),adder_type,bpb,k1,aca_k,integer_length,fractional_length,1);
    sumi = sumi + repmat(b,numcases,1);
    
    sumi = limitbit(sumi,1, scalei, data_rangei);
    
    % verilog tips: only using 'PLAN', which means no need to code other
    % choices
    ph =  logisticXX(sumi,'PLAN');
    %phstates = limitbit(ph,scaley) > PRPG(size(ph),data_bits);
    % verilog tips: need a PRPG to generate random numbers. Have to code it
    % youself.. there are some useful code on the Internet
    %%% ph = 1000x441
    %%% random number is needed here
%     rd = limitbit(rand(size(ph)),1, scaley);
    rd = repmat(hidden_random(experiment,:)/(2^data_rangei), [size(ph, 1),1]);
    phstates = limitbit(ph, 0, scale_sg) > rd;
    %%%% rejection sampling, proved correctness asymptotically. 
    
    % h -> c  
    % verilog tips: same as above
    %%% classification layer
%     sumi = zeros(numcases, length(cc));
%     for ele = 1: size(phstates,2)
%         %[sumi, ~, ~] = inexact_add(sumi,phstates(:,ele)*Wc(:,ele)',adder_type,bpb,k1,aca_k,integer_length,fractional_length,1);
%         sumi = limitbit(phstates(:,ele)*Wc(:,ele)' + sumi, 1, scalei, 128);
%     end
    sumi = phstates*Wc' ;
    
    %[sumi, ~, ~] = inexact_add(sumi,repmat(cc,numcases,1),adder_type,bpb,k1,aca_k,integer_length,fractional_length,1);
    sumi = sumi + repmat(cc,numcases,1);

    sumi = limitbit(sumi,1, scalei, data_rangei);
    
    negclasses = logisticXX(sumi,'PLAN');
    %negclassesstates = negclasses > PRPG(size(negclasses),data_bits) ;
%     rcd =  limitbit(rand(size(negclasses)),1, scaley);
    rcd = repmat(classi_random(experiment, :)/(2^data_rangei), [size(negclasses,1), 1]);
    negclassesstates = limitbit(negclasses, 0, scale_sg) >  rcd;
    % store spikes
    spikes = spikes + negclassesstates;
end

%%%% why we do it for 100 times? ==> For asymptotic correctness

%take the max
[~, prediction]= max(spikes, [], 2);


%{
spikes 1000x10, first time I know max could be used this way...
%}