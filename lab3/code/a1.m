ym=10;  %Set the range of y direction in the field domain
zm=10; %Set the range of z direction in the field domain
y=linspace(-ym,ym,100); % Equally divide y axis into 100 parts
z=linspace(-zm,zm,100); % Equally divide z axis into 100 parts

a=2; %Input the radius of the current loop
I=500; %Input the current value in the current loop
C=I/(4*pi);     %Merge the constants
N=50;         %Se t the number of division

theta0=linspace(0,2*pi,N+1);   %Division of the angle of circumference
theta1=theta0(1:N);
x1=a*cos(theta1); y1=a*sin(theta1);  %The start point coordinate of each segment of the loop
theta2=theta0(2:N+1);
x2=a*cos(theta2); y2=a*sin(theta2);  %The ending point coordinate of each segment of the loop

zc=1; xc=(x2+x1)./2; yc=(y2+y1)./2; %Calculate the 3 coordinate components of the midpoint
% of each segment of the loop.
dlz=0;dlx=x2-x1;dly=y2-y1;    %Calculate the 3 length components of each segment vector dl.

NGx=100; NGy=100;   %Grid dimension
Hy=zeros(100);Hz=zeros(100);H=zeros(100);         %Construct the H matrix

%% first coil
for i=1:NGy         %Loop computation of the value of H(x,y) in each grid
    for j=1:NGx
        rx=0-xc; ry=y(j)-yc; rz=z(i)-zc; %Calculate the 3 length components of the radius vector r,
        % and r is in the z = 0 plane.
        r3=sqrt(rx.^2+ry.^2+rz.^2).^3;      %Calculate r cube (r3)
        dlXr_y=dlz.*rx-dlx.*rz;       %Calculate the y, z components of the cross product dl×r,
        %x component is 0.
        dlXr_z=dlx.*ry-dly.*rx;
        Hy(i,j)=sum(C.*dlXr_y./r3);       %Accumulate the magnetic field intensity created
        %by each segment of the loop.
        Hz(i,j)=sum(C.*dlXr_z./r3);
        H=(Hy.^2+Hz.^2).^0.5;           %Calculate the magnitude of H
    end
end

%% add the mag field of the second coil
zc2 = -1;
Hy2=zeros(100);Hz2=zeros(100);H2=zeros(100);
for i=1:NGy         %Loop computation of the value of H(x,y) in each grid
    for j=1:NGx
        rx=0-xc; ry=y(j)-yc; rz=z(i)-zc2; %Calculate the 3 length components of the radius vector r,
        % and r is in the z = 0 plane.
        r3=sqrt(rx.^2+ry.^2+rz.^2).^3;      %Calculate r cube (r3)
        dlXr_y=dlz.*rx-dlx.*rz;       %Calculate the y, z components of the cross product dl×r,
        %x component is 0.
        dlXr_z=dlx.*ry-dly.*rx;
        Hy2(i,j)=sum(C.*dlXr_y./r3);       %Accumulate the magnetic field intensity created
        %by each segment of the loop.
        Hz2(i,j)=sum(C.*dlXr_z./r3);
        H2=(Hy2.^2+Hz2.^2).^0.5;           %Calculate the magnitude of H
    end
end
Hy = Hy + Hy2;
Hz = Hz + Hz2;
H = H + H2;

%% plot1
figure1 = figure; %define figure
h = quiver(y,z,Hy,Hz,'autoscalefactor',1.25);       %Plot the vector graph of the magnetic field intensity
set(h,'linewidth',1.2)
hold on;
rectangle('Position',[-2 -1 4 2]);
title({'the plot of magnetic field intensity vector distribution';'(represented by arrows) 樊青远11812418'}, 'fontsize',14);
pbaspect([1 1 1]);
axis([-3,3,-3,3]);
plot(2,1,'ro',-2,1,'bo'),      %Standard coil section
plot(2,-1,'ro',-2,-1,'bo'),      %Standard coil section
xlabel('y/m','fontsize',12),ylabel('z/m','fontsize',12),      %Label the axis
set(gcf,'Position',[10 10 500 500]);
saveas(figure1,'../fig/A1.jpg');

%% plot2
figure1 = figure; %define figure
surf(y,z,H);%Plot the graph of magnetic field intensity
shading interp; %disable the grid
colormap default; %set the colour map
hold on;
title({'the plot of magnetic field intensity magnitude distribution';'樊青远11812418'}, 'fontsize',12);
pbaspect([1 1 1]);
axis([-3,3,-3,3,0,1000])
xlabel('y/m','fontsize',12),ylabel('z/m','fontsize',12),zlabel('H','fontsize',12);
colorbar;
set(gcf,'Position',[10 10 500 500]);
saveas(figure1,'../fig/A2.jpg');

%% plot3
figure1 = figure; %define figure
theta=[0 50 60 70 80 90 100 110 120 130 180 230 240 250 260 270 280 290 300 310].*pi/180;   %Set the radian value of the streamlines
ys=2.2*cos(theta);        %Set the streamline starting circle’s y coordinate
zs=2.2*sin(theta);         %Set the streamline starting circle’s z coordinate
streamline(y,z,Hy,Hz,ys,zs); %Outwardly plot the magnetic line of force from the starting circle.
streamline(y,z,-Hy,-Hz,ys,zs); %Inwardly plot the magnetic line of force from the starting circle.
rectangle('Position',[-2 -1 4 2]);
xlabel('y/m','fontsize',12),ylabel('z/m','fontsize',12);
title({'the plot of magnetic line';'樊青远11812418'}, 'fontsize',14);
axis([-5,5,-5,5]);
pbaspect([1 1 1]);
set(gcf,'Position',[10 10 500 500]);
saveas(figure1,'../fig/A3.jpg');


