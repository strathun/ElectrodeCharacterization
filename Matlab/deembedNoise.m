function [ f, V ] = deembedNoise( gndNoise, elecNoise, Hf_file )
    
    
    [fgnd, Vgnd] = concatSpans(gndNoise);
    
    load(Hf_file)
    hf=y';hf_f=x'-x(1);
    hf(1)=hf(2);
    Hf = interp1(hf_f,hf,fgnd);
    
    [fe, Ve] = concatSpans(elecNoise);

    
    PSDs=sqrt((Ve.^2-Vgnd.^2));


    V=PSDs./db2mag(Hf);
    f=fe;
    
%     semilogx(fe,final_PSDs)
end

