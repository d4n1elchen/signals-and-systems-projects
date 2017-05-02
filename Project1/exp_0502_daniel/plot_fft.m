clc; clear;

name = {'acrylic', 'al_ruler', 'plastic_ruler', 'spoon'};
k = 1;

dcs = zeros(13,4,5);
for k=1:4
figure;
for i=1:5
    data = load([name{k}, num2str(i), '.txt']);
    time = data(:,3);
    origin = data(:,5);
    offset = median(origin(1:500));
    origin = origin-offset;
    
    a = 0.95;
    filtered = filter([1, -a], 1, origin);
    
    [trimed, s, e] = trim_data(filtered, 100, 5e-4);
    time_trimed = time(s:e)-time(s);
    
    % Plot original data
    subplot(5,2,(i-1)*2+1);
    plot(time_trimed, trimed);
    title([name{k}, num2str(i), ' Original Data'],'Interpreter','none');
    ylabel('Amplitude');
    
    % Plot fft
    L = size(time_trimed, 1);              % Data length
    Fs = L/time_trimed(end)*1000;          % Sample rate
    f = Fs*(0:(L/2))/L;             % Frequency vector
    w = hamming(L);                 % Window function
    %w = 1;                          % Without window functions
    Y = fft(w.*trimed);     % FFT
    P = log(2*abs(Y(2:size(Y)/2+2)));    % Get half of result
    
    [pks,locs] = findpeaks(P,'MinPeakDistance',length(P)/5);
    
%     subplot(5,2,(i-1)*2+2);
%     plot(f, P, f(locs), pks, 'or');
%     title([name{k}, num2str(i), ' FFT'],'Interpreter','none');
%     ylabel('Amplitude');
    
    dc = dct(P);
    dcs(:,k,i) = dc(1:13);
    
    subplot(5,2,(i-1)*2+2);
    plot(dc(1:13));
    title([name{k}, num2str(i), ' DCT'],'Interpreter','none');
    ylabel('Amplitude');
end
end

th = zeros(20,20);
for i=1:4
    for j=1:5
        for k=1:4
            for l=1:5
                A=dcs(:,i,j); B=dcs(:,k,l); 
                th(5*(i-1)+j, 5*(k-1)+l) = dot(A,B)/norm(A)/norm(B);
            end
        end
    end
end