function y = iirfilterapplication(data, Fs, gain, bands)

lowpassobj = IIRlowpass(170, Fs);
rawdata = filter(lowpassobj, data);
composite = rawdata*gain(1);
fvtool(lowpassobj)
% N = 2;
% wc = bands(1);
% [num, den] = butter(N, wc/(Fs/2),'low');
% [h,w] = freqz(num, den);
% mag = abs(h);
% phase = angle(h)*180/pi;
% figure;
% subplot(2,2,1);
% plot(w/pi,mag);
% subplot(2,2,2);
% plot(w/pi,phase);
% n = 1:50;
% impulse = [1 zeros(1, 49)];
% 
% rawdataimpulse = filter(num,den, impulse);
% subplot(2,2,3)
% stem(n, rawdataimpulse);

% bandpassobj = IIRbandpass(bands(i), bands(i+1), Fs);
% 
% fvtool(bandpassobj)
n = linspace(-Fs/2,Fs/2, length(data));
figure
subplot(2,1,1);
plot(rawdata);
title("0 - 170 Hz")
rawdata1freq = real(fftshift(fft(rawdata)));
subplot(2,1,2);
plot(n, rawdata1freq);

% subplot(2,2,1)
% %mag
% subplot(2,2,2)
% %phase
% 
% n = 1:50;
% impulse = [1 zeros(1, 49)];
% 
% rawdataimpulse = filter(rawdata, impulse);
% subplot(2,2,3)
% stem(n, rawdataimpulse);
% 
% figure
% subplot(2,1,1);
% plot(rawdata);
% rawdatafreq = fftshift(real(fft(rawdata)));
% subplot(2,1,2)


for i = 2: length(gain) 
    
%     N = 2;
% wc = [bands(i) bands(i+1)]/(Fs/2);
% [num, den] = butter(N, wc);
% [h,w] = freqz(num, den);
% mag = abs(h);
% phase = angle(h)*180/pi;
% figure;
% subplot(2,2,1);
% plot(w/pi,mag);
% subplot(2,2,2);
% plot(w/pi,phase);
% n = 1:50;
% impulse = [1 zeros(1, 49)];
% 
% rawdataimpulse = filter(rawdata1, impulse);
% subplot(2,2,3)
% stem(n, rawdataimpulse);
%rawdata1 = filter(num, den, data);

bandpassobj = IIRbandpass(bands(i), bands(i+1), Fs);
fvtool(bandpassobj)


 rawdata1 = filter(bandpassobj, data);
 composite = composite + rawdata1*gain(i);
 


 figure
 subplot(2,1,1);
 plot(rawdata1);
 title(sprintf("%d - %d Hz", bands(i), bands(i+1)))
 rawdata1freq = real(fftshift(fft(rawdata1)));
 subplot(2,1,2)
 plot(n,rawdata1freq)



end

y = composite;