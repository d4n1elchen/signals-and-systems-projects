clc; clear;

name = {'screw_driver_front', 'screw_driver_handle', 'scissor_blade', 'scissor_handle', 'plastic_ruler'};
k = 4;
t = 0.0153;

raw = load(['data_', name{k}, '.txt']);

amped = raw(:,1);
origin = raw(:,2);

% SR for Arduino: 10000 S/s (Max)
x = (1:length(amped))*t; % About 1 knock/s

start = floor(3.5/t);
cut_sz = floor(1/t);

figure;
sp_origin = [];
for i=1:12
    sp_origin = [sp_origin, origin(start+(i-1)*cut_sz:start+i*cut_sz)];
    subplot(12,2,i);
    plot(sp_origin(:,i));
end

sp_amped = [];
for i=1:12
    sp_amped = [sp_amped, amped(start+(i-1)*cut_sz:start+i*cut_sz)];
    subplot(12,2,12+i);
    plot(sp_amped(:,i));
end

save(['splited_', name{k}, '.mat'], 'sp_origin', 'sp_amped');