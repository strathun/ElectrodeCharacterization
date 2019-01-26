load('C:\Users\Tye\Documents\MATLAB\HighGain_0-10MHz_noMUX.mat')
offset = x(1)/1e6;
freq=(x(2:end))/1e6-offset; mag=y(2:end);
plot(freq,mag);
hold on;
xlim([freq(1) freq(end)]); ylim([min(mag)-5 max(mag)+5]);
title('H(f) No MUX')
xlabel('Frequency (MHz)') 
ylabel('Magnitude (dB)')
set(gca,'fontsize',12)
% legend('With MBED','Without MBED')
% 
bandpass=60.63;
% plot(freq,ones(size(freq))*bandpass)
% plot(freq,ones(size(freq))*bandpass-3,'r')
% plot(freq,ones(size(freq))*59.38,'k')
% plot(freq,ones(size(freq))*59.38-3,'k')