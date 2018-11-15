clc;%Need to clear frequencies and PSDs so plotNoise functions correctly
clear x y frequencies final_PSDs

% Av=400;
AvLow = 346;
AvHigh =385;
% Av=385; %HS3
% Av=334; %Low F
%Load grounded input
% PSD_gnd=y(1:end,:)'./AvLow;
load('2017-06-23_15hr_25min_58sec_gnd__highF_Av389_gnd.mat')

PSD_gnd=y(1:end,:)'./AvHigh;

%Load electrode to subtract grounded measurement from
% PSD_el=y'./AvLow;
load('2017-11-15_12hr_26min_17sec_elec_1000_highF_Av369_HS_5.6.mat')
PSD_el=y'./AvHigh;

final_PSDs=sqrt(PSD_el.^2-PSD_gnd.^2);

%Set title for plot
% plotTitleNote = 'Av350 LowF Electrode Noise';

% plotNoiseData;

% hold on;

%% semilogX plot 
semilogx(x',final_PSDs/1e-9)%.*(1+x'./14e6).*(1+x'./8e6))
% xlim([100 20e3]) % LowF
xlim([10e3 2e6]) %HighF
ylim([1 100])
ylabel('sqrt(PSD) (nV/rtHz)') 
xlabel('Frequency (Hz)')
hold on;


% hold on;plot(x',ones(size(x'))*sqrt(4*kT*3.1e3)*1e9)
% plot(x',ones(size(x'))*sqrt(4*kT*3.3e3)*1e9)

%%

[f, P] =mergeSpans(x, final_PSDs, 1, 'fast');
semilogx(f,P*1e9);
% xlim([100 16e3])
hold on;