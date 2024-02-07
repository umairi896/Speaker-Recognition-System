
clear all
[y,fs] = audioread('omar.wav');

% Compute the MFCCs using the built-in function
mfccs_builtin = mfcc(y, fs);
mfccs_builtin = mfccs_builtin';
% Calculate the mean square error between the two sets of MFCCs
figure;
plot(mfccs_builtin);
xlabel('MFCC Coefficients');
ylabel('Amplitude');
title('MFCCs of audio file');
