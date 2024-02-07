% Collect a dataset of audio samples for training and testing
[y1,fs1] = audioread('speaker1.wav');
[y2,fs2] = audioread('speaker2.wav');
[y3,fs3] = audioread('speaker3.wav');

% Pre-process the audio data to extract features
% Extract MFCCs for each sample
lpc1 = lpc(y1,12);
lpc2 = lpc(y2,12);
lpc3 = lpc(y3,12);

% Concatenate the feature vectors for each speaker
training_data = [lpc1;lpc2;lpc3];

% Train a classifier
% Train a GMM on the feature vectors
gmm = fitgmdist(training_data,[1;2;3]);

% Test the classifier on unseen samples
[y_test,fs_test] = audioread('test_speaker.wav');
lpc_test = lpc(y_test,fs_test);

% Predict speaker using GMM
%predict_speaker = gmm.predict(mfcc_test);
predict_speaker = cluster(gmm, lpc_test);
% Evaluate the performance
% Compare predicted speaker with the actual speaker
if predict_speaker == 1
    disp('Speaker 1 recognized');
elseif predict_speaker == 2
    disp('Speaker 2 recognized');
elseif predict_speaker == 3
    disp('Speaker 3 recognized');
else
    disp('Unable to recognize speaker');
end
