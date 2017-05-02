clc; clear;

k = 1;

for k=5:5:30
    name = ['table_', num2str(k), 'cm_'];
    figure;
    for i=1:3
        data = load([name, num2str(i), '.txt']);
        [~,ia] = unique(data(:,3));
        data = data(ia,3:4);
        time = data(:,1);
        origin = data(:,2);
        offset = median(origin(1:500));

        % Plot original data
        subplot(3,2,(i-1)*2+1);
        plot(time, origin);
        title([name, num2str(i), ' Original Data'],'Interpreter','none');
        ylabel('Amplitude');
        

        % Plot fft
        L = size(time, 1);              % Data length
        Fs = L/time(end)*1000;          % Sample rate
        f = Fs*(0:(L/2))/L;             % Frequency vector
        %w = hanning(L);                 % Window function
        w = 1;                          % Without window function
        
        % denoise
        d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',Fs);
        origin = filtfilt(d,origin);
        
        Y = fft(w.*(origin-offset));     % FFT
        P = 2*abs(Y(2:size(Y)/2+2));    % Get half of result

        [pks,locs] = findpeaks(P,'MinPeakDistance',300);

        subplot(3,2,(i-1)*2+2);
        plot(f, P, f(locs), pks, 'or');
        title([name, num2str(i), ' FFT'],'Interpreter','none');
        ylabel('Amplitude');
    end
end