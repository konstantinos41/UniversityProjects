input = 'TerroristVoice.wav';
output = 'TerroristVoiceFilt.wav';

[x, Fs, nbits] = wavread(input);
T = 1/Fs;             % Sampling period
L = length(x);        % Length of signal
t = (0:L-1)*T;        % Time vector

% plot(t,x)
% title('Signal in Time Domain')
% xlabel('Time (seconds)')
% ylabel('X(t)')
winLength = 3;
thres = 0.25;

[P1, freq_vector] = fastFourier(x,Fs);
[peaks, freqOfPeaks] = estimatePeaks(P1, freq_vector,thres, winLength);

background_denoising(input);
[x, Fs, nbits] = wavread('temp.wav');
delete('temp.wav');
% Specifications of digital filter
Fpass = 1900;        % Passband Frequency
Fstop = 2000;        % Stopband Frequency
Apass = 3;           % Passband Ripple (dB)
Astop = 40;          % Stopband Attenuation (dB)

Hd = myButter(Fpass, Fstop, Apass, Astop, Fs);
out = filter(Hd,x);
wavwrite(out,Fs,nbits,output);

%% Calculate Filter Coefficients 
butter_coef = coeffs(Hd);