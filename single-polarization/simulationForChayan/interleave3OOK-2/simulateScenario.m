function simulateScenario(powerQAM, powerOOK, symbolRate, channelSpacing)
%% Simulation of OOK+16QAM+OOK
% Variables:
% QAM power: -20:1:10
% channel spacing: [50, 100, 150, 200] GHz
% QAM symbol rate: 1:1:channelSpacing-10 GHz
% 
% Constant:
% OOK power: 0
% OOK symbol rate: 10 GHz

numberChannel = 5;

%% Define links and channels
% S = 0.06 ps/(nm^2*km) = 60 s/m^3
linkArray = [...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 80e3, 'S', 60); ...
    Link('spanLength', 82e3, 'DCFLength', 90e3, 'S', 60)];

channelArray = repmat(Channel(), numberChannel, 1);
for n = 1:numberChannel
    if mod(n, 2)==1
        channelArray(n) = ...
            Channel('modulation', 'OOK', ... 
            'centerFrequency', (n-(numberChannel+1)/2)*channelSpacing, ...
            'powerdBm', powerOOK, ...
            'minNumberSymbol', 2^14, ...
            'opticalFilterBandwidth', 50e9);
    else
        channelArray(n) = ...
            Channel('modulation', '16QAM', ... 
            'centerFrequency', (n-(numberChannel+1)/2)*channelSpacing, ...
            'symbolRate', symbolRate, ...
            'powerdBm', powerQAM, ...
            'minNumberSymbol', 2^14, ...
            'opticalFilterBandwidth', channelSpacing);
    end
end

%%
simulationName = sprintf('PQAM_%d_POOK_%d_symbolRate_%d_channelSpacing_%d', ...
    powerQAM, powerOOK, symbolRate/1e9, channelSpacing/1e9);

sp = SinglePolarization(...
    'simulationName', simulationName, ...
    'simulationId', 1, ...
    'linkArray', linkArray, ...
    'channelArray', channelArray, ...
    'useParallel', false, ...
    'saveObject', false);
sp.simulate();
sp.saveSimulationResult(true, false, false);

end