clc; clear;

name = {'chopstick', 'al_ruler', 'spoon'};
N = 20;

labels = {};
features = [];

for k=2:3
figure;
for i=1:N
    data = load(['glass_', name{k}, '_', num2str(i), '.txt']);
    time = data(:,1);
    origin = data(:,2);

    % Plot original data
    subplot(N,2,(i-1)*2+1);
    plot(time, origin);
    title([name{k}, num2str(i), ' Original Data'],'Interpreter','none');
    ylabel('Amplitude');
    
    % Calc fft
    L = size(time, 1);              % Data length
    Fs = L/time(end)*1000;          % Sample rate
    f = Fs*(0:(L/2))/L;             % Frequency vector
    w = hanning(L);                 % Window function
%     w = 1;                          % Without window functions
    Y = fft(w.*(origin));     % FFT
    P = log(2*abs(Y(2:size(Y)/2+2)));    % Get half of result
    
    [pks,locs] = findpeaks(P);
    
    % Plot fft
    subplot(N,2,(i-1)*2+2);
    plot(f, P, f(locs), pks, 'or');
    title([name{k}, num2str(i), ' FFT'],'Interpreter','none');
    ylabel('Amplitude');
    
    % Calc DCT
    dc = dct(P);
    
    % Calc RMS
    rm = rms(origin);
    
    % Calc Spectrogram
    s = spectrogram(origin,30,10);
    
    % Calc DCT
    sdc = dct(s);
    
    % Get MFCC
    mf = mfcc(origin, Fs);
    
%     ft = [zscore(P)' zscore(dc)'];
%     ft = [zscore(P)'];
%     ft = [zscore(dc)'];
    [m, n] = size(mf);
    ft = reshape(mf, m*n, 1);
%     ft = [P'];
    labels{end+1,1} = name{k};
    features(end+1,:) = ft;
end
end

tab = table(features,labels);