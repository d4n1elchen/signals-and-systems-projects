clc; clear;

prefix = 'chair_hammer_';
n = 5;

for k=5:5:20
    name = [prefix, num2str(k), 'cm_'];
    figure;
    for i=1:n
        data = load([name, num2str(i), '.txt']);
        time = data(:,3);
        origin = data(:,4);
        offset = median(origin(1:500));
        l=0; r=size(origin ,1);
%         [origin, l, r] = trimSilence(origin, 9e-5);
%         time = time(l:r)-time(l);

        % Plot original data
        subplot(n,2,(i-1)*2+1);
        plot(time/1e6, origin);
        title([name, num2str(i), ' Original Data'],'Interpreter','none');
        ylabel('Amplitude');
        

        % Plot fft
        L = size(time, 1);              % Data length
        Fs = L/time(end)*1e6;          % Sample rate
        f = Fs*(0:(L/2))/L;             % Frequency vector
        %w = hanning(L);                 % Window function
        w = 1;                          % Without window function
        
%         % denoise
%         d = designfilt('bandstopiir','FilterOrder',2, ...
%                'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
%                'DesignMethod','butter','SampleRate',Fs);
%         origin = filtfilt(d,origin);
        
        Y = fft(w.*(origin-offset));     % FFT
        P = 2*abs(Y(2:size(Y)/2+2));    % Get half of result

        [pks,locs] = findpeaks(P,'MinPeakDistance',(r-l)/2/5-1);

        subplot(n,2,(i-1)*2+2);
        plot(f, P, f(locs), pks, 'or');
        title([name, num2str(i), ' FFT'],'Interpreter','none');
        ylabel('Amplitude');
    end
end