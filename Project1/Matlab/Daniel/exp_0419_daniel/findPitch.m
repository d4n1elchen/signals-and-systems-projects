function output = findPitch( alg, input, framesize, start_frame, end_frame, plot_frame )
    n = framesize;
    output = zeros(end_frame-start_frame, 1);
    switch(alg)
        case 'ACF'
            % loop through frames
            for k=start_frame:end_frame-1
                acf = zeros(n-1, 1);
                frame = input(k*n:(k+1)*n);
                % calc acf for each frame
                for t=(n/5):n-2
                    frame_shift = [zeros(t,1); frame(1:end-t)];
                    acf(t) = dot(frame,frame_shift);
                end
                % plot if k==plot_frame
                if(k==plot_frame)
                    figure;
                    plot(acf);
                end
                % find pitch
                [~, loc] = max(acf);
                output(k-start_frame+1) = loc;
            end
    end
end
