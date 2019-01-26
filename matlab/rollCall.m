%Someday this will allow the user to run inside a folder to have it
%automate everything. Like Tye's. Maybe just try to get his to work here...

getDir = pwd;
myFolderInfo = dir(getDir);
folderNames = {myFolderInfo.name}';
folderNames = folderNames(3:end);


[arrayN, boo] = size(folderNames);

for arrayi = 1:1    % arrayN
    d = folderNames(arrayi);
    d = char(d);
    run combineLowHighDataMultiPlot.m
    d = strcat(d,'\Impedance')
    run ExtractImpedanceData2MultiPlot.m
end
