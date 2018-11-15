%% J-ERM Plotting 
% Should be run in a folder with sub-folders for each electrode of  
% interest, each subfolder should have the same number of impedance data 
% as electrodes and impedance needs to be in folder called 'Impedance'
clear all;
kT=300*1.38e-23;
%% config
font_size = 16; font_name = 'Arial';

%% Gather the data
getDir = pwd;
D = dir(getDir);
folderNames = {D.name}'; %returns cell array

d = folderNames{3}
[frec1 prec1 Z1 ] = GatherData(d);
% clearvars -except keepVariables
d = folderNames{4}
[frec2 prec2 Z2 ] = GatherData(d);

d = folderNames{5}
[frec3 prec3 Z3 ] = GatherData(d);

d = folderNames{6}
[frec4 prec4 Z4 ] = GatherData(d);

d = folderNames{7}
[frec5 prec5 Z5 ] = GatherData(d);

d = folderNames{8}
[frec6 prec6 Z6 ] = GatherData(d);

d = folderNames{9}
[frec7 prec7 Z7 ] = GatherData(d);

d = folderNames{10}
[frec8 prec8 Z8 ] = GatherData(d);

d = folderNames{11}
[frec9 prec9 Z9 ] = GatherData(d);

d = folderNames{12}
[frec10 prec10 Z10 ] = GatherData(d);

%% Noise Plots for all arrays
for ii = 1:10
    frec = genvarname(['frec' num2str(ii)]);
    prec = genvarname(['prec' num2str(ii)]);
    zrec = genvarname(['Z' num2str(ii)]);
    F = eval(frec);
    P = eval(prec);
    Z = eval(zrec);
    figure(ii)
    loglog(F',P'); hold on
    loglog(F', sqrt(4*kT*Z))
    xlim([100 500e3]);
end


%% Total Integrated Noise Measured
[L W] = size(frec1);
figure(30)
start = 10;
fref = frec1(1,:);
for jj = 1:L
    cumMeas(jj,:) = cumtrapz(frec1(jj,start:end),prec1(jj,start:end));
    semilogx(fref(start:end),cumMeas(jj,:)*1e3, 'linewidth', 1.5);
    hold on
end
xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
ylabel('Noise Voltage (uV)','Interpreter','latex','FontSize',20,'FontName',font_name)
set(gca,'FontSize',font_size,'FontName',font_name);
ax = gca; %get current axis
ax.YTick = [0 2.5 5];
set(gca,'YTickLabel',['  0';'2.5';'  5'])
xlim([100 180e3])
ylim([0 5])
grid on
%% Expected TIN
figure(30)


Zinterp0 = Z1';
Zinterp0(isnan(Zinterp0)) = 0;
for kk = 1:L
    cumExpec(kk,:)=cumtrapz(fref(start:end),sqrt(4*kT*Zinterp0(kk,start:end)));
    semilogx(fref(start:end),cumExpec(kk,:)*1e3,'--','linewidth', 1.5);
    hold on
end
xlim([100 180e3])
