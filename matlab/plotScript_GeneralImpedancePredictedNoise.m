%% Script to generate impedance predicted noise
% Put this script outside the impedance folder you want to analyze. 

currentFile = mfilename( 'fullpath' );
impPath = fileparts(currentFile);
impPath = [impPath '\Impedance'];
cd(impPath);

[~, numPath] = size(nameArray);

for jj = 1:numPath
    str = nameArray{jj};
    for ii = 1:16
        [f, Zreal, Zim, Phase] = ...
            extractImpedanceData(str);

    end
    Zreal_Array(jj,:) = mean(Zreal,3)';
    Phase_Array(jj,:) = mean(Phase,3)';

end

% Converts to noise spectrum
kT=300*1.38e-23;
Z = sqrt(Zreal.^2);
noiseImpArray = sqrt(4*kT*Z(:,1,:))*1e9; % Units: nV/rt(Hz)
noiseImpArray = flip(noiseImpArray,2);
