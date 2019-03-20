%% Script to generate impedance plots for 20190301 presentation

nameArray{1} = '2019-02-22_TDT14_PreSurge_PBSTests\1x_r1_PBS';
nameArray{2} = '2019-02-22_TDT14_PreSurge_PBSTests\0_01xPBS';
nameArray{3} = '2019-02-22_TDT14_PreSurge_PBSTests\0_05xPBS';
nameArray{4} = '2019-02-22_TDT14_PreSurge_PBSTests\0_10xPBS';
nameArray{5} = '2019-02-22_TDT14_PreSurge_PBSTests\0_50xPBS';
nameArray{6} = '2019-02-22_TDT14_PreSurge_PBSTests\1x_r2_PBS';

for jj = 1:6
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
legend('1','2','3','4','5','6')