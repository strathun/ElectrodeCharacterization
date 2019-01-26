% % Will rename all .dta files to .txt in the selected folder

% Which curve do you want to grab?
curve = 8;
dataRows = 1400;    % number of rows in a CV cycle. (See .dta file to change)
dataColumns = 11;   % number of columns in a CV cycle. (See .dta file to change)

d = uigetdir();
currentFolder = pwd;
cd(d)

%change .dat files to ..txt files for processing
system(['rename ' '*.dta ' '*.txt']);

listFiles = dir(d);
fnames = {listFiles.name}'; %returns cell array
fnames = fnames(cellfun(@(x) length(x) >= 5, fnames));
fnames = string(fnames);

%%
for electrode = 1:length(fnames)
    
    fid = fopen(fnames(electrode));
    sniffer = sprintf('CURVE%d', curve);
    tf = 0;
    line = 0;

    %scans the text document looking for Curve#
    while tf == 0
        tf = contains(fgetl(fid),sniffer);
        line = line + 1;
    end

    [dataArray] = textToArray( fnames(electrode), line + 1, dataRows, dataColumns );  % line + 1 because header is 2 lines long

    figure
    plot(dataArray(2:end,4),dataArray(2:end,5),'.')
%     plot(dataArray(2:end,4),smooth(dataArray(2:end,5),20,'moving'),'LineWidth',2)
end

