clear

% Load an audio file
[y, fs] = audioread('omar.wav');

% Define frame size and overlap
frame_size = 256;
overlap = 128;

% Number of Mel filters
num_mel_filters = 20;

% Frame the audio signal
frames = buffer(y, frame_size, overlap);

% Number of frames
num_frames = size(frames, 2);

% Create a Mel filter bank
H = melfilterbank(num_mel_filters, frame_size, fs);

% Apply Hanning window to each frame
for i = 1:num_frames
    % Get the current frame
    frame = frames(:, i);
    % Apply Hanning window
    frame = frame .* hanning(frame_size);
    % Calculate the power spectrum
    %frame_ps = abs(fft(frame)).^2;
    
    frame_ps = abs(fft(frame, frame_size)).^2;
    frame_ps = H * frame_ps(1:frame_size/2+1);  
    
    % Filter the power spectrum with the Mel filter bank
   % frame_ps = H * frame_ps;
    % Perform logarithmic compression on the filtered power spectrum
    frame_ps = log(frame_ps);
    % Apply discrete cosine transform (DCT) to the log-compressed filtered power spectrum
    frame_mfccs = dct(frame_ps);
    % Keep only the first 13 coefficients (as specified by num_coef variable)
    frame_mfccs = frame_mfccs(1:13, :);
    % Normalize the MFCCs
    frame_mfccs = cepstral_mean_normalization(frame_mfccs);
    % Perform some operation on the MFCCs
    % ...
    frames_mfccs(:,i) = frame_mfccs;
end

% Plot the MFCCs of a single frame
figure;
plot(frames_mfccs(:,5));
xlabel('MFCC Coefficients');
ylabel('Amplitude');
title('MFCCs of a Single Frame');


