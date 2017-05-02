if exist('s','var')
    fclose(s);
end
clc; clear;

filename = 'ironcup_al_ruler_9.txt';

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
L = 0;
while L < frameSize
    d = fscanf(s,'# %f %f\n');
    time = [time; d(1)];
    data = [data; d(2)-3.115];
    L = L+1;
end
flushinput(s);
fwrite(s,'P');
toc;

time = time-time(1);

figure;
var(data)
plot(data);
% a = 0.95;
% filtered = filter([1, -a], 1, data);
% plot(filtered);
fclose(s);

dd = [time data];
save(filename, 'dd', '-ascii');