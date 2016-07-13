function [ distr ] = generate_criticality( arr, num )
%   GENERATE_CRITICALITY Summary of this function goes here
%   Detailed explanation goes here
%   iadder => 1, adder => 0
distr = zeros(1, length(arr)+1);
distr(arr <= num) = 1;
distr(end) = 0;
end

