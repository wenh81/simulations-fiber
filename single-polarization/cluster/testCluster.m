%% Simulation of OOK-16QAM-OOK
clc;
clear;
close all;

%% Define links and channels
% S = 0.06 ps/(nm^2*km) = 60 s/m^3
linkArray = [...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 90e3, 'S', 60)];

channelArray = [...
    Channel('modulation', 'OOK', 'centerFrequency', -50e9, 'powerdBm', -3); ...
    Channel('modulation', '16QAM', 'centerFrequency', 0e9, 'symbolRate', 32e9, 'powerdBm', -3); ...
    Channel('modulation', 'OOK', 'centerFrequency', 50e9, 'powerdBm', -3)];

%% 
sp = SinglePolarization(...
    'simulationName', 'testHebbe', ...
    'simulationId', 1, ...
    'linkArray', linkArray, ...
    'channelArray', channelArray, ...
    'useParallel', false);
sp.simulate()