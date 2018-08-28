function param = derotate_constellation(param)
% Derotate the constellation back for visualization purpose


cidx = 1;
%% Calculate amplitude and angle of the original constellation

% the symbols at transmitter side
u = param.data_mod_symbol_channel{cidx};
% Unique constellation points
C_template = unique(u);
% Amplitude of constellation points
C_template_amplitude = sqrt(sum(abs(C_template).^2, 2));
% Normalize amplitude of constellation points so that the maxium amplitude
% equals 1
C_template_amplitude = C_template_amplitude/max(C_template_amplitude);
% Calculate angles of constellation points in [pi], i.e., the angles are
% multiples of pi
C_template_angle = angle(C_template)/pi;

% Contains amplitudes and angles
C_template = sortrows([C_template_amplitude, C_template_angle], [1, 2]);

%% Real constellation cloud centers
C_receive = param.cloud_centers{cidx};
C_receive_amplitude = sqrt(sum(C_receive.^2, 2));
C_receive_amplitude = C_receive_amplitude./max(C_receive_amplitude);

% Remove noise in amplitude, this part can be automated by smarter
% algorithm. Hard code for speed now.
% This is needed because the received constellation cloud centers are
% sorted by their amplitudes and angles
if param.constellation_size(cidx) == 2
    C_receive_amplitude = ones(size(C_receive_amplitude));
elseif param.constellation_size{cidx} == 16
    C_receive_amplitude(C_receive_amplitude>0.8723) = 1;
    C_receive_amplitude((C_receive_amplitude<0.8723)&(C_receive_amplitude>0.5395)) = 0.74;
    C_receive_amplitude(C_receive_amplitude<0.5395) = 0.33;
end

C_receive_angle = angle(C_receive(:, 1)+1i*C_receive(:, 2))/pi;

[C_receive, C_idx] = sortrows([C_receive_amplitude, C_receive_angle], [1, 2]);

%% Calculate angle to de-rotation
if param.constellation_size(cidx) == 2
    rotation_angle = mean(C_template(:, 2)-C_receive(:, 2));
elseif param.constellation_size{cidx} == 16
    rotation_angle = mean(C_template(:, 2)-C_receive(:, 2));
end

%% De-rotate received signal back in the constellation
% the received signal, corresponds to points in the received constellation
signal = param.signal_received_constellation{cidx};

% convert to complex number
signal_complex = signal(:, 1)+signal(:, 2)*1i;
% de-rotate signal
signal_complex = signal_complex*exp(1i*pi*rotation_angle);
% convert back to Nx2 vector
signal_derotate = zeros(size(signal));
signal_derotate(:, 1) = real(signal_complex);
signal_derotate(:, 2) = imag(signal_complex);

%% Plot de-rotated constellation
plot(signal_derotate(:, 1), signal_derotate(:, 2), '.')
