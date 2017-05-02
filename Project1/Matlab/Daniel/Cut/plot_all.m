clc; clear;

name = {'acrylic', 'al_ruler', 'spoon'};

for k=1:3
    for i=1:3
        data = load(['ironcup_', name{k}, '_', num2str(i), '.txt']);
        time = data(:,1)-data(1,1);
        origin = data(:,2);
        offset = median(origin(1:500));
        origin = origin-offset;
        subplot(9,1,3*(k-1)+i);
        plot(origin);
        title(['ironcup_', name{k}, '_', num2str(i)],'Interpreter','none');
    end
end