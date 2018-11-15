%%finds mean and std. dev. at desired values

freqVal = 100e3; %Put frequency of interest here

[row, colInterest] = find(fref<freqVal,1,'last');   %finds the freq column of interest
numElectrodes = size(cumMeas,1);

meanArray = 0;

for i = 1:numElectrodes
    meanArray(i) = cumMeas(i,colInterest)*1e3;
end

meanNoise = mean(meanArray)
stdNoise = std(meanArray)