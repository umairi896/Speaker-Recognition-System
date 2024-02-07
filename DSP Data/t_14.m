% Collect audio samples for training
[y1,fs1] = audioread('speaker1.wav');
[y2,fs2] = audioread('speaker2.wav');
[y3,fs3] = audioread('speaker3.wav');

% Collect audio samples for testing
[y_test,fs_test] = audioread('test_speaker.wav');

% Extract MFCCs for each sample
mfcc1 = mfcc(y1,fs1);
mfcc2 = mfcc(y2,fs2);
mfcc3 = mfcc(y3,fs3);
mfcc_test = mfcc(y_test,fs_test);


% Initialize UBM with GMM
num_mixtures = 64;
ubm = gmdistribution.fit(training_data, num_mixtures, 'Regularize', 1e-5);

% Estimate sufficient statistics for each sample
stats1 = v_statistics(mfcc1, ubm);
stats2 = v_statistics(mfcc2, ubm);
stats3 = v_statistics(mfcc3, ubm);
