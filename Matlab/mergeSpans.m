function [catF,  catPSDs ] = mergeSpans( freqs, PSDs, range, type )
%merges standardized spans, set range = 1 for high, 0 for low.
%   High: centers =  [2^15 2^16 2^18 2^20]; 
%   Low:  centers =  [100 2^9  2^11 2^12 2^13];
    F = freqs';
    if range
        if strcmp(type,'fast')
            catPSDs = [PSDs(52:end,1); PSDs(102:end,2); PSDs(102:end,3)];
            catF = [F(52:end,1); F(102:end,2); F(102:end,3)];
        elseif strcmp(type, 'reg')
            catPSDs = [PSDs(:,1); PSDs(202:end,2); PSDs(102:end,3); PSDs(102:end,4)];
            catF = [F(:,1); F(202:end,2); F(102:end,3); F(102:end,4)];
        elseif strcmp(type, 'short')
            catPSDs = [PSDs(101:end,1); PSDs(202:end,2); PSDs(102:end,3)];
            catF = [F(101:end,1); F(202:end,2); F(102:end,3)];
        end
    else
        if strcmp(type, 'fast')
            catPSDs = [PSDs(:,1); PSDs(202:end,2); PSDs(201:end,3)];
            catF = [F(:,1); F(202:end,2); F(201:end,3)];
        end
        if strcmp(type, 'slow')
            catPSDs = [PSDs(1:end-1,1); PSDs(79:end-1,2); PSDs(101:end-1,3); PSDs(201:end-1,4); PSDs(201:end,5)];
            catF = [F(1:end-1,1); F(79:end-1,2); F(101:end-1,3); F(201:end-1,4); F(201:end,5)];
        end
        
    end
end

