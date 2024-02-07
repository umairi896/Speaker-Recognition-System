% Load dataset
[y1, fs1] = audioread('zia.wav');
[y2, fs2] = audioread('omar.wav');
[y3, fs3] = audioread('umair.wav');

% Extract features
mfcc1 = mfcc(y1, fs1);
mfcc2 = mfcc(y2, fs2);
mfcc3 = mfcc(y3, fs3);

% Concatenate the feature vectors for each speaker
training_data = [mfcc1; mfcc2; mfcc3];
training_labels = [ones(size(mfcc1,1), 1); ones(size(mfcc2,1), 1)*2; ones(size(mfcc3,1), 1)*3];

% Train a decision tree classifier
tree = fitctree(training_data, training_labels);

% Test the classifier on unseen samples
[y_test, fs_test] = audioread('abu1.wav');
mfcc_test = mfcc(y_test, fs_test);
predict_speaker = predict(tree, mfcc_test);


%predict_speaker = mode(predict_speaker);
%disp(['The most common speaker is: ', num2str(most_common_speaker)])


% Evaluate the performance
% Compare predicted speaker with the actual speaker
if predict_speaker == 1
    disp('Zia Speaker 1 recognized');
elseif predict_speaker == 2
    disp('Omar 2 recognized');
elseif predict_speaker == 3
    disp('Umair 3 recognized');
else
    disp('Unable to recognize speaker');
end
