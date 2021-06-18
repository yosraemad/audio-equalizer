fileName = input('Enter the file name: ', 's');

gains = zeros(1,9);
bands = [0 170 310 600 1000 3000 6000 12000 14000 16000];

fs = 16000*1.2*2;

for i = 1: 9 
   gains(i) = db2mag(input(sprintf('Enter gain in dB %d to %d:', bands(i), bands(i+1)))); 
end

filter = input(sprintf('Enter the type of filter:\n1- FIR\n2- IIR\n'));
outputSampleRate = input('Enter Output Sample Rate: ');

[Y, Fs] = audioread(fileName);
if(Fs < fs)
    Y = resample(Y, fs, Fs);
    Fs = fs;
end

if filter == 2
    x = iirfilterapplication(Y, Fs , gains, bands);
else
    x = firfiltersapplication(Y, Fs, gains, bands);
end


%Yresample = resample(x, outputSampleRate*Fs , Fs);
n = linspace(-Fs/2,Fs/2, length(x));
sound(x, outputSampleRate*Fs);
figure
subplot(2,1,1)
plot(Y)
title("Original Sound in time domain");
subplot(2,1,2)
plot(n,real(fftshift(fft(Y))))
title("Original Sound in Frequency domain")


figure
subplot(2,1,1)
plot(x);
xfreq = real(fftshift(fft(x)));
title("Composite Signal in Time Domain")
subplot(2,1,2);
plot(n, xfreq);
title("Composite Signal in frequency domain")
