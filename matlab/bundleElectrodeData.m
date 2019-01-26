clc;clear all;
addpath('C:\Users\Tye\Documents\MATLAB\pydevicecontrol\Noise_Test_Data');

elecList = {'2016-06-09_16hr_10min_30sec_e1_array2_noise';
    '2016-06-09_16hr_19min_5sec_e2_array2_noise';
    '2016-06-09_16hr_22min_59sec_e3_array2_noise';
    '2016-06-09_16hr_26min_50sec_e4_array2_noise';
    '2016-06-09_16hr_31min_10sec_e5_array2_noise';
    '2016-06-09_16hr_35min_12sec_e6_array2_noise';
    '2016-06-09_16hr_39min_8sec_e7_array2_noise';
    '2016-06-09_16hr_43min_1sec_e8_array2_noise';
    '2016-06-09_15hr_41min_1sec_e9_array2_noise'; 
    '2016-06-09_15hr_45min_7sec_e10_array2_noise';
    '2016-06-09_15hr_49min_47sec_e11_array2_noise';
    '2016-06-09_15hr_54min_11sec_e12_array2_noise';
    '2016-06-09_16hr_0min_35sec_e15_array2_noise';
    '2016-06-09_16hr_5min_55sec_e16_array2_noise'};

Hf_data=('H(f)_HighGain_0-10MHz_noMUX');

gndNoise=('2016-06-11_15hr_52min_27sec_gnd_array2_1kavg_noise');

inputRef=zeros(length(elecList),2169);

for ii = 1:length(elecList)
   [f ,V] = deembedNoise(gndNoise,char(elecList(ii)),Hf_data);
   inputRef(ii,:) = V;
end

loglog(f,inputRef)
