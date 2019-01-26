% Have to run ExtractImpedanceData2 first for now...
% Builds Usable Arrays. Put this section in ExtractImpedanceData2
% eventually

[N,ignore,numTrodes] = size(Zreal);

for trode = 1:numTrodes
    for i = 1:N
        realZ(i,trode) = Zreal(i,1,trode);
        imZ(i,trode) = Zim(i,1,trode);
    end
end


%% Plotting
%figure    %use this figure to plot all traces on same graph
for trode = 1:numTrodes
    figure(trode)
    plot(realZ(:,trode),imZ(:,trode)*(-1),'.','MarkerSize',8);
    hold on
    legend('pre','post','Day1','Day3','Day9')
end