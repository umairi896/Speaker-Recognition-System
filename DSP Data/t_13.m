% Collect a dataset of audio samples for training and testing
[y1,fs1] = audioread('speaker1.wav');
[y2,fs2] = audioread('speaker2.wav');
[y3,fs3] = audioread('speaker3.wav');
[y_test,fs_test] = audioread('test_speaker.wav');

% Pre-process the audio data to extract features
% Extract MFCCs for each sample
mfcc1 = mfcc(y1,fs1);
mfcc2 = mfcc(y2,fs2);
mfcc3 = mfcc(y3,fs3);
mfcc_test = mfcc(y_test,fs_test);

% Concatenate the feature vectors for each speaker
training_data = [mfcc1;mfcc2;mfcc3];

% Extract i-vectors for the training data
[total_iv, ubm] = extract_ivector(training_data);

% Extract i-vector for the test sample
test_iv = extract_ivector(mfcc_test, ubm);

% Compute the cosine similarity between the test i-vector and each speaker's i-vector
similarities = cosine_similarity(test_iv, total_iv);

% Find the index of the maximum similarity
[~, max_index] = max(similarities);

% Evaluate the performance
% Compare the predicted speaker with the actual speaker
if max_index == 1
    disp('Speaker 1 recognized');
elseif max_index == 2
    disp('Speaker 2 recognized');
elseif max_index == 3
    disp('Speaker 3 recognized');
else
    disp('Unable to recognize speaker');
end
