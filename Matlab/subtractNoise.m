function [ f, final_PSDs ] = subtractNoise( Av, gndName, noiseName )
%Returns Voltage noise data for electrode
%   Detailed explanation goes here

    %Load grounded input
    load(gndName)
    PSD_gnd=y(1:end,:)'./Av;

    %Load electrode to subtract grounded measurement from
    load(noiseName)
    PSD_el=y'./Av;
    
    f = x;
    
    final_PSDs=sqrt(PSD_el.^2-PSD_gnd.^2);

end

