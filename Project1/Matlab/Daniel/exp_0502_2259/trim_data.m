function [res, st, ed] = trim_data(ori, frameSize, thres)
    frameNum = floor(length(ori)/frameSize);
    signal_start = 0;
    vars = zeros(frameNum, 1);
    for i=1:frameNum
        frame = ori(frameSize*(i-1)+1:frameSize*i);
%         vars(i) = var(frame);
        if var(frame) > thres
            signal_start = frameSize*(i-1)+1;
            break;
        end
    end
    signal_end = 0;
    for i=frameNum:-1:1
        frame = ori(frameSize*(i-1)+1:frameSize*i);
%         vars(i) = var(frame);
        if var(frame) > thres
            signal_end = frameSize*i;
            break;
        end
    end
    res = ori(signal_start:signal_end);
    st = signal_start;
    ed = signal_end;
end