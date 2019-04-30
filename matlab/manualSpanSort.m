%%

d = uigetdir(); 
listFiles = dir(d);
addpath(d);
fnames = {listFiles.name}'; %returns cell array

% Creates a new directory in the same folder as original
newDirectory = [d '_curated'];
if(~exist(newDirectory))
    mkdir(newDirectory)
end



for jj = 0:15    % Eventually make work with all 16 channels
    channel = dec2bin(jj,4);
    traceMatrixY = [];   % initializes matrix for each channel
    traceMatrixX = [];   % initializes matrix for each channel
    
    for ii=1:length(fnames) 
        file = fnames{ii};
        
        if ~isempty(findstr(file,channel))  % searches for any recordings of specified channel
            load(file)
            traceMatrixY = [traceMatrixY; y];
            traceMatrixX = [traceMatrixX; x];
        end
        
    end

% Allows user to select bad spans to be removed    
    [sectionIndices] = userTraceSelection(traceMatrixX, traceMatrixY, 1, [10 1e6]);
     
% Cuts out bad traces and averages any of the same spans. Then creates a
% new data file with the improved 'y' variables. 'x' is not changed since
% this is fixed and should be unaffected by bad recordings
    [numSpans, ~] = size(x);                                   % Number of spans per recording
    traceMatrixY(sectionIndices,:) = NaN;                      % Hides selected indices for averaging
    y = [];                                                    % Deletes old y to be filled back up
    for ii = 1:numSpans
        y(ii,:) = nanmean(traceMatrixY(ii:numSpans:end,:));    % mean of every nth row
    end
    
% Saves the updated workspace. 'run_name' is loaded with the original 
% workspace
    newFileName = [newDirectory '\'];
    newFileName = [newFileName run_name];
    save(newFileName);
    
% Plot data as a final check
    [totalSpans, ~] = size(traceMatrixY);
    keepers = 1:1:totalSpans;
    keepers(sectionIndices) = [];
    
    figure
    loglog(traceMatrixX(keepers,:)', traceMatrixY(keepers,:)')
    xlim([10 1e6])
    
end
