function [ f P ] = CombineHighLow(gndHigh,fHigh, gndLow,fLow, AvHigh, AvLow, highType, lowType )
%Currently only works with 'fast' setting for acquired data
%   Detailed explanation goes here

if strcmp(highType,'HSonly')
    load(gndHigh)
%     PSD_gnd_H=y(1:end,:)'./AvHigh;
    PSD_gnd_H=y(1:end,:)';
    load(fHigh)
%     PSD_el_H=y'./AvHigh;
    PSD_el_H=y';
    final_PSDs_H=sqrt(PSD_el_H.^2-PSD_gnd_H.^2);
    [fH, PH] =mergeSpans(x, final_PSDs_H, 1, highType);
  
    % Pulls in gain spectrum gain measurement. Interpolates these
    % measurements across the frequency range of interest.
    load(AvHigh)
    y = db2mag(y);
    highGain = interp1(x,y,fH);
    lastGainIndex = find(isnan(highGain),1); %Actually first non gain index
    if ~isempty(lastGainIndex)
        highGain(lastGainIndex:end) = highGain(lastGainIndex-1);
    end
    PH = PH./highGain;
    
    f = fH;
    P = PH;
elseif strcmp(highType,'fast')

    load(gndHigh)
%     PSD_gnd_H=y(1:end,:)'./AvHigh;
    PSD_gnd_H=y(1:end,:)';
    load(fHigh)
%     PSD_el_H=y'./AvHigh;
    PSD_el_H=y';
    final_PSDs_H=sqrt(PSD_el_H.^2-PSD_gnd_H.^2);
    [fH, PH] =mergeSpans(x, final_PSDs_H, 1, highType);
    
    % Pulls in gain spectrum gain measurement. Interpolates these
    % measurements across the frequency range of interest.
    load(AvHigh)
    y = db2mag(y);
    highGain = interp1(x,y,fH);
    lastGainIndex = find(isnan(highGain),1); %Actually first non gain index
    if ~isempty(lastGainIndex)
        highGain(lastGainIndex:end) = highGain(lastGainIndex-1);
    end
    PH = PH./highGain;
    
    load(gndLow)
%     PSD_gnd_L=y(1:end,:)'./AvLow;
    PSD_gnd_L=y(1:end,:)';
    load(fLow)
%     PSD_el_L=y'./AvLow;
    PSD_el_L=y';
    final_PSDs_L=sqrt(PSD_el_L.^2-PSD_gnd_L.^2);
    [fL, PL] =mergeSpans(x, final_PSDs_L, 0, lowType);
    
    load(AvLow)
    y = db2mag(y);
    lowGain = interp1(x,y,fL);
    lastGainIndex = find(isnan(lowGain),1); %Actually first non gain index
    if ~isempty(lastGainIndex)
        lowGain(lastGainIndex:end) = lowGain(lastGainIndex-1);
    end
    PL = PL./lowGain;
    
    f = [fL(1:end); fH(1:end)];
    P = [PL(1:end); PH(1:end)];

elseif strcmp(highType,'fast_old')
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

end

