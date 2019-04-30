%MUXd Headstage compiled plot
clear all;

datestamp = datestr(date, 29);

versionNum = 4; %board version number for gain selection. Currently must be 4.
varplot = 0 ; %set 0 for individual figures; 1 for a single figure.(not up yet)
stageSpeed = 1; % 0 if high and low speed headstages used, 1 if only high speed used
rangeType = 'HSonly'; % fast or HSonly (HSonly is actually just single spectrum, while fast is the old way of doing it 1/30/2019)
                        % Use 'fast_old' if trying to run any data before
                        % 2019

d = uigetdir(); 
listFiles = dir(d);
addpath(d);
fnames = {listFiles.name}'; %returns cell array


for ii=1:length(fnames) 
    file = fnames{ii}; %convert cell to string
    
    %Low Frequency Sorting
    if ~isempty(findstr(file,'gnd')) && ~isempty(findstr(file,'lowF'))
        gnd_Low = file;
    end
    if ~isempty(findstr(file,'0000')) && ~isempty(findstr(file,'lowF'))
        e01_Low = file;
    end
    if ~isempty(findstr(file,'0001')) && ~isempty(findstr(file,'lowF'))
        e02_Low = file;
    end
    if ~isempty(findstr(file,'0010')) && ~isempty(findstr(file,'lowF')) 
        e03_Low = file;
    end
    if ~isempty(findstr(file,'0011')) && ~isempty(findstr(file,'lowF'))
        e04_Low = file;
    end
    if ~isempty(findstr(file,'0100')) && ~isempty(findstr(file,'lowF'))
        e05_Low = file;
    end
    if ~isempty(findstr(file,'0101')) && ~isempty(findstr(file,'lowF'))
        e06_Low = file;
    end
    if ~isempty(findstr(file,'0110')) && ~isempty(findstr(file,'lowF'))
        e07_Low = file;
    end
    if ~isempty(findstr(file,'0111')) && ~isempty(findstr(file,'lowF'))
        e08_Low = file;
    end
    if ~isempty(findstr(file,'1000')) && ~isempty(findstr(file,'lowF'))
        e09_Low = file;
    end
    if ~isempty(findstr(file,'1001')) && ~isempty(findstr(file,'lowF'))
        e10_Low = file;
    end
    if ~isempty(findstr(file,'1010')) && ~isempty(findstr(file,'lowF'))
        e11_Low = file;
    end
    if ~isempty(findstr(file,'1011')) && ~isempty(findstr(file,'lowF'))
        e12_Low = file;
    end
    if ~isempty(findstr(file,'1100')) && ~isempty(findstr(file,'lowF'))
        e13_Low = file;
    end
    if ~isempty(findstr(file,'1101')) && ~isempty(findstr(file,'lowF'))
        e14_Low = file;
    end
    if ~isempty(findstr(file,'1110')) && ~isempty(findstr(file,'lowF'))
        e15_Low = file;
    end
    if ~isempty(findstr(file,'1111')) && ~isempty(findstr(file,'lowF'))
        e16_Low = file;
    end
    if ~isempty(findstr(file,'gnd__')) && ~isempty(findstr(file,'lowF'))
        gnd_Low = file;
    end
    
    %%High Frequency Sorting
    if ~isempty(findstr(file,'0000')) && ~isempty(findstr(file,'highF'))
        e01_High = file;
    end
    if ~isempty(findstr(file,'0001')) && ~isempty(findstr(file,'highF'))
        e02_High = file;
    end
    if ~isempty(findstr(file,'0010')) && ~isempty(findstr(file,'highF')) 
        e03_High = file;
    end
    if ~isempty(findstr(file,'0011')) && ~isempty(findstr(file,'highF'))
        e04_High = file;
    end
    if ~isempty(findstr(file,'0100')) && ~isempty(findstr(file,'highF'))
        e05_High = file;
    end
    if ~isempty(findstr(file,'0101')) && ~isempty(findstr(file,'highF'))
        e06_High = file;
    end
    if ~isempty(findstr(file,'0110')) && ~isempty(findstr(file,'highF'))
        e07_High = file;
    end
    if ~isempty(findstr(file,'0111')) && ~isempty(findstr(file,'highF'))
        e08_High = file;
    end
    if ~isempty(findstr(file,'1000')) && ~isempty(findstr(file,'highF'))
        e09_High = file;
    end
    if ~isempty(findstr(file,'1001')) && ~isempty(findstr(file,'highF'))
        e10_High = file;
    end
    if ~isempty(findstr(file,'1010')) && ~isempty(findstr(file,'highF'))
        e11_High = file;
    end
    if ~isempty(findstr(file,'1011')) && ~isempty(findstr(file,'highF'))
        e12_High = file;
    end
    if ~isempty(findstr(file,'1100')) && ~isempty(findstr(file,'highF'))
        e13_High = file;
    end
    if ~isempty(findstr(file,'1101')) && ~isempty(findstr(file,'highF'))
        e14_High = file;
    end
    if ~isempty(findstr(file,'1110')) && ~isempty(findstr(file,'highF'))
        e15_High = file;
    end
    if ~isempty(findstr(file,'1111')) && ~isempty(findstr(file,'highF'))
        e16_High = file;
    end
    if ~isempty(findstr(file,'gnd__')) && ~isempty(findstr(file,'highF'))
        gnd_High = file;
    end
    
%%High Speed only Frequency Sorting
    if ~isempty(findstr(file,'0000')) && ~isempty(findstr(file,'HSonly'))
        e01_High = file;
    end
    if ~isempty(findstr(file,'0001')) && ~isempty(findstr(file,'HSonly'))
        e02_High = file;
    end
    if ~isempty(findstr(file,'0010')) && ~isempty(findstr(file,'HSonly')) 
        e03_High = file;
    end
    if ~isempty(findstr(file,'0011')) && ~isempty(findstr(file,'HSonly'))
        e04_High = file;
    end
    if ~isempty(findstr(file,'0100')) && ~isempty(findstr(file,'HSonly'))
        e05_High = file;
    end
    if ~isempty(findstr(file,'0101')) && ~isempty(findstr(file,'HSonly'))
        e06_High = file;
    end
    if ~isempty(findstr(file,'0110')) && ~isempty(findstr(file,'HSonly'))
        e07_High = file;
    end
    if ~isempty(findstr(file,'0111')) && ~isempty(findstr(file,'HSonly'))
        e08_High = file;
    end
    if ~isempty(findstr(file,'1000')) && ~isempty(findstr(file,'HSonly'))
        e09_High = file;
    end
    if ~isempty(findstr(file,'1001')) && ~isempty(findstr(file,'HSonly'))
        e10_High = file;
    end
    if ~isempty(findstr(file,'1010')) && ~isempty(findstr(file,'HSonly'))
        e11_High = file;
    end
    if ~isempty(findstr(file,'1011')) && ~isempty(findstr(file,'HSonly'))
        e12_High = file;
    end
    if ~isempty(findstr(file,'1100')) && ~isempty(findstr(file,'HSonly'))
        e13_High = file;
    end
    if ~isempty(findstr(file,'1101')) && ~isempty(findstr(file,'HSonly'))
        e14_High = file;
    end
    if ~isempty(findstr(file,'1110')) && ~isempty(findstr(file,'HSonly'))
        e15_High = file;
    end
    if ~isempty(findstr(file,'1111')) && ~isempty(findstr(file,'HSonly'))
        e16_High = file;
    end
    if ~isempty(findstr(file,'gnd__')) && ~isempty(findstr(file,'HSonly'))
        gnd_High = file;
    end
end

%%
if versionNum == 1
    AvL = 346;
    AvH = 389;
elseif versionNum ==4 && stageSpeed == 0
    load('../rawData/highSpeedGain_v4.mat')
    AvH = 'highSpeedGain_v4.mat';
    load('../rawData/lowSpeedGain_v4.mat')
    AvL = 'lowSpeedGain_v4.mat';
elseif versionNum ==4 && stageSpeed == 1
    if strcmp(rangeType,'fast')
        load('../rawData/highSpeedGain_v4.mat')
        AvH = 'highSpeedGain_v4.mat';
        load('../rawData/highSpeedLFGain_v4.mat')
        AvL = 'highSpeedLFGain_v4.mat';
    else
        load('../rawData/highSpeedFullSpectrumGain_v4.mat')
        AvH = 'highSpeedFullSpectrumGain_v4.mat';
    end
end

% v4 (gen 2) gain
% AvL  =  837;  % Gain for v4 headstages (Reworked/measured 1/23/19)
% AvH =  767;
% AvL  =  767;  % Gain for v4 headstages (Reworked/measured 1/23/19)
% AvH =  767;

%  frec = zeros([16,1752]);
%  prec = zeros([16,1752]);
 %Plot Config
% colors = distinguishable_colors(32);
colors = colormap(colorcube);spacer =1;
numTraces = 0;
font_size = 16; font_name = 'Arial';
% figure()
for ii = 1:16
    try
        fHigh = eval(['e' sprintf('%02d',ii) '_High']);
        if strcmp(rangeType, 'HSonly')
            fLow = 'x';
            gnd_Low = 'x';
            AvL = 0;
        else
            fLow = eval(['e' sprintf('%02d',ii) '_Low']);
        end
        
        [f p] = CombineHighLow(gnd_High, fHigh, gnd_Low, fLow, AvH, AvL,rangeType,rangeType);
        fhold = f;
        
        %corner frequency calculation _ hs
        if ~strcmp(rangeType,'HSonly')
            p1 = fliplr(p(1:1408).').';
            f1 = fliplr(f(1:1408).').';
            cornerArray(ii) = cornerCalc( p1, f1, 3e3, 30, 5 );   %hs

            %builds array for mean calculations _ hs
            noiseArray( ii, : ) = p.' ; 
        end
        % Make and label the figure
%         if ii==14
%            p=[p(1:802);p(803:end)/1.5]; 
%         end
        
        figure(ii)
        
%         semilogx(f,p)
        loglog(f,p*1e9,'color',colors(ii*spacer,:))
       
        xlim([100 500e3]); ylim([1 100]);
%         title(([sprintf('Noise for Electrode #%02d',ii)]))
        xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
        ylabel('Noise Voltage (nV/$$\sqrt{Hz}$$)','Interpreter','latex','FontSize',20,'FontName',font_name)
        set(gca,'FontSize',font_size,'FontName',font_name);
        ax = gca; %get current axis
        ax.YTick = [10 20 40 80];
        set(gca,'YTickLabel',[' 10';' 20';' 40';' 80'])
        
        %save a record
        numTraces = numTraces + 1;
        frec(numTraces,:) = f;
        prec(numTraces,:) = p;
        hold on;
                
    catch
        sprintf('fail %02d',ii)
    end
end



