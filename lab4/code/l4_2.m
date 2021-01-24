clear all; %clean the env;

m=0.02; %Set the mass；
q=1.6e-2; %Set the quantity of charge；

dt=0.001;  %Set the timestep to be 0.001s；
t=0:dt:3; %Construct the array of time；
vx = zeros(16,length(t));
vy = vx;
vz = vx; %Construct the velocity vector；
for c2 = 1:16
    vx(c2,1)=0.1*sin((c2-1)*pi/8); %assign the initial velocity of for every particle
    vy(c2,1)=0.1*cos((c2-1)*pi/8);
end
vz(:,1) = (zeros(16,1)+10);



%%
rx=linspace(0,0,length(t));ry=rx;rz=rx;               %Set the position vector；
Ex=0; Ey=0; Ez=0;                                              %Set the electric field vector；
Bx=0; By=0; Bz=8;                                             %Set the magnetic flux density vector；
Fx=linspace(0,0,length(t));Fy=Fx;Fz=Fx;           %Construct the force vector；
ax=linspace(0,0,length(t));ay=ax;az=ax;             %Construct the acceleration vector；

vx_rst=vx;
vy_rst=vy;
vz_rst=vz;
Fx_rst=Fx;
Fy_rst=Fy;
Fz_rst=Fz;
ax_rst=ax;
ay_rst=ay;
az_rst=az;
%%
figure
hold on;

for c1 = 1:16
vx = vx_rst;
vy = vy_rst;
vz = vz_rst;
Fx=Fx_rst;
Fy=Fy_rst;
Fz=Fz_rst;
ax=ax_rst;
ay=ay_rst;
az=az_rst;

    for c2=1:(length(t)-1) % Calculate each position point

        Fx(c2)=q*Ex+q*(vy(c1,c2)*Bz-vz(c1,c2)*By);% Calculate the acted force at position i
        Fy(c2)=q*Ey+q*(vz(c1,c2)*Bx-vx(c1,c2)*Bz);% Calculate the acted force at position i
        Fz(c2)=q*Ez+q*(vx(c1,c2)*By-vy(c1,c2)*Bx);% Calculate the acted force at position i
        
        ax(c2)=Fx(c2)/m;% Calculate the acceleration at position i
        ay(c2)=Fy(c2)/m;% Calculate the acceleration at position i
        az(c2)=Fz(c2)/m;% Calculate the acceleration at position i
        
        vx(c1,c2+1)=vx(c1,c2)+ax(c2)*dt;% Calculate the velocity at position i+1
        vy(c1,c2+1)=vy(c1,c2)+ay(c2)*dt;% Calculate the velocity at position i+1
        vz(c1,c2+1)=vz(c1,c2)+az(c2)*dt;% Calculate the velocity at position i+1
        
        rx(c2+1)=rx(c2)+vx(c1,c2)*dt;% Calculate the position at point i+1
        ry(c2+1)=ry(c2)+vy(c1,c2)*dt;% Calculate the position at point i+1
        rz(c2+1)=rz(c2)+vz(c1,c2)*dt;% Calculate the position at point i+1

    end
 plot3(rx,ry,rz);
end
grid;
title({'Charge’s movement trajectory in the electromagnetic field';'(single particle) 樊青远11812418'});          % Set the graph’s title
xlabel('X Axis', 'fontsize', 12);% Label x axis
ylabel('Y Axis', 'fontsize', 12);% Label y axis
zlabel('Z Axis', 'fontsize', 12);% Label z axis
pbaspect([1 1 1]);
