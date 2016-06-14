classdef RandomGenerator < handle
    %RANDOMGENERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public)
        seed = 0;
        prev = -1;
        bits = 8;
    end
    
    methods
        function this = RandomGenerator(seed)
            this.seed = uint8(seed);
        end
        
        function n = get(this)
            if this.prev == -1
                this.prev = this.seed;
            else 
                shiftIn = xor(xor(xor(bitget(this.prev, 4), bitget(this.prev, 5)), ...
                                      bitget(this.prev, 6)), bitget(this.prev, 8));
                shiftIn = xor(this.prev == 0, shiftIn);
                this.prev = bitset(bitshift(this.prev, 1), 1, shiftIn);
            end            
            n = this.prev;
        end
    end
    
end

