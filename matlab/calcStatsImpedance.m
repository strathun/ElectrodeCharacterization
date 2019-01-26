%finds mean and std. dev. at desired values
%Must run plotRealImpedance.m first!

freqVal = 1000; %Put frequency of interest here
[impFHeight,impFcol,impFelect] = size(f);

for i = 1:impFHeight;
    impFreq(i) = f(i,1,1);
end

[row, colInterest] = find(impFreq < freqVal,1,'first');   %finds the freq column of interest
numElectrodes = impFelect;

meanArray = 0;

for i = 1:numElectrodes
    meanArray(i) = impArray(i,colInterest);
end

meanImp = mean(meanArray)
stdImp = std(meanArray)