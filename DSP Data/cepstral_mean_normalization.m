function frame_mfccs = cepstral_mean_normalization(frame_mfccs)
    cepstral_mean = mean(frame_mfccs);
    frame_mfccs = frame_mfccs - repmat(cepstral_mean, size(frame_mfccs, 1), 1);
end
