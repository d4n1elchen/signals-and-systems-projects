clc; clear;

name = {'screw_driver_front', 'screw_driver_handle', 'scissor_blade', 'scissor_handle', 'plastic_ruler'};
k = 4;
t = 0.0153;

raw = load(['data_', name{k}, '.txt']);

amped = raw(:,1);
origin = raw(:,2);

% SR for Arduino: 10000 S/s (Max)
x = (1:length(amped))*t; % About 1 knock/s
figure;
plot(x, origin, x, amped, '.');
xlabel('Time(s)');
ylabel('Voltage(V)');
