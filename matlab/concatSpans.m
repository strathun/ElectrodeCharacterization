function [ span, V ] = concatSpans( filename )
% combines multiple spans into 1 with the following format:
% spans =    [100 1e3 10e3 100e3 200e3 500e3 1e6 10e6];
% centers =  [50  500 5e3  50e3 100e3  250e3 500e3 5e6];
% averages = [64 128 128 256 256 256 512 512];

    addpath('C:\Users\Tye\Documents\MATLAB\pydevicecontrol\Noise_Test_Data');
    load(filename);
    %trim the first 12 points
    x1=x(:,13:end)';
    y1=y(:,13:end)';

    p8=y1(30:end,8);    px8=x1(30:end,8);
    p7=y1(62:end,7);    px7=x1(62:end,7);
    p5=y1(36:end-30,5); px5=x1(36:end-30,5);
    p4=y1(30:80,4);     px4=x1(30:80,4);
    p3=y1(30:end-1,3);  px3=x1(30:end-1,3);
    p2=y1(30:end-1,2);  px2=x1(30:end-1,2);
    p1=y1(1:end-1,1);   px1=x1(1:end-1,1);

    span=[px1; px2; px3; px4; px5; px7; px8];
    V=[p1; p2; p3; p4; p5; p7; p8];

end