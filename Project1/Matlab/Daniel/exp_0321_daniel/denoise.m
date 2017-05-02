clc; clear;

name = 'screw_driver_front';
raw = load(['data_', name, '.txt']);

amped = raw(:,1);
origin = raw(:,2);

% SR for Arduino: 10000 S/s (Max)
x = (1:length(amped))*0.015; % About 1 knock/s
figure;
subplot(5,1,1);
plot(x, amped);
title('Origin');
xlabel('Time(s)');
ylabel('Voltage(V)');

tptr = {'rigrsure', 'heursure', 'sqtwolog', 'minimaxi'};
for i=1:4
    lev = 1;
    amped_d = wden(amped, tptr{i}, 'h', 'one', lev, 'db3');
    
    subplot(5,1,i+1);
    plot(x, amped_d);
    title(tptr(i));
    xlabel('Time(s)');
    ylabel('Voltage(V)');
end