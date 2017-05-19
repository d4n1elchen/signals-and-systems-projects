
name = {'acrylic', 'al_ruler', 'spoon'};
k = 2;
N = 3;

d = zeros(251, 3, N);
for k=1:3
figure;
for i=1:N
    data = load(['cut_ironcup_', name{k}, '_', num2str(i), '.txt']);
    time = data(:,1)-data(1,1);
    origin = data(:,2);
    offset = median(origin(end-100:end));
    origin = origin-offset;
    
    a = 0.95;
    filtered = filter([1, -a], 1, origin);

    % Plot original data
    subplot(3,2,(i-1)*2+1);
    plot(filtered);
    title([name{k}, num2str(i), ' Original Data'],'Interpreter','none');
    ylabel('Amplitude');
    
    % Plot fft
    L = size(time, 1);              % Data length
    Fs = L/time(end)*1000;          % Sample rate
    f = Fs*(0:(L/2))/L;             % Frequency vector
    %w = hanning(L);                 % Window function
    w = 1;                          % Without window functions
    Y = fft(w.*(filtered));     % FFT
    P = log(2*abs(Y(2:size(Y)/2+2)));    % Get half of result
    [pks,locs] = findpeaks(P,'MinPeakDistance',length(P)/5);
    d(:,k,i) = P;
    
    subplot(3,2,(i-1)*2+2);
    plot(f, P, f(locs), pks, 'or');
    title([name{k}, num2str(i), ' FFT'],'Interpreter','none');
    ylabel('Amplitude');
end
end

z = zeros(251,3,N);
for i=1:3
    for j=1:N
        z(:,i,j) = zscore(d(:,i,j));
    end
end

th = zeros(9,9);
re = zeros(9,9);
mse = zeros(9,9);
for i=1:3
    for j=1:3
        for k=1:3
            for l=1:3
                A = z(:,i,j); B = z(:,k,l);
                th(3*(i-1)+j,3*(k-1)+l) = dot(A,B)/(norm(A)*norm(B));
                re(3*(i-1)+j,3*(k-1)+l) = sum((A-B).^2);
                mse(3*(i-1)+j,3*(k-1)+l) = immse(A,B);
            end
        end
    end
end

