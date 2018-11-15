%This is a simple script to give a quick view of the data from a single
%experiment. 
%INSTRUCTIONS: Choose figure format below. Select experiment folder in
%first popup window; select "Impedance" folder inside of this foler in
%second popup.

%User defined parameters
figStyle = 1;    %0 for separate electrode figures; 1 for single figure with all electrodes
lowspdStage = 0; %0 for regular LS head stage (default). 1 if using LS2


close all

if figStyle == 0
    if lowspdStage == 0
        run combineLowHighData.m
    else
        run combineLowHighData_LS2.m
    end 
    run ExtractImpedanceData2.m
else 
    if lowspdStage == 0
        run combineLowHighDataMultiPlot.m
    else
        run combineLowHighDataMultiPlot_LS2.m
    end 
    run ExtractImpedanceData2MultiPlot.m
end 

