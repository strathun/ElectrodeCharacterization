%MUXd Headstage compiled plot
%clear all;

datestamp = datestr(date, 29);

%d = uigetdir(); 
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
end

%%
%AvL = 346;
AvL = 226
AvH = 389;
%  frec = zeros([16,1752]);
%  prec = zeros([16,1752]);
 %Plot Config
% colors = distinguishable_colors(32);
colors = colormap(colorcube);spacer =3;
numTraces = 0;
font_size = 16; font_name = 'Arial';

figure

for ii = 1:16
    if ii == 2 || ii == 12 || ii == 14;  %_hs
        ii = ii + 1;
        continue
    end
    try
        fHigh = eval(['e' sprintf('%02d',ii) '_High']);
        fLow = eval(['e' sprintf('%02d',ii) '_Low']);
        
        [f p] = CombineHighLow_LS2(gnd_High, fHigh, gnd_Low, fLow, AvH, AvL,'fast','fast');
        fhold = f;
        % Make and label the figure
        if ii==14
           p=[p(1:802);p(803:end)/1.5]; 
        end
        
       % figure(ii)
        
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
        ii %test_hs        
    catch
        sprintf('fail %02d',ii)
    end
end



