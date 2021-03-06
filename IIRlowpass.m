function Hd = IIRlowpass(fc,fs)
%IIRLOWPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.4 and Signal Processing Toolbox 8.0.
% Generated on: 13-Jun-2021 21:59:02

% Butterworth Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = fs;  % Sampling Frequency

N=2;
Fpass = fc;       % Passband Frequency
Fstop = 1.2*fc;       % Stopband Frequency
Apass = 1;           % Passband Ripple (dB)
Astop = 80;         % Stopband Attenuation (dB)
match = 'passband';  % Band to match exactly

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
%h  = fdesign.lowpass('N,F3dB', N, fc, Fs);
Hd = design(h, 'butter', 'MatchExactly', match);
%Hd = design(h, 'butter');

% [EOF]
