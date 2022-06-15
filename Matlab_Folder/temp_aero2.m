clear all
close all
clc
%% C_X
%{
P = [0, 0, -1.32;
    0, 90, 0.29;
    0, 45, -1.15;
    0, 135, 1.29;
    0, 180, 1.29;
    15, 0, -1.33;
    -15, 0, -1.48;
    15, 90, 0.3;
    30, 90, 0.32;
    -15, 90, 0.32;
    90, 0,0.136;
    -90, 0, -0.214];

%% C_Y

P = [0, 0, 0;
    0, 90, 2.7;
    0, 45, 1.95;
    0, 135, 2.19;
    0, 180, 0;
    15, 0, 0;
    -15, 0, 0;
    15, 90, 2.85;
    30, 90, 2.76;
    -15, 90, 2.69
    90, 0,0;
    -90, 0, 0];
%}
%% Generate C_Z values
P = [0, 0, -0.23;
    0, 90, -0.65;
    0, 45, -0.68;
    0, 135, -1.04;
    0, 180, 0.2;
    15, 0, 0.55;
    -15, 0, -1.23;
    15, 90, 0.51;
    30, 90, 1.45;
    -15, 90, -1.4
    90 , 0, 3.48;
    -90, 0, -3.12];

x = P(:,1) ; y = P(:,2) ; z = P(:,3) ;
x1 = x; y1 = y; z1 = z;
%x = [abs(x); -abs(x); abs(x); -abs(x)];
%y = [abs(y); abs(y); -abs(y); -abs(y)];
%z = [z; z; z; z];

x = [abs(x); abs(x)];
y = [abs(y); -abs(y)];
z = [z; z];

ti = -90:1:90;
tiy = -180:1:180;
[XI, YI] = meshgrid(ti,tiy);
model = scatteredInterpolant(x, y, z, 'linear', 'linear');
ZI = model(XI, YI);
fig1 = figure(1)
surf(XI,YI,ZI); shading interp; hold on
plot3(x1,y1,z1,'ro'); hold on
% plot3(-x, y, z, 'ro') 
% plot3(x, -y, z, 'ro')
% plot3(-x, -y, z, 'ro')
colorbar
hold off
zlabel('$C_X$ [$~$]', 'Interpreter','Latex');
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex');
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex');