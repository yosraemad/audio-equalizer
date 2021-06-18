function y = firfiltersapplication(data, Fs, gain, bands)

lowpassobj = FIRlowpass(Fs, 170);

% [h,w] = freqz(lowpassobj, 1);

% mag = abs(h);
% phase = angle(h)*180/pi;
% figure;
% subplot(2,1,1);
% plot(w/pi,mag);
% subplot(2,1,2);
% plot(w/pi,abs(phase));

rawdata = filter(lowpassobj, data);
composite = rawdata*gain(1);

fvtool(lowpassobj)

n = linspace(-Fs/2,Fs/2, length(data));

figure
subplot(2,1,1);
plot(rawdata);
title("0 - 170 HZ")
rawdatafreq = real(fftshift(fft(rawdata)));
subplot(2,1,2)
plot(n, rawdatafreq)


for i = 2: length(gain) 
bandpassobj = FIRbandpass(bands(i), bands(i+1), Fs);
% [h,w] = freqz(bandpassobj, 1);
% 
% mag = abs(h);
% phase = angle(h)*180/pi;
% figure;
% subplot(2,1,1);
% plot(w/pi,mag);
% subplot(2,1,2);
% plot(w/pi,abs(phase));

rawdata1 = filter(bandpassobj , data);
composite = composite + rawdata1*gain(i);
fvtool(bandpassobj)

figure
subplot(2,1,1);
plot(rawdata1);
title(sprintf("%d - %d Hz", bands(i), bands(i+ 1)))
rawdata1freq = real(fftshift(fft(rawdata1)));
subplot(2,1,2)
plot(n, rawdata1freq)
end


y = composite;