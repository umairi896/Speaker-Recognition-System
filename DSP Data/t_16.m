% Load dataset
[y1, fs1] = audioread('zia.wav');
% Pre-emphasis filtering
pre_emphasis = 0.97;
%y1 = filter([1, -pre_emphasis], 1, y1);

[y2, fs2] = audioread('jabir2.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y2 = filter([1, -pre_emphasis], 1, y2);

[y3, fs3] = audioread('umair1.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y3 = filter([1, -pre_emphasis], 1, y3);

[y4, fs4] = audioread('ehsan2.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y4 = filter([1, -pre_emphasis], 1, y4);

[y5, fs5] = audioread('s2.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y5 = filter([1, -pre_emphasis], 1, y5);

[y6, fs6] = audioread('s3.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y6 = filter([1, -pre_emphasis], 1, y6);

[y7, fs7] = audioread('s4.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y7 = filter([1, -pre_emphasis], 1, y7);

[y8, fs8] = audioread('s5.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y8 = filter([1, -pre_emphasis], 1, y8);

[y9, fs9] = audioread('s6.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y9 = filter([1, -pre_emphasis], 1, y9);

[y10, fs10] = audioread('wistle.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
%y10 = filter([1, -pre_emphasis], 1, y10);



% Extract features
mfcc1 = mfcc(y1, fs1);
mfcc2 = mfcc(y2, fs2);
mfcc3 = mfcc(y3, fs3);
mfcc4 = mfcc(y4, fs4);
mfcc5 = mfcc(y5, fs5);
mfcc6 = mfcc(y6, fs6);
mfcc7 = mfcc(y7, fs7);
mfcc8 = mfcc(y8, fs8);
mfcc9 = mfcc(y9, fs9);
mfcc10 = mfcc(y10, fs10);
lpc1 = lpc(y1,12);
lpc2 = lpc(y2,12);
lpc3 = lpc(y3,12);
lpc4 = lpc(y4,12);
lpc5 = lpc(y5,12);
lpc6 = lpc(y6,12);
lpc7 = lpc(y7,12);
lpc8 = lpc(y8,12);
lpc9 = lpc(y9,12);

% Concatenate the feature vectors for each speaker
training_data = [mfcc1; mfcc2; mfcc3;mfcc4;mfcc5;mfcc6;mfcc7;mfcc8;mfcc9;mfcc10];
training_labels = [ones(size(mfcc1,1), 1); ones(size(mfcc2,1), 1)*2; ones(size(mfcc3,1), 1)*3 ; ones(size(mfcc4,1), 1)*4; ones(size(mfcc5,1), 1)*5 ; ones(size(mfcc6,1), 1)*6 ; ones(size(mfcc7,1), 1)*7; ones(size(mfcc8,1), 1)*8 ;ones(size(mfcc9,1), 1)*9; ones(size(mfcc10,1),1)*10 ];
%lpc
%training_data_lpc = [lpc1;lpc2;lpc3;lpc4;lpc5;lpc6;lpc7;lpc8;lpc9];
%training_labels_lpc = [ones(size(lpc1,1), 1); ones(size(lpc2,1), 1)*2; ones(size(lpc3,1), 1)*3 ; ones(size(lpc4,1), 1)*4; ones(size(lpc5,1), 1)*5 ; ones(size(lpc6,1), 1)*6 ; ones(size(lpc7,1), 1)*7; ones(size(lpc8,1), 1)*8 ;ones(size(lpc9,1), 1)*9 ];


% Train a decision tree classifier
tree = fitctree(training_data, training_labels);
    %lpc
%tree_lpc = fitctree(training_data_lpc,training_labels_lpc);

% Test the classifier on unseen samples
[y_test, fs_test] = audioread('zia.wav');
% Pre-emphasis filtering
    %pre_emphasis = 0.97;
y_test = filter([1, -pre_emphasis], 1, y_test);
y_test = reshape(y_test, [], 1);
mfcc_test = mfcc(y_test, fs_test);

%lpc_test = lpc(y_test,12);

predict_speaker1 = predict(tree, mfcc_test);
%predict_speaker_lpc1 = predict(tree_lpc,lpc_test);

[counts, bin_edges] = histcounts(predict_speaker1);

predict_speaker = mode(predict_speaker1);


%testing_variable = size(training_data(mfcc))
%testing_v1  =   eval(sprintf('mfcc%d', 1))

%if max(counts) < size(predict_speaker1,1)*(1/2) %|  max(counts) > size(eval(sprintf('mfcc%d', predict_speaker)),1)*0.99   %| predict_speaker_lpc1 ~= predict_speaker
%    predict_speaker = 0;
%end
%disp(['The most common speaker is: ', num2str(most_common_speaker)])


% Evaluate the performance
% Compare predicted speaker with the actual speaker
if predict_speaker == 1
    disp('Speaker 1 recognized');
elseif predict_speaker == 2
    disp('Speaker 2 recognized');
elseif predict_speaker == 3
    disp('Speaker 3 recognized');
elseif predict_speaker == 4
    disp('Speaker 4 recognized');
elseif predict_speaker == 5
    disp('Speaker 5 recognized');
elseif predict_speaker == 6
    disp('Speaker 6 recognized');
elseif predict_speaker == 7
    disp('Speaker 7 recognized');
elseif predict_speaker == 8
    disp('Speaker 8 recognized');
elseif predict_speaker == 9
    disp('Speaker 9 recognized');
elseif predict_speaker == 10
    disp('Wistling recognized');  
else
    disp('Unable to recognize speaker');
end
