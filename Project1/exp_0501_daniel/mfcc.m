
for i=1:3
    data = load(['ironcup_spoon_', num2str(i), '.txt']);
    time = data(:,1)-data(1,1);
    origin = data(:,2);
    offset = median(origin(1:500));
    origin = origin-offset;
    
    a = 0.95;
    filtered = filter([1, -a], 1, origin);
    
    L = length(origin);
    Fs = L/time(end)*1e6;
    w = hamming(L);
    
    frameSize = 256;
    step = floor(frameSize*2/3);
    frameNum = (L-frameSize)/step;
    for j=1:frameNum
        frame = filtered(step*(j-1):step*(j-1)+frameSize).*w;
        Y = fft(frame);     % FFT
        P = 2*abs(Y(2:size(Y)/2+2));    % Get half of result
    end
end