% Collect a set of audio samples from each speaker and extract the MFCCs
num_speakers = 5;
num_samples = 10;
mfccs = cell(num_speakers, num_samples);
for i = 1:num_speakers
    for j = 1:num_samples
        % Read audio file
        filename = sprintf('speaker%d_sample%d.wav', i, j);
        [y, fs] = audioread(filename);
        % Extract MFCCs
        mfccs{i, j} = mfcc(y, fs);
    end
end

% Train HMMs for each speaker using the extracted MFCCs
num_states = 5; % Number of states for each HMM
models = cell(num_speakers, 1);
for i = 1:num_speakers
    mfccs_speaker = cell2mat(mfccs(i, :));
    models{i} = hmmtrain(mfccs_speaker, num_states*ones(1,num_states), 'Verbose', false);
end

% Test the trained HMMs on a new test sample
[y, fs] = audioread('test_sample.wav');
mfccs_test = mfcc(y, fs);
log_likelihoods = zeros(num_speakers, 1);
for i = 1:num_speakers
    log_likelihoods(i) = hmmdecode(mfccs_test, models{i});
end

% Find the speaker with the highest likelihood
[~, speaker_idx] = max(log_likelihoods);
fprintf('Test sample belongs to speaker %d\n', speaker_idx);
