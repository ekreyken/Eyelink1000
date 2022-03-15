function [ output_args ] = PlayTone( Frequency, Duration)
%PLAYTONE Plays Frequency tone for Duration
%   Tone: frequency in Hz
%   Duration: in seconds
%   Returns: 0
   sampleFreq = 44100;
   dt = 1/sampleFreq;

   t = [0:dt:Duration];

   s=sin(2*pi*Frequency*t);
   sound(s,sampleFreq);

   output_args=0;
end

