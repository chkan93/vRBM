function [ output_args ] = randbitstream( num )
%RANDBITSTREAM Summary of this function goes here
%   Detailed explanation goes here
output_args = 'sd';
stream = randi([0 1],num,1);
ccell = cell(1, num);
for i=1:length(stream)
    ccell{i} = num2str(stream(i));

end
    output_args = strjoin(ccell,'');
end

