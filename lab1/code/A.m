clear;% clear all variables in memory
clc;% Clear the contents of the command window
%% define
k=9e9; % set electrostatic constant
Q=1e-9;% Set charge Q
xm=0.1;% Set the range of the field in x direction
ym=0.1;% Set the range of the field in y direction

x=linspace(-xm,xm,100);% evenly divide the x axis into 100 segments
y=linspace(-ym,ym,100);% evenly divide the y axis into 100 segments
[X,Y]=meshgrid(x,y);  % To form the coordinates of each point in the field.
x1=-0.01; %define the location of the charges
x2=0.01;
y1=0;
y2=0;
R1=sqrt((X-x1).^2+Y.^2); % calculate the distance between each point and the source charge (the origin).
R2=sqrt((X-x2).^2+Y.^2);
V1=k*Q./R1; %calculate the electric potential
V2=k*Q./R2;

%% part1
sumV = V1+V2; % plot the distribution of electric potential
figure1 = figure;%define figure
surf(X,Y,sumV);
shading interp; %disable the grid
colormap default; %set the colour map
hold on;
title({'the plot of electric potential distribution of two identical point charges in the vacuum';'樊青远11812418'}, 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
zlabel('Electric Potential (unit: V/m)','fontsize',12); %label the z axis
colorbar;
saveas(figure1,'../fig/A1.jpg');

%% part2

Tmax=max(max(sumV)); %find the maximum potential value
Tmin=min(min(sumV)); %find the maximum potential value
Vmin=200; % set the minimum potential value for a family of equipotential lines
Vmax=2000; % set the maxmium potential value for a family of equipotential lines
Veq=linspace(Vmin,Vmax,50); % set the potential for 10 equipotential lines
figure1 = figure;%define figure
contour(X,Y,sumV,Veq);  % plot 10 equipotential lines
grid on;  % form a grid  % hold the plot
hold on;
plot(0,0,'o', 'MarkerSize',12) % plot a charge at the origin
title({'Isopotential Line of two identical point charges Electric Field in vacuum (Unit: V)';'樊青远11812418'}, 'fontsize',12);
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
xs=x1+0.0001*cos(theta); % generate the x coordinate for the start of the field line for q1
ys=y1+0.0001*sin(theta); % generate the y coordinate for the start of the field line for q1
xs2=x2+0.0001*cos(theta); % generate the x coordinate for the start of the field line for q2
ys2=y2+0.0001*sin(theta); % generate the y coordinate for the start of the field line for q2
figure1 = figure;%define figure
hold on   % hold the plot
grid on;
streamline(X,Y,Ex,Ey,xs,ys) % generate the field lines?
streamline(X,Y,Ex,Ey,xs2,ys2) % generate the field lines?
contour(X,Y,sumV,Veq);   % plot 100 equipotential lines
plot(0,0,'o', 'MarkerSize',12) % plot the point charge at the origin
title({' Isopotential Line and Power Line of two identical point charges Electric Field in vacuum';...
    'Unit: V';'樊青远11812418'} , 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
colorbar;
xlim([-0.03 0.03]); % set the limit of axis
ylim([-0.03 0.03]); % set the limit of axis
saveas(figure1,'../fig/A3.jpg');

%% part4
E=sqrt(Ex.^2+Ey.^2); % calculate the magnitude of electric field magnitude at each point.
Ex=Ex./E;
Ey=Ey./E;   % normalize the magnitude of the electric field
figure1 = figure;%define figure
quiver(X,Y,Ex,Ey);  % using normalized arrowhead to represent electric field
hold on;
contour(X,Y,sumV,Veq);% plot the equipotential lines
title({'Equipotential lines and electric field lines of'; 'two identical point charges electric field in vacuum';...
    'Unit: V';'樊青远11812418'} , 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
colorbar; %enable colour bar
xlim([-0.03 0.03]); % set the limit of axis
ylim([-0.03 0.03]); % set the limit of axis
saveas(figure1,'../fig/A4.jpg');

