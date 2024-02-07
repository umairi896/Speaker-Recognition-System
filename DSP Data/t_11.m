% Collect a dataset of audio samples for training and testing
[y1,fs1] = audioread('speaker1.wav');
[y2,fs2] = audioread('speaker2.wav');
[y3,fs3] = audioread('speaker3.wav');

% Pre-process the audio data to extract features
% Extract MFCCs for each sample
mfcc1 = mfcc(y1,fs1);
mfcc2 = mfcc(y2,fs2);
mfcc3 = mfcc(y3,fs3);

% Define the number of states and the type of covariance
numStates = 5;
cov_type = 'full';

% Train a HMM for each speaker
hmm1 = hmmtrain(mfcc1, numStates, 'CovType', cov_type);
hmm2 = hmmtrain(mfcc2, numStates, 'CovType', cov_type);
hmm3 = hmmtrain(mfcc3, numStates, 'CovType', cov_type);

% Test the HMMs on unseen samples
[y_test,fs_test] = audioread('test_speaker.wav');
mfcc_test = mfcc(y_test,fs_test);

% Compute the likelihoods of the test sample for each HMM
likelihood1 = hmmdecode(mfcc_test, hmm1);
likelihood2 = hmmdecode(mfcc_test, hmm2);
likelihood3 = hmmdecode(mfcc_test, hmm3);

% Predict the speaker based on the highest likelihood
[~, predict_speaker] = max([likelihood1, likelihood2, likelihood3]);

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
