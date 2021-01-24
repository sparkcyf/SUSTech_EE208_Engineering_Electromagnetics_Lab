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

%define the func
EF_func = @(x,X0,Y0) k*(EF_density./sqrt((x-X0).^2+Y0.^2));

x=linspace(-xm,xm,tiles);% evenly divide the x axis into 100 segments
y=linspace(-ym,ym,tiles);% evenly divide the y axis into 100 segments
[X,Y]=meshgrid(x,y);  % To form the coordinates of each point in the field.

%% Load MAT
load ../var/sumV_infinitesimal.mat;
load ../var/sumV_integration.mat;

%% plot potential difference
h = imagesc(sumV_infinitesimal-sumV_integration);
set(h, 'XData', [-3, 3]);
set(h, 'YData', [-3, 3]);
xlim([-3 3]); % set the limit of axis
ylim([-3 3]); % set the limit of axis
pbaspect([1 1 1]);
colorbar; %enable colour bar
shading interp; %disable the grid
title({'potential difference between two method';...
    'Unit: V';'樊青远11812418'} , 'fontsize',12);
xlabel('X axis(unit: m)','fontsize',12);% label the x axis
ylabel('Y axis(unit: m)','fontsize',12);% label the y axis
saveas(h,'../fig/C1.jpg');

%% plot potential difference at y=0
V_infinitesimal_reszie = imresize(sumV_infinitesimal(50,:),[1,50]);
V_integration_reszie = imresize(sumV_integration(50,:),[1,50]);
xaxis=linspace(-xm,xm,50);
hold on;
plot(xaxis,V_infinitesimal_reszie);
plot(xaxis,V_integration_reszie);
plot(xaxis,abs(V_integration_reszie-V_infinitesimal_reszie));
legend('infinitesimal method','integration method','difference');
title({'potential difference between two method at X axis';...
    'Unit: V';'樊青远11812418'} , 'fontsize',12);

