%% Script to generate impedance plots

nameArray{1} = 'TDT3_InVitro - Copy/Impedance';
nameArray{2} = 'TDT3_Surgery - Copy/Impedance';
[~, numPath] = size(nameArray);

for jj = 1:numPath
    str = nameArray{jj};
    for ii = 1:16
        [f, Zreal, Zim, Phase] = ...
            extractImpedanceData(str);

    end
        Zreal_Array(jj,:) = mean(Zreal,3)';
        Zmag_array(jj,:) = sqrt(Zreal_Array(jj,:).^2);
        Phase_Array(jj,:) = mean(Phase,3)';
end


loglog(f(:,1,1),Zreal_Array)
ylabel('Impedance (Ohms)')
grid on