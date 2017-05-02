frameSize = 500;
data = [];
L = 0;

tic;
while L < frameSize
    data = [data a.readVoltage('A0')-3.115];
    L = L+1;
end
toc;

var(data)
plot(data);