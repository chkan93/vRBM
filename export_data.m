function [ output_args ] = export_data( fileName, data, n, bitlength)
%EXPORT_DATA Summary of this function goes here
%   Detailed explanation goes here
[s1,s2] = size(data);
edata = reshape(data, [1, s1*s2]);
fileID = fopen(fileName,'w');
v = edata * (2^n);
MAX=2^(bitlength-1);
v(v>=MAX) = MAX-1;
fprintf(fileID,'%d\n', v);
fclose(fileID);
end

