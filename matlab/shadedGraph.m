% x=0:0.01:2*pi;                  %#initialize x array
% y1=sin(x);                      %#create first curve
% y2=sin(x)+.5;                   %#create second curve
colorzz = [0,.2,1];
colorz = brighten(colorzz,.8);
figure(120)
semilogx(fref(10:end),meanTIN,'Color',colorzz,'linewidth', 1.5)
hold on

X=[frefFill,fliplr(frefFill)];      %#create continuous x value array for plotting
Y=[stdTINl.',fliplr(stdTINh.')];              %#create y values for out and then back
fill(X,Y,colorz,'LineStyle','none','FaceAlpha',.5);                  %#plot filled area

semilogx(fref(10:end),meanTIN,'Color',colorzz,'linewidth', 1.5)

xlabel('Frequency (Hz)','Fontsize',font_size,'FontName',font_name)
ylabel('Noise Voltage (uV)','Interpreter','latex','FontSize',20,'FontName',font_name)
set(gca,'FontSize',font_size,'FontName',font_name);
ax = gca; %get current axis
ax.YTick = [0 2.5 5];
set(gca,'YTickLabel',['  0';'2.5';'  5'])
xlim([100 180e3])
ylim([0 5])