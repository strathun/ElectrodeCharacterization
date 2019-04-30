function [sectionIndices] = userTraceSelection(rawX, rawY, plotStyle, xlimits)
%[sectionIndices] = userTraceSelection(rawX, rawY, plotStyle, xlimits)
% This function allows the user to select traces from a figure by "drawing" 
% a line (selecting start and ending point of the line) on a figure. Any
% traces that this line passes through will be selected.
%
%   Inputs:
%       rawX: raw data arranged where rows are a single trace [rawX MUST =
%       rawY]
%       rawY: raw data arranged where rows are a single trace
%       plotStyle: 0 for linear, 1 for loglog
%       xlimits: [xmin xmax]
%   Outputs:
%       selectionIndices: row numbers of selected data

sectionIndices = [];
[numTraces, ~] = size(rawY);

keepinOn = 1;
while keepinOn == 1
    figure
    for ii = 1:numTraces
        if plotStyle == 0
            plot(rawX(ii,:),rawY(ii,:))
        elseif plotStyle == 1
            loglog(rawX(ii,:),rawY(ii,:))
            xlim(xlimits);
        end
        hold on
    end


[x, y] = ginput(2);

% Search for data within user defined points
% Gets x limits and then searches for y values within those limits
    for ii = 1:numTraces
        tempX = rawX(ii,:);
        matchingXVals = tempX(tempX > x(1) & tempX < x(2));

        if ~isempty(matchingXVals)
            minXVals = min(matchingXVals);
            maxXVals = max(matchingXVals);
            minXVals = find(tempX == minXVals); % converts to indices for y search
            maxXVals = find(tempX == maxXVals); % converts to indices for y search
            
            tempY = rawY(ii,minXVals:maxXVals);
            matchingYVals = tempY(tempY > y(1) & tempY < y(2));
            if ~isempty(matchingYVals)
                sectionIndices = [sectionIndices; ii]; % if row has data within user defined points, record row index
            end
            
        end

    end

prompt = 'Press "Enter" to move on to next. Type "1" to select more traces on the current figure ';
keepinOn = input(prompt);

% Hides rows for any secondary plotting
    if ~isempty(sectionIndices)
        rawX(sectionIndices,:) = NaN;
        rawY(sectionIndices,:) = NaN;
        close
    end
    
end

end

