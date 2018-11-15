
Av = 297;

load('2017-09-11_15hr_21min_18sec_gnd__highF_Av389_Fang.mat');
gnd=y;

load('2017-09-11_15hr_31min_33sec_res__highF_Av389_Fang.mat');
y1=sqrt((y./Av).^2-(gnd./Av).^2);

plot(x'/1e6,y1'/1e-9)
title('Resistor Noise, 4-6MHz')
xlabel('Frequency (MHz)')
ylabel('nV/rtHz')
ylim([0,15]);

hold on;
R=1200;
plot(x/1e6,sqrt(4*ones(size(x))*1.380e-23*300*R)/1e-9)