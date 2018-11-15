%Saves data from network analyzer display
clc;
fname = 'MohMUX_TF1M_23.7k.mat';
addpath('C:\Users\Tye\Documents\MATLAB\pydevicecontrol\DeviceLibs\MatlabLib')
HP89441A = struct;
HP89441A.saveToFile=1;
HP89441A.address=10;
HP89441A.pythonDeviceDir='C:\Users\Tye\Documents\MATLAB\pydevicecontrol\DeviceLibs\PythonLib';

HP89441A.matlabFile=['C:\Users\Tye\Documents\MATLAB\' fname];

data=runPyDevice('sig_analyzer_get_all_data', HP89441A, 1);
%%
load(fname)
plot(x'-x(1),y')
title('H(f) Mohit MUX (15MHz)')
xlabel('Frequency (MHz)') 
ylabel('Magnitude (dB)')
set(gca,'fontsize',12)

ylim([10 50])
