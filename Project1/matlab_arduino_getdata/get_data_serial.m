clc; clear;

s = serial('COM3');
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'BaudRate',115200);
set(s,'Parity','none');
fopen(s);
pause(1);

frameSize = 500;
data = [];
L = 0;

tic;
flushinput(s);
fwrite(s,'1');
flushoutput(s);
pause(1);
while L < frameSize
    d = fscanf(s,'# %f %f\n');
    disp(d);
    data = [data d(2)-3.115];
    L = L+1;
end
fwrite(s,'0');
flushoutput(s);
toc;

var(data)
plot(data);
fclose(s);