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
    % Apply pre-emphasis filter
    frame = filter([1 -0.95], 1, frame);
    % Perform FFT
    frame_fft = fft(frame);
    % Calculate Mel-frequency filter bank
    num_mel_filters = 20;
    mel_filter_bank = melfcc(frame,fs, 'numcep', num_mel_filters, 'wintime', frame_size/fs, 'hoptime', frame_size/fs);
    % Apply Mel-frequency filter bank
    frame_mels = mel_filter_bank * abs(frame_fft);
    % Take logarithm of Mel-frequency energies
    frame_logmels = log(frame_mels);
    % Perform DCT
    frame_mfccs = dct(frame_logmels);
    % Perform some operation on the MFCCs
    % ...
end
