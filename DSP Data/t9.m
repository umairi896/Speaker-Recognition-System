% Load audio data for training and testing
[y1, fs1] = audioread('speaker1.wav');
[y2, fs2] = audioread('speaker2.wav');

% Extract MFCCs from the audio data
mfccs1 = mfcc(y1, fs1);
mfccs2 = mfcc(y2, fs2);

% Define the number of states and mixtures for the HMM
numStates = 5;
numMix = 2;

% Train the HMM model using the MFCCs
hmm1 = hmmtrain(mfccs1', numStates, 'NumMix', numMix);
hmm2 = hmmtrain(mfccs2', numStates, 'NumMix', numMix);

% Load audio data for testing
[y_test, fs_test] = audioread('test_speaker.wav');

% Extract MFCCs from the test audio data
mfccs_test = mfcc(y_test, fs_test);

% Use the hmmviterbi function to find the most likely sequence of states
% for the test data
[path1, loglik1] = hmmviterbi(hmm1, mfccs_test');
[path2, loglik2] = hmmviterbi(hmm2, mfccs_test');

% Compare the log likelihoods of the test data for each trained model
if loglik1 > loglik2
    disp('Test speaker matches speaker 1')
else
    disp('Test speaker matches speaker 2')
end
