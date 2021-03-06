% Will rename all .dta files to .txt in the selected folder
% If no .dta files exist, warning message: "The system cannot find the file specified."
%Run this after running combineLowHighData.m to merge the two data sets
%onto one graph.
%_hs adapting to plot mean of multiple arrays
% clear all;

kT=300*1.38e-23;
d = uigetdir();

% config
% startLine = 97;
startLine = 75;
%numRows = 60;
numRows = 50; %_hs

currentFolder = pwd;
cd(d)
%change .dat files to ..txt files for processing
system(['rename ' '*.dta ' '*.txt']);

listFiles = dir(d);
fnames = {listFiles.name}'; %returns cell array

data = zeros(numRows, 11, length(fnames)-2);
s = size(data);

% colors = distinguishable_colors(32);
colors = colormap(colorcube);spacer = 3; %hs

for kk = 3:length(fnames)
    % Format data to usable format
    fname = fnames(kk);
    rawTable=readtable(cell2mat(fname),'delimiter','tab','headerlines',startLine);
    makeArray=table2array(rawTable(2:end,2:end));
    disp(kk)
    for ii = 1:s(1)
        for jj = 1:s(2)
%             t = str2num(cell2mat(makeArray(ii,jj)));
            if iscell(makeArray(ii,jj))
                t = str2num(cell2mat(makeArray(ii,jj)));
            elseif isstr(makeArray(ii,jj))
                t = str2num((makeArray(ii,jj)));
            else
                t = (makeArray(ii,jj));
            end
            
            data(ii, jj, kk-2) = t;
    
        end
    end
end
cd(currentFolder)
% Extract data to plot
f = data(:,3,:);
Zreal = data(:,4,:);
Zim = data(:,5,:);
Z = sqrt(Zreal.^2);

%error checking before interpolation
if(~exist('fhold'))
    disp('Error: Must run combineLowHighData.m first')
end

hold on
%%
%prepare interpolation
f1 = f(:,1,1);
fref=fhold';
% figure(77)
for ii = 1:length(fnames)-2
    currentNameStr = (char(fnames(ii+2)));
    elecNum = str2num(currentNameStr(15:16));
%     elecNum = str2num(currentNameStr(11:12))
    Zii =(Z(:,1,ii));
    Zinterp(:,ii) = interp1(f1,Zii,fref);
    figure(1) %hs
    % Noise
    loglog(f(:,1,ii),sqrt(4*kT*Z(:,1,ii))*1e9,'--','color',colors(elecNum*spacer,:),'LineWidth',1)
%     % Impedance
%     loglog(f(:,1,ii),(Z(:,1,ii)),'--','color',colors(elecNum*spacer,:),'LineWidth',1)
%     xlim([12.4 200e3])
%     ylabel(['|Z| ' char(937)],'Fontsize',24,'FontName',font_name)

    xlabel('Frequency (Hz)','Fontsize',24,'FontName',font_name)
    hold on
    [v ind1k] = min(abs(1e3-f(:,1,ii)));
    [v ind100k] = min(abs(100e3-f(:,1,ii)));
    sum1kViv(ii) = Z(ind1k,1,ii);
    sum100kViv(ii)= Z(ind100k,1,ii);
end
xt={'100 Hz' ; '1 kHz' ; '10 kHz' ; '100 kHz'} ;
set(gca,'xtick',[100, 1e3, 10e3, 100e3]);
set(gca,'xticklabel',xt);
xlim([10 150e3])
%% Total Integrated Noise Measured
[L W] = size(frec);
figure(30)
start = 10;
for jj = 1:L
    cumMeas(jj,:) = cumtrapz(frec(jj,start:end),prec(jj,start:end));
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
Zinterp0 = Zinterp';
Zinterp0(isnan(Zinterp0)) = 0;
for kk = 1:length(fnames)-2
    cumExpec(kk,:)=cumtrapz(fref(start:end),sqrt(4*kT*Zinterp0(kk,start:end)));
    semilogx(fref(start:end),cumExpec(kk,:)*1e3,'--','linewidth', 1.5);
    hold on
end
xlim([100 180e3])

%stats stuff
meanTIN = (cumMeas.')*(1e3);
meanTINExpec = (cumExpec.')*(1e3);
stdTIN = std(meanTIN,0,2);
meanTIN = mean(meanTIN,2);

%% Percent Error Measured vs Expected 
figure(21)

%stats stuff
meanPError = abs((cumMeas-cumExpec)./cumExpec)'*100;
stdPError = std(meanPError,0,2);
meanPError = mean(meanPError,2);

semilogx(frec(:,start:end)',abs((cumMeas(:,:)-cumExpec)./cumExpec)'*100,'--')
xlim([100 300e3])
ylim([1 500])
hold on;
% %% Total Integrated Noise Measured
% [L W] = size(frec);
% figure(30)
% for jj = 1:L   
%     cumMeas(jj,:) = cumtrapz(frec(jj,:),prec(jj,:));
%     semilogx(fref,cumMeas(jj,:)*1e3, 'linewidth', 1.5);
%     hold on
% end
% xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
% ylabel('Noise Voltage (uV)','Interpreter','latex','FontSize',20,'FontName',font_name)
% set(gca,'FontSize',font_size,'FontName',font_name);
% ax = gca; %get current axis
% ax.YTick = [0 2.5 5];
% set(gca,'YTickLabel',['  0';'2.5';'  5'])
% xlim([100 180e3])
% ylim([0 5])
% grid on
% 
% %% Expected TIN
% % figure
% Zinterp0 = Zinterp';
% Zinterp0(isnan(Zinterp0)) = 0;
% for kk = 1:length(fnames)-2
%     cumExpec(kk,:)=cumtrapz(fref,sqrt(4*kT*Zinterp0(kk,:)));
%     semilogx(fref,cumExpec(kk,:)*1e3,'--','linewidth', 1.5);
%     hold on
% end
% xlim([100 180e3])
% meanTIN = (cumExpec.')*(1e3);
% stdTIN = std(meanTIN,0,2);
% meanTIN = mean(meanTIN,2);
% %% Percent Error Measured vs Expected 
% figure(31)
% meanPError = abs((cumMeas-cumExpec)./cumExpec)'*100;
% stdPError = std(meanPError,0,2);
% meanPError = mean(meanPError,2);
% frec = frec(10:end) %hs
% 
% semilogx(frec',abs((cumMeas-cumExpec)./cumExpec)'*100,'--')
% xlim([100 300e3])
% ylim([1 500])
% hold on
%% Make error plot
figure(31)

%stats stuff
meanError = abs((prec'-sqrt(4*kT*Zinterp)))./abs(sqrt(4*kT*Zinterp))*100;
stdError = std(meanError,0,2);
meanError = mean(meanError,2); %hs

figure(300)
semilogx(fref,abs((prec'-sqrt(4*kT*Zinterp)))./abs(sqrt(4*kT*Zinterp))*100)
xlim([100 500e3])
ylim([0 500])
xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
ylabel('% Error','Interpreter','latex','FontSize',17,'FontName',font_name)
set(gca,'FontSize',font_size,'FontName',font_name);
hold off
% 
% set(gca,'xtick',[100; 1e3; 10e3; 100e3]); 
% set(gca,'xticklabel',[' 100  '; ' 1kHz '; '10kHz '; '100kHz']);