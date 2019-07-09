function h=plot_2waves_wth_shading(mn1, mn2, se1, se2, time)

chk=size(mn1);
if chk(1)>chk(2)
    mn1=mn1'
end

chk=size(mn2);
if chk(1)>chk(2)
    mn2=mn2'
end

chk=size(se1);
if chk(1)>chk(2)
    se1=se1'
end

chk=size(se2);
if chk(1)>chk(2)
    se2=se2'
end

chk=size(time);
if chk(1)>chk(2)
    time=time'
end

xdat=[time, fliplr(time)];
ydat1=[mn1+se1, fliplr(mn1-se1)];
ydat2=[mn2+se2, fliplr(mn2-se2)];

hold on
h=fill(xdat,ydat1,[1 0.8 0.8]);alpha(0.5);
set(h,'EdgeColor',[1 1 1]);
plot(time,mn1,'Color',[1 0 0], 'LineWidth',2);
h=fill(xdat,ydat2,[0.8 0.8 1]);alpha(0.5);
plot(time,mn2,'Color',[0 0 1],'LineWidth',2);
set(h,'EdgeColor',[1 1 1]);
hold off