function [ output_args ] = export_data( fileName, data, n )
%EXPORT_DATA Summary of this function goes here
%   Detailed explanation goes here
[s1,s2] = size(data);
edata = reshape(data, [1, s1*s2]);
fileID = fopen(fileName,'w');
fprintf(fileID,'%d\n', edata * (2^n));
fclose(fileID);
end

