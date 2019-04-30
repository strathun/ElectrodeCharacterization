%% Script to generate impedance plots

nameArray{1} = '2018-05-10_TDT6_Day03/Impedance';

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

yyaxis left
loglog(f(:,1,ii),Zreal_Array)
ylabel('Impedance (Ohms)')
hold on
yyaxis right
loglog(f(:,1,ii),Phase_Array)
ylabel('Degrees')
xlabel('Frequency (Hz)')
grid on
legend('PBS','diH20')