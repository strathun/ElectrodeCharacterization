%Saves data from network analyzer display
clc;
fname = 'testtest';    % Just the name you want to call it
currentFile = mfilename( 'fullpath' );
cd(fileparts(currentFile));
addpath(genpath('../pydevicecontrol'));
addpath(genpath('../matlab'));

HP89441A = struct;
HP89441A.saveToFile=1;
HP89441A.address=10;
HP89441A.pythonDeviceDir= '"C:/Users/hstra/Google Drive/WalkerLab/ElectrodeCharacterization/pydevicecontrol/pydevicecontrol/DeviceLibs/PythonLib"';
currentFolder = [pwd '\..\rawData'];
cd(currentFolder)

HP89441A.matlabFile=['"' currentFolder '/' fname '"'];

data=runPyDevice('sig_analyzer_get_all_data', HP89441A, 1);
%%

load([currentFolder '/' fname])
x = x-x(1); %for whatever reason, adds some value to each frequency value. This corrects the problem.
save([currentFolder '/' fname],'x','y')

plot(x',y')
title('H(f) Mohit MUX (15MHz)')
xlabel('Frequency (MHz)') 
ylabel('Magnitude (dB)')
set(gca,'fontsize',12)

ylim([min(y)-5 max(y) + 5])