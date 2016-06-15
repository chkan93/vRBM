function [ y ] = create_ord( x )
%CREATE_ORD Summary of this function goes here
%   Detailed explanation goes here
l = 0;
for i=1:length(x)
   l = l + length(x{i}); 
end
y = zeros(1, l);

i = 2;
while i <= length(x)
    t = x{i};
    y(t(:)+1) = i-1;
    i=i+1;
end
end

