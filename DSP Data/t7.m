% Collect a dataset of audio samples for training and testing
[y1,fs1] = audioread('speaker1.wav');
[y2,fs2] = audioread('speaker2.wav');
[y3,fs3] = audioread('speaker3.wav');

% Pre-process the audio data to extract features
% Extract MFCCs for each sample
mfcc1 = mfcc(y1,fs1);
mfcc2 = mfcc(y2,fs2);
mfcc3 = mfcc(y3,fs3);

% Concatenate the feature vectors for each speaker
training_data = [mfcc1;mfcc2;mfcc3];

% Train a classifier
% Train a GMM on the feature vectors
gmm = fitgmdist(training_data,3);

% Test the classifier on unseen samples
[y_test,fs_test] = audioread('test_speaker.wav');
mfcc_test = mfcc(y_test,fs_test);

% Predict speaker using GMM
%predict_speaker = gmm.predict(mfcc_test);
predict_speaker = cluster(gmm, mfcc_test);
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
