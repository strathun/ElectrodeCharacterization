% clc;
clear all;

%Sets relative filepaths
currentFile = mfilename( 'fullpath' );
cd(fileparts(currentFile));
cd('..\RawData');
addpath(genpath('../pydevicecontrol'));
addpath(genpath('../Matlab'));

kT=300*1.38e-23;
% folder_name_note = 'UEA_7603-16 _Surgery2';    %folder will be date stamped + note
% fnote = 'Surgery2';                     %Note to append to filename
folder_name_note = 'TDT12_Day80_Newboard_MohHS';    %folder will be date stamped + note
fnote = 'HS';
datestamp=datestr(date,29);

channel = '0000'; %Binary used for mux channel select as string

scaleDown = 2; % factor to reduce number of averages by
                % use 1 in vitro and 2 in vivo

f_range = 0; %Select 0 for low frequency headstage, 1 for high frequency HS

senseRange=-48; %HS2: GND -64, 
                %HS3: GND -63
                %HSlow: GND -67
                %UEA_LS_vitro = -65
                %UEA_LS_vivo = -59
                %TDT_LS_inVitro: -69
                %TDT_HS_inVitro: -61
                %TDT_LS_inVivo: -63
                %TDT_HS_inVivo: -63
                
gnd_measurement = 0; %Select 0 for regular, 1 to take gnd measurement

%lowF_Av_new = 226; %for 2nd LS headstage
lowF_Av = 346 ;  % Gain of lowF headstage
highF_Av = 369; % Gain of highF headstage  (was 389)        
% lowF_Av = ;
% highF_Av = ;

pause(1)
%% Execute
dirname = [datestamp '_' folder_name_note];

if(~exist(dirname))
    mkdir(dirname);
    copyfile("gndv1/*.mat", dirname)    %Copies gnd measurements to new folder
else
    disp('Folder Already Exists')
end

if gnd_measurement
    n = 3;
    m_type = 'gnd';
    num_electrodes = 1;
    channel = '';
else
    n = 1;
    m_type = 'elec';
end

n=n/scaleDown;

if (f_range == 0) %Note: Added extra span to end, takes longer
    % Low Freq 2 9 min/channel (15 Hz min)
    % with 20 screen update 9.3 min, good data till 70 Hz ish
    
% slow
%     spans =    [200 2^10 2^12 2^13 2^14]; 
%     centers =  [100 2^9  2^11 2^12 2^13];
%     averages = n*[300 500 500 500 1000];

% Medium
%                 1k    4k   8k   16k
%     spans =    [2^10 2^12 2^13 2^14]; 
%     centers =  [2^9  2^11 2^12 2^13];
%     averages = n*[ 500 500 500 1000];

% Reg 5 min 20Hz
%                     8k   16k   65k
%     spans =    [2^10 2^12 2^14]; 
%     centers =  [2^9 2^11 2^13];
%     averages = n*[500 500 500];

% Fast  2.5 min 100Hz
%                     8k   16k   65k
    spans =    [2^12 2^13 2^14]; 
    centers =  [2^11 2^12 2^13];
    averages = n*[500 500 500 ];     

% Very Fast  1.8 min 100Hz
%                4k   16k  
%     spans =    [2^12 2^14]; 
%     centers =  [2^11 2^13];
%     averages = n*[500 500]; 
    
    Av = lowF_Av;
    rangeType = 'lowF'
elseif f_range == 1
    % High freq 
    
%     reg 2.3 min 5k - 2M
%     spans =    [2^16 2^17 2^19 2^21];   
%     centers =  [2^15 2^16 2^18 2^20];    
%     averages = n*[700 800 1000 1000];  
    
%     Fast 1.9 min 10k - 2M
    spans =    [2^17 2^19 2^21];   
    centers =  [2^16 2^18 2^20];    
    averages = n*[800 1000 1];  
    
%     Long
%     spans =    [2^16 2^17 2^19 2^21 2^23];   
%     centers =  [2^15 2^16 2^18 2^20 2^22];    
%     averages = n*[1000 1000 1000 1000 1000];

%     Short
%     spans =    [2^16 2^17 2^19];   
%     centers =  [2^15 2^16 2^18];    
%     averages = n*[1000 1000 1000];  
    
    Av = highF_Av;
    rangeType = 'highF'
end

errorClose = 0;
if length(spans)~= length(centers)
    sprintf('Error: Non-matching parameter sizes. (Spans, Centers)')
    errorClose = 1;
end
if length(spans)~= length(averages)
    sprintf('Error: Non-matching parameter sizes. (Spans, Averages)')
    errorClose = 1;
end
if length(centers)~= length(averages)
    sprintf('Error: Non-matching parameter sizes. (Centers, Averages)')
    errorClose = 1;
end

if errorClose
    return
end

Av=num2str(Av);

saveFile = [m_type '_' channel '_' rangeType '_Av' Av '_'  fnote];

tic
% run ranges
[f, PSD]= getSpans(saveFile,spans, centers, averages,senseRange, 10, dirname);
% HP89410A_Noise_PSD_Measurement

T=toc/60
beep