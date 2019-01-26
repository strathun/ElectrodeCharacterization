%Run this as many times as you want to plot different arrays

clear all;
%Colors
%TDT
%[0,.2,1]
%[0,.8,1]
%[0.4,.2,.6]
%UEA
%[.6,0,0]
%[1,0,0]

invi = 0;    %set to 0 to plot in vitro, 1 for in vivo
arrayType = 0; % 0 = TDT; 1 = UEA
colorTrace = [1,0,0];
colorShadow = brighten(colorTrace,.8);

headStage = 1; %for TDT5_Surgery set to 0; all else =1
positionTool = 1; %set to 1 on final run to position everything

if headStage == 1
    run combineLowHighDataMultiPlot.m
    run ExtractImpedanceData2MultiPlot_jermrev.m
else
    run combineLowHighDataMultiPlot_LS2.m
    run ExtractImpedanceData2MultiPlot_jermrev.m
end

%% Std calculations
freqV = 99;     %Use for 1k Hz analysis
freqV2 = 1058;   %Use for 100k Hz analysis

stdArray = 0;

stdArray(1,1) = stdError(freqV);
stdArray(2,1) = stdPError(freqV);
stdArray(3,1) = stdTIN(freqV);
stdArray(4,1) = meanError(freqV);
stdArray(5,1) = meanPError(freqV);
stdArray(6,1) = meanTIN(freqV);

stdArray(1,2) = stdError(freqV2);
stdArray(2,2) = stdPError(freqV2);
stdArray(3,2) = stdTIN(freqV2);
stdArray(4,2) = meanError(freqV2);
stdArray(5,2) = meanPError(freqV2);
stdArray(6,2) = meanTIN(freqV2);

stdTINh = meanTIN + stdTIN;
stdTINl = meanTIN - stdTIN;

stdPETINh = meanPError + stdPError;
stdPETINl = meanPError - stdPError;


%% Percent Error from TIN predictions
figure(110)

semilogx(fref(10:end),meanPError,'--','Color',colorTrace,'linewidth', 1.5);
hold on

% %shadow plot
% figure(110)
% frefFill = fref(10:end);
% X1=[frefFill,fliplr(frefFill)];      %#create continuous x value array for plotting
% Y1=[stdPETINl.',fliplr(stdPETINh.')];              %#create y values for out and then back
% fill(X1,Y1,colorShadow,'LineStyle','none','FaceAlpha',.3);  %use .3 FaceAlpha for color shadow

%plots actual data
%real plot (plots a 2nd time to get on top of shadow)
if invi == 0
    semilogx(fref(10:end),meanPError,'--','Color',colorTrace,'linewidth', 1.5);
else
    semilogx(fref(10:end),meanPError,'Color',colorTrace,'linewidth', 1.5);
end

xlabel('Frequency (Hz)','Fontsize',24,'FontName',font_name)
ylabel('% Error','Fontsize',24,'FontName',font_name)
set(gca,'FontSize',font_size,'FontName',font_name);
ax = gca;
xt={'100 Hz' ; '1 kHz' ; '10 kHz' ; '100 kHz'} ;
set(gca,'xtick',[100, 1e3, 10e3, 100e3]);
set(gca,'xticklabel',xt);
xlim([100 150e3])

%% Mean TIN

figure(111)
if arrayType == 0
    subplot(1,2,1)
else
    subplot(1,2,2)
end

semilogx(fref(10:end),meanTIN,'--','linewidth', 1.5)
hold on

%shadow plot
frefFill = fref(10:end);
X=[frefFill,fliplr(frefFill)];      %#create continuous x value array for plotting
Y=[stdTINl.',fliplr(stdTINh.')];              %#create y values for out and then back
fill(X,Y,colorShadow,'LineStyle','none','FaceAlpha',.3);  %use .3 FaceAlpha for color shadow

%real plot (plots a 2nd time to get on top of shadow)
if invi == 0
    semilogx(fref(10:end),meanTIN,'--','Color',colorTrace,'linewidth', 1.5)
else
    semilogx(fref(10:end),meanTIN,'Color',colorTrace,'linewidth', 1.5)
end

%hold on

if arrayType == 0
    xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
    ylabel('Noise Voltage (uV)','Interpreter','latex','FontSize',20,'FontName',font_name)
    set(gca,'FontSize',font_size,'FontName',font_name);
    ax = gca; %get current axis
    ax.YTick = [0 2.5 5];
    set(gca,'YTickLabel',['  0';'2.5';'  5'])
    xlim([100 180e3])
    ylim([0 5])
    set(gca,'XScale','linear')
else
    xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
    set(gca,'FontSize',font_size,'FontName',font_name);
    ax = gca; %get current axis
    ax.YTick = [0 2.5 5];
    set(gca,'YTickLabel',[])
    xlim([100 180e3])
    ylim([0 5])
    set(gca,'XScale','linear')
end

if positionTool == 1
    subplot(1,2,1)
    pos = get(gca, 'Position');
    pos(1) = 0.135;
    set(gca, 'Position', pos)
    
    subplot(1,2,2)
    pos = get(gca, 'Position');
    pos(1) = 0.49;
    set(gca, 'Position', pos)
end

%%  Real Impedance plots/avg

figure(222)
hold on
impArray = 0;
[zHeight, nnn, numElectrodes] = size(Zreal);
numbPoints = zHeight;

%pulls out impedance data from ExtractImpedanceData2
% for ii = 1:numElectrodes
%     for iii = 1:numbPoints
%         impArray(ii,iii) = Zreal(iii,1,ii);
%         ZrealInt(ii,iii) = interp1(f1,Zreal,fref);
%     end
% end

meanZreal = mean(Zinterp0);
stdZreal = std(Zinterp0,0,1);
stdZreall = meanZreal - stdZreal;
stdZrealh = meanZreal + stdZreal;

%shadow plot %avoiding for now because loglog scale messes up shadow
% X=[f1,fliplr(f1)];      %#create continuous x value array for plotting
% Y=[stdZreall.',fliplr(stdZrealh.')];              %#create y values for out and then back
% fill(X,Y,colorShadow,'LineStyle','none','FaceAlpha',.3);  %use .3 FaceAlpha for color shadow

figure(222)
if arrayType == 0
    subplot(2,1,1)
else
    subplot(2,1,2)
end

%plots impedance after shadow
if invi == 0
    plot(fref,meanZreal,'--','Color',colorTrace,'linewidth', 1);
    set(gca, 'XScale', 'log', 'YScale','log');   %this plays nice with fill()
else
    plot(fref,meanZreal,'Color',colorTrace,'linewidth', 1);
    set(gca, 'XScale', 'log', 'YScale','log');
end

xlim([20 200e3])
ylabel(['|Z| ' char(937)],'Fontsize',24,'FontName',font_name)

xlabel('Frequency (Hz)','Fontsize',24,'FontName',font_name)
