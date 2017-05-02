a = arduino('com3', 'uno');
% com number need to be confirmed every time connected to arduino
% the data
     nt=5; % <- traces
     np=100; % <- data/trace
% prepare the plot
     axes('xlim',[1,np],'ylim',[0,5]);
     x=1:np;
     value=-inf*ones(size(x));  %value is inf from 1:100
lh=line(x,value,...
            'marker','.',...
            'markersize',5,...
            'linestyle','none');
lb=line([inf,inf],[0,5]);
cmap=jet(nt);
shg;
for i = 1:nt*np    
    ix=rem(i-1,np)+1;  
    value(ix) = readVoltage(a, 'A0') ;
    %y(ix)=.5*fix(i/np)+rand; % <- new datas
    set(lh,'xdata' ,x,'ydata', value);
    set(lb, 'xdata',[ix, ix]);
    %set(lh,'xdata',x,'ydata',value);
    %set(lb,'xdata',[ix,ix]);
    pause(.0001); 
end