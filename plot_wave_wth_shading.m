function h=plot_wave_wth_shading(data,xdim)

mn=mean(data,1);
sd=std(data,1);
dt=1000/32000;
y=[mn+sd, fliplr(mn-sd)];
x=[xdim, fliplr(xdim)];

figure;
hold on
h=fill(x,y,[1 0.8 0.8]);
set(h,'EdgeColor',[1 1 1]);
plot(xdim,mn, 'LineWidth', 2);
hold off