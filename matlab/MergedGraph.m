clc;%Need to clear frequencies and PSDs so plotNoise functions correctly
clear x y frequencies final_PSDs
Av=352;
%Load grounded input
load('2016-12-21_17hr_50min_4sec_Av350_gnd_lowF')
PSD_gnd=y(1:end,:)'./Av;

%Load electrode to subtract grounded measurement from
load('2016-12-20_17hr_1min_50sec_Av350_e1101_lowF.mat')
PSD_el=y'./Av;

High_PSDs=sqrt(PSD_el.^2-PSD_gnd.^2);
Hign_frequencies = x(1:end,:)';

Av=342;
%Load grounded input
load('2016-11-29_17hr_41min_20sec_Av350_gnd_lowF_1kavg')
PSD_gnd=y(1:end,:)'./Av;

%Load electrode to subtract grounded measurement from
load('2016-11-29_16hr_49min_7sec_Av350_1k_lowF_1kavg')
PSD_el=y'./Av;


Low_PSDs=sqrt(PSD_el.^2-PSD_gnd.^2);
Low_frequencies = x(1:5,:)';

final_PSDs=[High_PSDs;Low_PSDs];
frequencies = [Hign_frequencies;Low_frequencies];

chop_bins_before = 20;

%chop unwanded part of data by setting them to 0
%chop arch after 1M
for n = 1:401
    final_PSDs(n,1)=0;
    final_PSDs(n,2)=0;
    for m = 1:5
        if n < chop_bins_before
            final_PSDs(n,m)=0;
        end
%        if frequencies(n,m) < 1e4
%            final_PSDs(n,m)=0;
%        end
    end
end

for n = 401:802
    for m = 1:5
        if n < 401+chop_bins_before
            final_PSDs(n,m)=0;
        end
%         if frequencies(n,m) > 1e4
%            final_PSDs(n,m)=0;
%         end
%        if  frequencies(n,m) < 10
%            final_PSDs(n,m)=0;
%        end
    end
    if frequencies(n,4) < 50
        final_PSDs(n,4)=0;
    end
end


figure
set(gca,'FontSize',font_size,'FontName',font_name);
loglog(frequencies(1:end,:), 1e6*final_PSDs(1:end,:), 'LineWidth', 2)
xlabel('Freq (Hz)')
ylabel('PSD uVrms/\surd{(Hz)}')
max_freq = max(max(frequencies));
axis([0 max_freq 0.1 10000])

%Generate the legend
legend_strings=char(sprintf('%.4gHz span',spans(1)));
for k=2:length(spans) legend_strings = char(legend_strings,sprintf('%.4gHz span',spans(k))); end

% OPtional for plotting simulation data
% LTfile='../LTSpice/FullDiff_v1.txt'
% ltdata=load(LTfile)
% hold on;plot(B(:,1),B(:,2)*1e6,'linewidth',2)
% legend_strings = char(legend_strings,sprintf('LT Simulation'));
% legend(legend_strings)

if(addPSDMarkerLines)
	for(zz = 1:length(PSD_lines_uVrms))
        h=line([1 max_freq],[PSD_lines_uVrms(zz) PSD_lines_uVrms(zz)]);
        set(h,'LineWidth',1); set(h,'Color','r'); set(h,'LineStyle','--');
        t=text(textX, PSD_lines_uVrms(zz)+0.1*PSD_lines_uVrms(zz),sprintf('%.1fuVrms/\\surd{(Hz)}',PSD_lines_uVrms(zz)));
        set(t,'FontName',font_name,'FontSize',font_size);
	end
end

%Set the title according to the note from the main script
title(plotTitleNote);
%Maximize the plot
% maximize;

hold on;