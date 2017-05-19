clc; clear;

name = {'al_ruler', 'arclic', 'spoon'};

for k=1:3
figure;
for i=1:3
    raw = load(['data_', name{k}, num2str(i), '.txt']);
    amped = raw(:,1);
    origin = raw(:,2);
    
    subplot(3,2,(i-1)*2 + 1);
    plot(origin);
    
    FFT = abs(fft(origin));
    FFT = FFT(1:size(FFT)/2+1);
    
    subplot(3,2,(i-1)*2 + 2);
    plot(FFT);
end
end