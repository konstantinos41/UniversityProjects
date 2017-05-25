targetVoice = 'target.wav';
input = 'source.wav';
output = 'output.wav';

[src_v, Fs1, nbits1] = wavread(input);
[trg_v, Fs2, nbits2] = wavread(targetVoice);

s = src_v;
T1 = 1/Fs1;             % Sampling period
L1 = length(s);        % Length of signal
t1 = (0:L1-1)*T1;  
%figure; plot(t1,s);
%title('Source Voice')
%xlabel('t (sec)')
%ylabel('S(t)')

t = trg_v;
T2 = 1/Fs2;             % Sampling period
L2 = length(t);        % Length of signal
t2 = (0:L2-1)*T2;  
%figure; plot(t2,t);
%title(' Target Voice')
%xlabel('t (sec)')
%ylabel('T(t)')

[p1, f1] = fastFourier(s,Fs1);
[p2, f2] = fastFourier(t,Fs2);
%figure; plot(f1,p1); figure; plot(f2,p2);
winLength = 3;

%[peaks1, freqOfPeaks1] = estimatePeaks(p1, f1, 0.0298, winLength);
%[peaks2, freqOfPeaks2] = estimatePeaks(p2, f2,0.03, winLength);
[peaks1, freqOfPeaks1] = estimatePeaks(p1, f1, 0.02, winLength);
[peaks2, freqOfPeaks2] = estimatePeaks(p2, f2,0.02, winLength);
[max1, l1]= max(peaks1);
[max2, l2]= max(peaks2);
pitch1 = freqOfPeaks1(l1)/Fs1;
pitch2 = freqOfPeaks2(l2)/Fs2;
% Calculate shift-offset
difference_f0 = pitch1 - pitch2;
%% Left shift or right shift ? 
if difference_f0 > 0
    %move = 'left';
    shiftOffset = difference_f0*1000;
end
if difference_f0 < 0
    move = 'right';
    shiftOffset = -(difference_f0*1000);
end

%figure; plot(nf1,p1);
%temp = ifft(p1);
%L = length(temp);
%nt = (0:L-1)*(1/Fs1);        
%output = L*ifft(p1);
%figure; plot(nt,L*ifft(p1));
%title('Morphing System Output')
%xlabel('t (sec)')
%ylabel('Y(t)')

%% TimeStretch_SOlA
[signal,Fs]	=	wavread('source.wav');
DAFx_in		=	signal';

Sa	= 5000;
N	= 10000;
if Sa > N 
   disp('Sa must be less than N !!!')
end
M	=	ceil(length(DAFx_in)/Sa);

% Segmentation into blocks of length N every Sa samples
% leads to M segments

alpha = 0.75;
Ss = round(Sa*alpha);
L = 10;

if Ss >= N disp('alpha is not correct, Ss is >= N')
elseif Ss > N-L disp('alpha is not correct, Ss is > N-L')
end

DAFx_in(M*Sa+N)=0;
Overlap  =  DAFx_in(1:N);

% Main loop 
for ni=1:M-1
  grain=DAFx_in(ni*Sa+1:N+ni*Sa);
  XCORRsegment=xcorr(grain(1:L),Overlap(1,ni*Ss:ni*Ss+(L-1)));		
  [xmax(1,ni),index(1,ni)]=max(XCORRsegment);
  fadeout=1:(-1/(length(Overlap)-(ni*Ss-(L-1)+index(1,ni)-1))):0;
  fadein=0:(1/(length(Overlap)-(ni*Ss-(L-1)+index(1,ni)-1))):1;
  Tail=Overlap(1,(ni*Ss-(L-1))+ ...
   index(1,ni)-1:length(Overlap)).*fadeout;
  Begin=grain(1:length(fadein)).*fadein;
  Add=Tail+Begin;
  Overlap=[Overlap(1,1:ni*Ss-L+index(1,ni)-1) ...
           Add grain(length(fadein)+1:N)];
end;

wavwrite(Overlap, Fs1,'time_stretched.wav');

%% Pitch Shifting
% shiftOffsetFrequency = 2;
% shifted = pitchShifting(Overlap, Fs1, shiftOffsetFrequency);
% wavwrite(shifted, Fs1,'output.wav');

%% PSOLA 
m = PitchMarker(Overlap);
alpha = 1;
beta = 8;
out = psola(Overlap,m,alpha,beta);

wavwrite(out,Fs1,'morphed_voice.wav');
sound(out, Fs1);
%sound(t, Fs2);