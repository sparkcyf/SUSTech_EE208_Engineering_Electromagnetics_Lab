clear;% clear all variables in memory
clc; % Clear the contents of the command window
k=9e9;  % set electrostatic constant
Q=8e-9;   % Set charge Q
xm=3; % Set the range of the field in x direction
ym=3;  % Set the range of the field in y direction
%% Define
x=linspace(-xm,xm,100);  % evenly divide the x axis                                          
y=linspace(-ym+0.5,ym+0.5,40);  % evenly divide the y axis 
[X,Y]=meshgrid(x,y);  % To form the coordinates of each point in the field. 
x1=-sqrt(3); %define the coordinate of the charges
y1=-1;
x2=sqrt(3);
y2=-1;
x3=0;
y3=2;
R1=sqrt((X-x1).^2+(Y-y1).^2);% calculate the distance between each point and the source charge (the origin).
R2=sqrt((X-x2).^2+(Y-y2).^2);
R3=sqrt((X-x3).^2+(Y-y3).^2);
V1=k*Q./R1;  %define the potential influenced by each charge
V2=k*Q./R2;  
V3=k*Q./R3; 

%% Part 1

sumV = V1+V2+V3;

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
saveas(figure1,'../fig/C1.jpg');

%% part2

Tmax=max(max(sumV)); %find the maximum potential value
Tmin=min(min(sumV)); %find the maximum potential value
Vmin=-2000; % set the minimum potential value for a family of equipotential lines
Vmax=2000; % set the maxmium potential value for a family of equipotential lines
Veq=linspace(Vmin,Vmax,500); % set the potential for equipotential lines
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
saveas(figure1,'../fig/C2.jpg');


%% part3
[Ex,Ey]=gradient(-sumV); % Calculation of two components of Electric Field intensity at each Point in the Field
del_theta=5; % Set the angle difference between adjacent field lines;
theta=(0:del_theta:360).*pi/180; % express the angle into radian
xs=x1+0.4*cos(theta); % generate the x coordinate for the start of the field line of charge1
ys=y1+0.4*sin(theta); % generate the y coordinate for the start of the field line of charge1
xs2=x2+0.4*cos(theta); % generate the x coordinate for the start of the field line of charge2
ys2=y2+0.4*sin(theta); % generate the y coordinate for the start of the field line of charge2
xs3=x3+0.4*cos(theta); % generate the x coordinate for the start of the field line of charge3
ys3=y3+0.4*sin(theta); % generate the y coordinate for the start of the field line of charge3
figure1 = figure;%define figure
hold on
streamline(X,Y,Ex,Ey,xs,ys) % generate the field lines?
streamline(X,Y,Ex,Ey,xs2,ys2) % generate the field lines?
streamline(X,Y,Ex,Ey,xs3,ys3) % generate the field lines?
grid on % from the grid
   % hold the plot
contour(X,Y,sumV,Veq);   % plot 100 equipotential lines
plot(0,0,'o', 'MarkerSize',12) % plot the point charge at the origin
title({'Isopotential Line and Power Line of two identical point charges Electric Field in vacuum';...
    'Unit: V';'樊青远11812418'} , 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
colorbar;
%xlim([-0.03 0.03]); % set the limit of axis
%ylim([-0.03 0.03]); % set the limit of axis
saveas(figure1,'../fig/C3.jpg');

%% optimize the mesh of arrows
x_arr=linspace(-xm,xm,20);% evenly divide the x axis into 100 segments
y_arr=linspace(-xm+0.5,xm+0.5,20);% evenly divide the y axis into 100 segments
[X_arr,Y_arr]=meshgrid(x_arr,y_arr);  % To form the coordinates of each point in the field.
x1_arr=0.01; %define the location of the charges
x2_arr=2;
R1_arr=sqrt((X_arr-x1_arr).^2+Y_arr.^2); % calculate the distance between each point and the source charge (the origin).
R2_arr=sqrt((X_arr-x2).^2+Y_arr.^2);
V1_arr=k*Q./R1_arr; %calculate the electric potential
V2_arr=-k*Q./R2_arr;

sumV_arr = V1_arr+V2_arr; % plot the distribution of electric potential
[Ex_arr,Ey_arr]=gradient(-sumV_arr);

%% part4
E_arr=sqrt(Ex_arr.^2+Ey_arr.^2); % calculate the magnitude of electric field magnitude at each point.
Ex_arr=Ex_arr./E_arr;
Ey_arr=Ey_arr./E_arr;   % normalize the magnitude of the electric field
figure1 = figure;%define figure
q1 = quiver(X_arr,Y_arr,Ex_arr,Ey_arr,0);  % using normalized arrowhead to represent electric field
set(q1,'AutoScale','on', 'AutoScaleFactor', 0.5)
hold on;
contour(X,Y,sumV,Veq);% plot the equipotential lines
title({'Equipotential lines and electric field lines of'; 'two identical point charges electric field in vacuum';...
    'Unit: V';'樊青远11812418'} , 'fontsize',12);
pbaspect([1 1 1]);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
colorbar; %enable colour bar
%xlim([-0.03 0.03]); % set the limit of axis
%ylim([-0.03 0.03]); % set the limit of axis
saveas(figure1,'../fig/C4.jpg');

