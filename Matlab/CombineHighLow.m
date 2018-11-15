function [ f P ] = CombineHighLow(gndHigh,fHigh, gndLow,fLow, AvHigh, AvLow, highType, lowType )
%Currently only works with 'fast' setting for acquired data
%   Detailed explanation goes here
    load(gndHigh)
    PSD_gnd_H=y(1:end,:)'./AvHigh;
    load(fHigh)
    PSD_el_H=y'./AvHigh;
    final_PSDs_H=sqrt(PSD_el_H.^2-PSD_gnd_H.^2);
    [fH, PH] =mergeSpans(x, final_PSDs_H, 1, highType);
    
    load(gndLow)
    PSD_gnd_L=y(1:end,:)'./AvLow;
    load(fLow)
    PSD_el_L=y'./AvLow;
    final_PSDs_L=sqrt(PSD_el_L.^2-PSD_gnd_L.^2);
    [fL, PL] =mergeSpans(x, final_PSDs_L, 0, lowType);
    
    f = [fL(1:end); fH(1:end)];
    P = [PL(1:end); PH(1:end)];
end

