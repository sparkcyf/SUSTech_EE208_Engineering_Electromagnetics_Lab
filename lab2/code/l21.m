tic;
clear;% clear all variables in memory
clc;% Clear the contents of the command window
%% define
k=9e9; % set electrostatic constant
xm=3;% Set the range of the field in x direction
ym=3;% Set the range of the field in y direction
segments=100; %set the segment
EF_density=10e-9;
L_length=2;
tiles=100;
Q=(L_length/segments)*EF_density;

x=linspace(-xm,xm,tiles);% evenly divide the x axis into 100 segments
y=linspace(-ym,ym,tiles);% evenly divide the y axis into 100 segments
[X,Y]=meshgrid(x,y);  % To form the coordinates of each point in the field.
sumV=zeros(tiles,tiles);
xcl = linspace(-xm,xm,tiles);
ycl = linspace(-xm,xm,tiles);

for xc = 1:tiles
    for yc = 1:tiles
% calculate the electric potential point by point
        sumV(yc,xc) = k*EF_density*log((1-x(xc)+sqrt((1-x(xc)).^2+y(yc).^2))./(-1-x(xc)+sqrt((-1-x(xc)).^2+ycl(yc).^2)));
    end
end
toc;

%% part1

figure1 = figure;%define figure
surf(X,Y,sumV);
shading interp; %disable the grid
colormap default; %set the colour map
hold on;
title({'the plot of electric potential distribution of the line charges in the vacuum';'(integration method) 樊青远11812418'}, 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
zlabel('Electric Potential (unit: V/m)','fontsize',12); %label the z axis
colorbar;
saveas(figure1,'../fig/A1.jpg');

%% part2

Tmax=max(max(sumV)); %find the maximum potential value
Tmin=min(min(sumV)); %find the maximum potential value
Vmin=20; % set the minimum potential value for a family of equipotential lines
Vmax=600; % set the maxmium potential value for a family of equipotential lines
Veq=linspace(Vmin,Vmax,20); % set the potential for 10 equipotential lines
figure1 = figure;%define figure
contour(X,Y,sumV,Veq);  % plot 10 equipotential lines
grid on;  % form a grid  % hold the plot
hold on;
plot(0,0,'o', 'MarkerSize',12) % plot a charge at the origin
title({'Isopotential Line of the Line Charge Electric Field in Vacuum (integration method) (Unit: V)';'樊青远11812418'}, 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
colorbar;
hold off;
saveas(figure1,'../fig/A2.jpg');

%% part3
[Ex,Ey]=gradient(-sumV); % Calculation of two components of Electric Field intensity at each Point in the Field
del_theta=10; % Set the angle difference between adjacent field lines;
theta=(0:del_theta:360).*pi/180; % express the angle into radian
% difine the start of the electric field line
x1=-1;
y1=0;
x2=1;
y2=0;
xs = -1.2:0.15:1.2;
L = length(xs);
ys = 0.15 .* ones(L,1);
xs2 = -1.2:0.2:1.2;
L = length(xs2);
ys2 = -0.15 .* ones(L,1);

figure1 = figure;%define figure
hold on   % hold the plot
grid on;
contourf(X,Y,sumV,Veq);   % plot 100 equipotential lines
h=streamline(X,Y,Ex,Ey,xs,ys); % generate the field lines?
set(h,'linewidth',2,'color',[1 1 1]);
h=streamline(X,Y,Ex,Ey,xs2,ys2); % generate the field lines?
set(h,'linewidth',2,'color',[1 1 1]);

plot(0,0,'o', 'MarkerSize',12) % plot the point charge at the origin
title({' Isopotential Line and Power Line of the Line Charge Electric Field in vacuum';...
    '(integration method) Unit: V';'樊青远11812418'} , 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
colorbar;
%xlim([-0.03 0.03]); % set the limit of axis
%ylim([-0.03 0.03]); % set the limit of axis
saveas(figure1,'../fig/A3.jpg');

%% part4
E=sqrt(Ex.^2+Ey.^2); % calculate the magnitude of electric field magnitude at each point.
Ex=Ex./E;
Ey=Ey./E;   % normalize the magnitude of the electric field
figure1 = figure;%define figure
hold on
index1 = 5 : 5 : 95;
index2 = index1;
p1 = X(index1, index2); p2 = Y(index1, index2);
% scaling of electric field lines: unit length
p3 = Ex(index1, index2)./(E(index1,index2));
p4 = Ey(index1, index2)./(E(index1,index2));
% no scaling of electric field lines
%  p3 = Ex(index1, index2); p4 = Ey(index1, index2);
contourf(X,Y,sumV,Veq);% plot the equipotential lines
h = quiver(p1,p2,p3,p4,'autoscalefactor',0.5);
set(h,'color',[1 1 1],'linewidth',1.2)

pbaspect([1 1 1]);
title({'Equipotential lines and electric field lines of'; 'the Line Charge Electric Field in vacuum';...
    '(integration method) Unit: V';'樊青远11812418'} , 'fontsize',12);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
colorbar; %enable colour bar
saveas(figure1,'../fig/A4.jpg');

%% Saving MAT
sumV_integration = sumV;
save('../var/sumV_integration.mat','sumV_integration');


