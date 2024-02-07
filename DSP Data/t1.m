% Load an audio file
[y, fs] = audioread('audio.wav');

% Define frame size and overlap
frame_size = 256;
overlap = 128;

% Frame the audio signal
frames = buffer(y, frame_size, overlap);

% Number of frames
num_frames = size(frames, 2);

% Apply Hanning window to each frame
for i = 1:num_frames
    % Get the current frame
    frame = frames(:, i);
    % Apply Hanning window
    frame = frame .* hanning(frame_size);
    % Calculate the power spectrum
    %frame_ps = abs(fft(frame)).^2;
    % Extract MFCCs
    %mfccs = mfcc(frame_ps, fs);
    % Perform some operation on the MFCCs
    % ...
    frames(:,i) = frame;
end
plot(frames(:,1250))
