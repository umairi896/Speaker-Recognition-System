% Load audio dataset
[y, fs] = audioread('audio.wav');

% Extract MFCC features
mfcc_coef = mfcc(y, fs);

% Define number of states for the HMM
num_states = 10;

% Train HMM using Baum-Welch algorithm
hmm = hmmtrain(mfcc_coef, num_states, 'Algorithm', 'BaumWelch');

% Test HMM on unseen samples
[test_samples,fs] = audioread('speaker.wav') % load unseen samples here
test_mfcc = mfcc(test_samples, fs);
[predicted_states, logprob] = hmmdecode(test_mfcc, hmm);

% Compare predicted states with known speaker labels
speaker_labels = ... % load known speaker labels here
accuracy = sum(predicted_states == speaker_labels) / length(speaker_labels);

% Print accuracy
fprintf('Accuracy: %.2f%%\n', accuracy*100);
