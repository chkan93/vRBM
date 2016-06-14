function [ o ] = saturate( x )
%SATURATE Summary of this function goes here
%   Detailed explanation goes here
if x > 2047 
                    o = 2047; 
                elseif x < -2048 
                    o = -2048;  
                else                        
                    o = x; 
                end; 

end

