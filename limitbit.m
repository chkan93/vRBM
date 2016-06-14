% represent x in Qm.n format (fixed-point, m bits before the decimal point,
% n bits after)
% scale = 2^(-n)
%{
scale  = 0.0625 => 2^(-4); // after decimal
data_range = 2^3 = 8 , or 8 bits
sign bit 1

%}
% data_range = 2^(m-1) for signed number

% verilog tips: this can be done very easily in verilog. Just remove those
% unwanted bits and add 1 (useceil here)
function output = limitbit(input, useceil, scale, data_range)  %%% scale => ???????, data_range, ?????? ?????
if (nargin == 4)
    %%% thresholding, data range is what? why not passing n,m directly?
    input(input>=data_range)   = data_range-scale/2; input(input<=-data_range)   = -data_range+scale/2;
else %% difference between?
    input(input>=1) = 1-scale/2;
    input(input<=0) = scale/2;
end
if (useceil)
    output = scale * ceil( input / scale);
else
    output = scale * floor( input / scale);
end
