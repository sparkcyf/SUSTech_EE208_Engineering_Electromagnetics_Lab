clear all 
                  
m=0.02;                                                                %Set the mass；
q=1.6e-2;                                                              %Set the quantity of charge；

dt=0.001;                                                              %Set the timestep to be 0.001s；
t=0:dt:100;                                                            %Construct the array of time；

vx=linspace(0,0,length(t));vy=vx;vz=vx;            %Construct the velocity vector；
vx(1)=5;                                                               %Set the velocity vector’s initial value.
rx=linspace(0,0,length(t));ry=rx;rz=rx;               %Set the position vector；
Ex=0; Ey=1; Ez=0;                                              %Set the electric field vector；
Bx=0; By=1; Bz=0;                                             %Set the magnetic flux density vector；
Fx=linspace(0,0,length(t));Fy=Fx;Fz=Fx;           %Construct the force vector；
ax=linspace(0,0,length(t));ay=ax;az=ax;             %Construct the acceleration vector；

for i=1:(length(t)-1)                                             % Calculate each position point
   Fx(i)=q*Ex+q*(vy(i)*Bz-vz(i)*By);               % Calculate the acted force at position i
 Fy(i)=q*Ey+q*(vz(i)*Bx-vx(i)*Bz);               % Calculate the acted force at position i
 Fz(i)=q*Ez+q*(vx(i)*By-vy(i)*Bx);               % Calculate the acted force at position i

 ax(i)=Fx(i)/m;                                                  % Calculate the acceleration at position i
 ay(i)=Fy(i)/m;                                                  % Calculate the acceleration at position i
 az(i)=Fz(i)/m;                                                   % Calculate the acceleration at position i

 vx(i+1)=vx(i)+ax(i)*dt;                                   % Calculate the velocity at position i+1
 vy(i+1)=vy(i)+ay(i)*dt;                                   % Calculate the velocity at position i+1
 vz(i+1)=vz(i)+az(i)*dt;                                    % Calculate the velocity at position i+1

 rx(i+1)=rx(i)+vx(i)*dt;                                    % Calculate the position at point i+1
 ry(i+1)=ry(i)+vy(i)*dt;                                    % Calculate the position at point i+1
 rz(i+1)=rz(i)+vz(i)*dt;                                     % Calculate the position at point i+1
end
figure
 plot3(rx,ry,rz);  
hold on
grid;
title('带电粒子在电磁场中的运动轨迹');          % Set the graph’s title
xlabel('X轴', 'fontsize', 12);                                 % Label x axis
ylabel('Y轴', 'fontsize', 12);                                 % Label y axis
zlabel('Z轴', 'fontsize', 12);                                  % Label z axis
