%This script was made for the 2018 IEEE_lifesciences paper.
%combineLowHighData.m was modified to create a matrix with the noise data
%from each channel. This script then removes any unwanted channels
%(specified by "delchannel" below, and takes the average of that days array
%channels and then plots them on the same styleof graph. 

%channel to delete
delchannel = [8, 14, 15, 16];

for i = 1:length(delchannel)
    noiseArray( delchannel(i), : ) = NaN;
end

noiseAvg = nanmean(noiseArray);
colors = colormap(colorcube);spacer =3;
font_size = 16; font_name = 'Arial';

%%
figure(100)
        loglog(f,(noiseAvg.')*1e9,'color',colors(ii*(spacer),:))
        
       
        xlim([100 500e3]); ylim([1 100]);
%         title(([sprintf('Noise for Electrode #%02d',ii)]))
        xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
        ylabel('Noise Voltage (nV/$$\sqrt{Hz}$$)','Interpreter','latex','FontSize',20,'FontName',font_name)
        set(gca,'FontSize',font_size,'FontName',font_name);
        ax = gca; %get current axis
        ax.YTick = [10 20 40 80];
        set(gca,'YTickLabel',[' 10';' 20';' 40';' 80'])
        
        hold on
%%        
%channels and then plots them on the same styleof graph. 

%channel to delete
delchannel = [8, 14, 15, 16];

for i = 1:length(delchannel)
    impArray( delchannel(i), : ) = NaN;
end

impAvg = nanmean(impArray);
colors = colormap(colorcube);spacer =3;
font_size = 16; font_name = 'Arial';

%%
figure(1)
hold on

        loglog(f(:,1,ii),impAvg,'color',colors(elecNum*spacer,:),'LineWidth',1)
        
        xlim([100 500e3]); ylim([1 100]);
        xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
        ylabel('Noise Voltage (nV/$$\sqrt{Hz}$$)','Interpreter','latex','FontSize',20,'FontName',font_name)
        set(gca,'FontSize',font_size,'FontName',font_name);
        ax = gca; %get current axis
        ax.YTick = [10 20 40 80];
        set(gca,'YTickLabel',[' 10';' 20';' 40';' 80'])
        
        hold on