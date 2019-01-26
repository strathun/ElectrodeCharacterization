function [ f_ret, PSD_ret ] = getSpans( saveFileNote, spans, centers, averages,sR, GPIBaddress, saveDirectory )
    % close all;
    %--------------------------------------------------------------------------
    % Run from MATLAB directory in Documents assuming pydevicecotrol is in
    % the directory as well as containing a folder called Noise_Test_Data
    %This script controls the HP89410A spectrum analyzer and (optionally) a DC
    %source to perform noise PSD measurements.
    %Calls the 'sig_analyzer_noise_sweep' Python script to run measurements.
    %Ross M. Walker 10/16/2012
    %--------------------------------------------------------------------------
    addpath('../../DeviceLibs/MatlabLib'); %Add the path for instrument control .m files
    font_size=16; font_name='Arial'; %Plotting parameters
    chop_bins=10; %chop off the first few PSD bins
    save_all = 1;  %Flag (0/1) to save the run data at each DC voltage iteration to a .mat file

    %Note for the title of the workspace file saved at the end of the sweep
    % saveFileNote = 'setup';
%     saveFileNote = 'test';
    % saveFileNote = 'LNA_box_LT1128_min_range';
    % saveFileNote = 'Model_LT1128_LNA_Box_TIA_OUT_LT1793_50kOhm_1uF';

    %Set the spans, centers, and averaging to use with the HP89410A
    % spans =    [50  100 500 1e3 10e3 100e3 200e3 1e6];
    % centers =  [25  50  250 500 5e3  50e3  100e3 500e3];
    % Taverages = [128 128 512 512 1024 1024  1024  1024];
    % 
%     spans =    [100 1e3 10e3 100e3 500e3 1e6 5e6];
%     centers =  [50  500 5e3  50e3  200e3 500e3 5e6];
%     averages = [32 32 64 64  64  64 64];

    %Choose to scale down the vector of averages by this multiplicative amount
    scaleDownAveragesBy = 1;  %27mins for '1' here

    %Set the range in dBm of the HP89410A, or let it autorange (senseRange = 0) once before collecting spans
    senseRange = sR;  %this is the smallest range
    % senseRange = -67.01;  %For the RE_BUFF node
    % senseRange = -33.01;  %For the TIA_OUT, with LTC1052
    % senseRange = -27.01;  %For the TIA_OUT, with LTC1150

    %Choose to issue commands to a DC source (1) or not (0)
    useDCsupply = 0;
    voltagesToSweep = [0];  %Vector of DC supply voltages to sweep over.  NOT USED unless 'useDCsupply = 1'
    DCgain = 10^(-31.8879/20);  %Set the gain (if any) through the DC path for formatting the plot titles
    waitSecsForDCchange = 2;  %Number of seconds to wait after changing the DC supply before starting the noise measurement

    %------------------------Lower level device setup--------------------------
    %DC supply device setup paramters, NOT USED unless useDCsupply=1
    DCsupply = struct;
    DCsupply.address=5; %GPIB address
    DCsupply.currentLimit=0.05;
    DCsupply.saveToFile=1;
    DCsupply.voltagesToSweep = voltagesToSweep;

    %HP89410A device setup parameters
    HP89410A = struct;
    HP89410A.saveToFile=1;
    HP89410A.address=GPIBaddress; %GPIB address
    HP89410A.spans = spans;
    HP89410A.centers = centers;
    HP89410A.averages = averages;
    HP89410A.scaleDownAveragesBy = scaleDownAveragesBy;
    HP89410A.senseRange = senseRange;
    %--------------------------------------------------------------------------

    %--------------------------Main Measurement Loop---------------------------
    for i=1:length(DCsupply.voltagesToSweep)

        %Command the DC supply if it is in use
        if(useDCsupply)
            tic
            disp(sprintf('Setting DC supply to %.2fV and waiting %.1fsecs...',voltagesToSweep(i),waitSecsForDCchange))
            %Set the DC supply, can have negative voltages when using
            %'DC_Supply_Set_Bipolar' AND the right wiring setup with the E3646A
            DC_Supply_Set_Bipolar(DCsupply, DCsupply.voltagesToSweep(i), DCsupply.currentLimit);
            pause(waitSecsForDCchange); %Pause to wait for settling
            disp('Done changing the DC supply:')
            toc
        end

        %Run the specified measurements on the HP89410A and get the data
        tic
        disp(sprintf('Running HP89410A PSD measurements...'))
        data = runPyDevice('sig_analyzer_noise_sweep', HP89410A, 1);
        disp('Time elapsed during measurements:')
        toc

        %The mat file has x and y arrays, to plot you'd do: loglog(x',y')
        load('sig_analyzer_noise_sweep_10_results.mat')
        %load('../../Data/sig_analyzer_noise_sweep_10_results.mat')


        %Create the plot title for this measurement
        plotTitleNote = strrep(saveFileNote,'_',' ');
        %Add DC voltage information to the plot title if the DC supply is in use
        if(useDCsupply)
            plotTitleNote = sprintf('%s\nDC = %0.2fV supply input',plotTitleNote,DCsupply.voltagesToSweep(i));
            if(DCgain ~= 1)
                plotTitleNote = sprintf('%s, %0.1fmV on DUT',plotTitleNote,DCsupply.voltagesToSweep(i)*DCgain*1e3);
            end
        end

        %Save this run data
        if(save_all)
            datestamp = datestr(date,29);
            C = clock;
            timestamp = sprintf('%02dhr_%02dmin_%02.0fsec',C(4),C(5),C(6));
            run_name = sprintf('%s_%s_%s',datestamp,timestamp,saveFileNote);
            saveFileName = ['./' saveDirectory '/' run_name '.mat'];
            try
                save(saveFileName);
            catch MExc
                disp(MExc.message)
                disp('If unable to save file, make sure this is run from the MATLAB Directory');
            end
        end

        %Plot this noise measurement
        plotNoiseData;
        f_ret=frequencies(chop_bins+1:end,:);
        PSD_ret=1e6*final_PSDs(chop_bins+1:end,:);
    end
end
