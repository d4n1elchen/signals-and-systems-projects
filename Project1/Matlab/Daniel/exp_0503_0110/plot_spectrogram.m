clc; clear;

name = {'acrylic', 'al_ruler', 'spoon'};
k = 1;

for k=1:3
figure;
for i=1:3
    data = load(['ironcup_', name{k}, '_', num2str(i), '.txt']);
    time = data(:,1)-data(1,1);
    origin = data(:,2);
    offset = median(origin(1:500));
    origin = origin-offset;
    
    a = 0.95;
    filtered = filter([1, -a], 1, origin);
    
    L = length(origin);
    Fs = L/time(end)*1e6;
    w = hamming(L);
    
    subplot(2,3,i);
    plot(filtered);
    title([name{k}, num2str(i)],'Interpreter','none');
    subplot(2,3,3+i);
    spectrogram(filtered, 128, 40, 128, 'yaxis');
end
end