clear all
close all
clc


%% Initial conditions:
theta_0 = 20*pi/180;
phi_0 = 0;
psi_0 = 0;
theta_d_0 = 0.1;
phi_d_0 = 0.1;
psi_d_0 = 0;
theta_dd_0 = 0;
phi_dd_0 = 0;
psi_dd_0 = 0;

%% Inertia:
m = 6.5;
r = 0.2;
h = 0.4;
I_xx = 1/12*m*(3*r^2 + h^2);
I_xy = 0.0001;
I_xz = 0.0001;
I_yx = 0.0001;
I_yy = 1/12 * m*(3*r^2 + h^2);
I_yz = 0.0001;
I_zx = 0.0001;
I_zy = 0.0001;
I_zz = 1/12*m*r^2;

%% a,b,c ....:
% M_x derivs
a = I_xx;
b = I_xy*sin(theta_0) + I_xz*cos(theta_0);
c = I_xz;
d = I_xy*theta_d_0*cos(theta_0) - phi_d_0*sin(theta_0) + phi_d_0*sin(theta_0)*I_zx - phi_d_0*cos(theta_0)*I_yx;
e = I_xy*theta_d_0*cos(theta_0) - theta_d_0*sin(theta_0)*I_xz - theta_d_0*sin(theta_0)*I_zx - 2*phi_d_0*I_zy*(sin(theta_0))^2 - 2*phi_d_0*(cos(theta_0))^2*I_yz - psi_d_0*cos(theta_0)*I_yz;
f = phi_d_0*sin(theta_0)*I_zz - phi_d_0*cos(theta_0)*I_yz;
g = theta_dd_0*theta_d_0*cos(theta_0)*I_xy - phi_d_0*(theta_d_0)^2*sin(theta_0)*I_xy - phi_dd_0*theta_d_0*sin(theta_0)*I_xz - theta_d_0^2 * cos(theta_0)*I_xz + phi_d_0 * I_zx * theta_d_0 * cos(theta_0) + I_zy*phi_d_0^2*theta_d_0*sin(2*theta_0) + I_zz*phi_d_0 * theta_d_0 * cos(2*theta_0) + phi_d_0 * theta_d_0 * I_yx * sin(theta_0) - phi_d_0^2 * I_yy * theta_d_0 * cos(2*theta_0) + phi_d_0^2 * theta_d_0 * I_yz * sin(2*theta_0);
h = 1;

% M_y derivs
i = I_yx;
j = sin(theta_0)*I_yy + cos(theta_0)*I_yz;
k = I_xz;
l = phi_d_0*cos(theta_0)*I_yy - phi_d_0*sin(theta_0)*I_yz + phi_d_0*cos(theta_0)*theta_d_0*I_xx - 2*theta_d_0*I_xx - I_zy*phi_d_0*sin(theta_0) - I_zz*(phi_d_0*cos(theta_0) + psi_d_0);
m = theta_d_0*cos(theta_0)*I_yy - theta_d_0*sin(theta_0)*I_yz + I_xx*cos(theta_0)*theta_d_0 + 2*phi_d_0*I_xy*cos(theta_0)*sin(theta_0) + 2*phi_d_0*I_xz*(cos(theta_0))^2 - theta_d_0 * I_zy * sin(theta_0) - theta_d_0*cos(theta_0)*I_zz;
n = phi_d_0^2 *(cos(theta_0))^2 * I_xz - theta_d_0*I_zz;
o = phi_dd_0*cos(theta_0)*I_yy - phi_d_0*theta_d_0*sin(theta_0)*I_yy - phi_dd_0*sin(theta_0)*I_yz - phi_d_0*theta_d_0*cos(theta_0)*I_yz - phi_d_0*sin(theta_0)*theta_d_0*I_xx + theta_d_0*cos(2*theta_0) * phi_d_0^2 * I_xy - theta_d_0 * sin(2*theta_0) * phi_d_0^2 * I_xz - phi_d_0 * sin(theta_0)*psi_d_0 - theta_d_0^2 * phi_d_0^2 * cos(theta_0)*I_zy - theta_d_0^2*phi_d_0*sin(theta_0)*I_zz;
p = 1;

% M_z derivs
q = I_zx;
r = sin(theta_0)*I_zy + cos(theta_0)*I_zz;
s = I_zz;
z = phi_d_0*cos(theta_0)*I_zy - phi_d_0*sin(theta_0)*I_zz + 2*theta_d_0*I_yz + I_yy*phi_d_0*sin(theta_0) + I_yz*(phi_d_0*cos(theta_0) + psi_d_0) - phi_d_0*sin(theta_0)*I_xx;
t = theta_d_0*cos(theta_0)*I_zy - theta_d_0*sin(theta_0)*I_zz + I_yy*theta_d_0*sin(theta_0) + I_yz*cos(theta_0)*theta_d_0 - sin(theta_0)*I_xx*theta_d_0 - 2*phi_d_0*(sin(theta_0))^2*I_xy - 2*phi_d_0*cos(theta_0)*sin(theta_0)*I_xz - psi_d_0*sin(theta_0)*I_xz;
u = theta_d_0*I_yz - I_xz*phi_d_0*sin(theta_0);
w = phi_dd_0*theta_d_0*cos(theta_0)*I_zy - phi_d_0*theta_d_0^2*sin(theta_0)*I_zy - phi_dd_0*theta_d_0*sin(theta_0)*I_zz - phi_d_0*theta_d_0^2*cos(theta_0)*I_zz - phi_d_0*theta_d_0^2*I_xx*sin(theta_0) + theta_d_0*phi_d_0*I_xy*cos(2*theta_0) - I_xz*phi_d_0^2*theta_d_0*sin(2*theta_0) - phi_d_0*theta_d_0^2*cos(theta_0)*I_xx - theta_d_0 * phi_d_0^2 * sin(2*theta_0) * I_xy - theta_d_0 * phi_d_0 * I_xz * cos(2*theta_0) - phi_d_0 * theta_d_0 * cos(theta_0) * psi_d_0;
x = 1;

%% psidotdot funcs:
C_psi = [-c*q/a + b*(j - i*b/a)^(-1) * (i*c/a - k)*(-q/a) + r*(j- i*b/a)^(-1) * (i*c/a - k) + s]^(-1);
psi_theta_d = C_psi* (q/a*(d + b*(j - i*b/a)^(-1)*(i*d/a - l) - r*(j - i*b/a)^(-1) *(i*d/a - l) - z));
psi_phi_d = C_psi*(q*b/a * (j - i*b/a)^(-1) * (i*e/a - m) - r*(j-i*b/a)^(-1)*(i*e/a -m) - t);
psi_psi_d = C_psi*(q*f/a + q*b/a * (j- i*b/a)^(-1)*(i*f/a - n) - r*(j - i*b/a)^(-1)*(i*f/a - n) - u);
psi_theta = C_psi*q*g/a;
psi_phi = C_psi*(-r*(j - i*b/a)^(-1) * (i*g/a - o));
psi_psi = C_psi*(-w);
psi_Mx = C_psi*(-r*(j-i*b/a)^(-1) * (-i*h));
psi_My = C_psi*(-r*(j - i*b/a)^(-1) * (-p));
psi_Mz = C_psi*(-x);
%% phidotdot funcs:
C_phi = (j - i*b/a)^(-1);
phi_theta_d = C_phi*((i*d/a -l) + (i*c/a - k)*psi_theta_d);
phi_phi_d = C_phi*((i*e/a - m) + (i*c/a -k)*psi_phi_d);
phi_psi_d = C_phi*((i*f/a - n) + (i*c/a -k)*psi_psi_d);
phi_theta = C_phi*((i*c/a - k)*psi_theta);
phi_phi = C_phi*((i*g/a - o) + (i*c/a - k)*psi_phi);
phi_psi = C_phi*((i*c/a - k)*psi_psi);
phi_Mx = C_phi*(-i*h + (i*c/a -k)*psi_Mx);
phi_My = C_phi*(-p + (i*c/a - k)*psi_My);
phi_Mz = C_phi*((i*c/a - k)*psi_Mz);
%% thetadotdot funcs:
C_theta = -1/a;
theta_theta_d = C_theta*(b*phi_theta_d + c*psi_theta_d + d);
theta_phi_d = C_theta*(b*phi_phi_d + c*psi_phi_d + e);
theta_psi_d = C_theta*(b*phi_psi_d + c*psi_psi*d + f);
theta_theta = C_theta*(g + b*phi_theta + c*psi_theta);
theta_phi = C_theta*(b*phi_phi + c*psi_phi);
theta_psi = C_theta*(b*phi_psi + c*psi_psi);
theta_Mx = h + C_theta*(b*phi_Mx + c*psi_Mx);
theta_My = C_theta*(b*phi_My + c*psi_My);
theta_Mz = C_theta*(b*phi_Mz + c*psi_Mz);
%% A and B mat:
A = [0 1 0 0 0 0;
 theta_theta theta_theta_d theta_phi theta_phi_d theta_psi theta_psi_d;
 0 0 0 1 0 0;
 phi_theta phi_theta_d phi_phi phi_phi_d phi_psi phi_psi_d;
 0 0 0 0 0 1;
 psi_theta psi_theta_d psi_phi psi_phi_d psi_psi psi_psi_d];

B = [0 0 0 0 0 0;
    0 theta_Mx 0 theta_My 0 theta_Mz;
    0 0 0 0 0 0;
    0 phi_Mx 0 phi_My 0 phi_Mz;
    0 0 0 0 0 0;
    0 psi_Mx 0 psi_My 0 psi_Mz];

C = eye(6);

D = zeros(6);

sys = ss(A,B,C,D)

step(sys)

%% PID tune:
