if exist('s','var')
    fclose(s);
end
clc; clear;

s = serial('COM3');
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'BaudRate',115200);
set(s,'Parity','none');
fopen(s);
pause(3);

frameSize = 1000;
step = 100;
dt = [];
time = [];
data = [];

tic;
fwrite(s,'S');
L = 0;
while L < step
    d = fscanf(s,'# %f %f\n');
    dt = [dt d(2)-3.115];
    L = L+1;
end
disp('Knock!');
while var(dt)<2e-4
    L = 0;
    while L < step
        d = fscanf(s,'# %f %f\n');
        dt = [dt d(2)-3.115];
        L = L+1;
    end
end
offset = median(dt);
L = 0;
while L < frameSize
    d = fscanf(s,'# %f %f\n');
    time = [time; d(1)];
    data = [data; d(2)-offset];
    L = L+1;
end
flushinput(s);
fwrite(s,'P');
toc;

time = time-time(1);

% figure;
% var(data)
% plot(data);
fclose(s);

load('model.mat');

time = time;
origin = data;

L = size(time, 1);              % Data length
Fs = L/time(end)*1000;          % Sample rate
f = Fs*(0:(L/2))/L;             % Frequency vector
% w = hanning(L);                 % Window function
w = 1;                          % Without window functions
Y = fft(w.*(origin));     % FFT
P = log(2*abs(Y(2:size(Y)/2+2)));    % Get half of result

dc = dct(P);
dc = dc(1:13);
features = [P' dc'];

trainedClassifier.predictFcn(table(features))
