function H = melfilterbank(num_filters, fft_size, fs)
    % Convert frequency to Mel scale
    f_mel = @(f) 2595 * log10(1 + f/700);
    % Convert Mel frequency to frequency
    f_hz = @(m) 700 * (10.^(m/2595) - 1);
    
    % Define the edges of the Mel filters
    mel_low = 0;
    mel_high = f_mel(fs/2);
    mel_edges = linspace(mel_low, mel_high, num_filters+2);
    
    % Convert Mel edges to Hz
    hz_edges = f_hz(mel_edges);
    
    % Convert Hz edges to FFT bin indices
    bin_edges = round(hz_edges / (fs/2) * (fft_size/2));
    
    %Make sure that the bin edges are within the range of the FFT size.
    bin_edges(bin_edges<1) = 1;
    bin_edges(bin_edges>fft_size/2+1) = fft_size/2+1;
    
    % Create a matrix of weights for each filter
    H = zeros(num_filters, fft_size/2+1);
    for i = 1:num_filters
        for j = bin_edges(i):bin_edges(i+1)
            H(i,j) = (j - bin_edges(i)) / (bin_edges(i+1) - bin_edges(i));
        end
        for j = bin_edges(i+1):bin_edges(i+2)
            H(i,j) = (bin_edges(i+2) - j) / (bin_edges(i+2) - bin_edges(i+1));
        end
    end
end
