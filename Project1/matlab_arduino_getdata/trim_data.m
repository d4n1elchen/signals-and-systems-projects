function res = trim_data(ori, frameSize)
    frameNum = floor(length(ori)/frameSize);
    signal_start = 0;
    vars = zeros(frameNum, 1);
    for i=1:frameNum
        frame = ori(frameSize*(i-1)+1:frameSize*i);
        vars(i) = var(frame);
    end
    plot(vars);
    res = ori;
end