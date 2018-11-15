%% NOt done. Don't use.
% d = uigetdir();
% 
% currentFolder = pwd;
% cd(d)
% system(['rename ' '*.dta ' '*.txt']);

fid = fopen('UEA3_15Day01_E14.txt');
line_ex = fgetl(fid);
n = 1;
while ischar(line_ex)
    line_ex = fgetl(fid);
    n = n+1;
    l = length(line_ex);
    if l > 100
        startLine = n;
    end
end

numRows = n-startLine;

fclose(fid);

