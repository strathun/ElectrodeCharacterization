%Must run extractImpedance first
figure(100)
impArray = 0;
[zHeight, nnn, nulll] = size(Z);
numbPoints = zHeight;

for ii = 1:length(fnames)-2
    currentNameStr = (char(fnames(ii+2)));
    elecNum = str2num(currentNameStr(15:16));
%     elecNum = str2num(currentNameStr(11:12))
    Zii =(Z(:,1,ii));
    Zinterp(:,ii) = interp1(f1,Zii,fref);
    %figure%hs
    % Noise
    %loglog(f(:,1,ii),sqrt(4*kT*Z(:,1,ii))*1e9,'color',colors(elecNum*spacer,:),'LineWidth',1)
    % Impedance
    for iii = 1:numbPoints
        impArray(ii,iii) = Z(iii,1,ii);
    end
    loglog(f(:,1,ii),(Z(:,1,ii)),'--','color',colors(elecNum*spacer,:),'LineWidth',1)
    xlim([12.4 200e3])
    ylabel(['|Z| ' char(937)],'Fontsize',24,'FontName',font_name)

    xlabel('Frequency (Hz)','Fontsize',24,'FontName',font_name)
    hold on
    [v ind1k] = min(abs(1e3-f(:,1,ii)));
    [v ind100k] = min(abs(100e3-f(:,1,ii)));
    sum1kViv(ii) = Z(ind1k,1,ii);
    sum100kViv(ii)= Z(ind100k,1,ii);
end