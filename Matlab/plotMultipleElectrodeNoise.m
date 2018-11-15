clc;clear all
%config
Av = 342;

d = uigetdir();
currentFolder = pwd;
cd(d)
listFiles = dir('*elec*');
lowGndFiles = dir('*gnd__lowF*');
lowGndFile = cell2mat({lowGndFiles.name}');

fnames = {listFiles.name}'; %returns cell array

for ii = 1:length(fnames)
    % Format data to usable format
    fname = cell2mat(fnames(ii));
    [x, Vnoise] = subtractNoise( Av, lowGndFile, fname );
    [f, P] = mergeSpans(x, Vnoise, 0);
    semilogx(f,P/1e-9)
    hold on;
end


ylabel('sqrt(PSD) (nV)') 
xlabel('Frequency (Hz)')