function [ str ] = stringify_array( arr )
%STRINGIFY_ARRAY Summary of this function goes here
%   Detailed explanation goes here
    str = strrep(strrep(strrep(mat2str(arr),'[', '{'), ']', '}'), ' ', ', ');
    
    %%% {0,1,0,1,0,1,0,1}
    %%% 1 => true adder
    %%% 0 => inaccurate adder
end

