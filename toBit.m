function [ output_args ] = toBit( num, bits, bits_n )
%TOBIT Summary of this function goes here
%   Detailed explanation goes here
    output_args = dec2bin(num*2^bits, bits_n);

end

% toBit(5, 60, 64)
