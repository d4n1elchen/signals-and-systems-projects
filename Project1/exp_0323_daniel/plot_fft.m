clc; clear;

name = {'acrylic', 'al_ruler', 'plastic_ruler', 'spoon'};
k = 1;

for k=1:4
figure;
for i=1:5
    data = load([name{k}, num2str(i), '.txt']);
    time = data(:,3);
    origin = data(:,5);
    offset = median(origin(1:500));
    
    % Plot original data
    subplot(5,2,(i-1)*2+1);
    plot(time, origin);
    title([name{k}, num2str(i), ' Original Data'],'Interpreter','none');
    ylabel('Amplitude');
    
    % Plot fft
    L = size(time, 1);              % Data length
    Fs = L/time(end)*1000;          % Sample rate
    f = Fs*(0:(L/2))/L;             % Frequency vector
    %w = hanning(L);                 % Window function
    w = 1;                          % Without window function
    Y = fft(w.*(origin-offset));     % FFT
    P = 2*abs(Y(2:size(Y)/2+2));    % Get half of result
    
    [pks,locs] = findpeaks(P,'MinPeakDistance',300);
    
    subplot(5,2,(i-1)*2+2);
    plot(f, P, f(locs), pks, 'or');
    title([name{k}, num2str(i), ' FFT'],'Interpreter','none');
    ylabel('Amplitude');
end
end