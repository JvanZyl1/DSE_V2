clear all
close all
clc

I_xx = 1.2;
I_yy = 1.0;
I_zz = 0.5;

Inertia = [I_xx 0 0;
    0 I_yy 0;
    0 0 I_zz];
I_mat = Inertia;
Inertia_inv = inv(Inertia);
I_inv = Inertia_inv;

theta_0 = [0;0;0];
w_0 = [0;0;0];
theta_z_f = pi;
q_0 = [1; 0; 0; 0];

m = 300;
rho = 1.225;
g = 9.81;
T = 10.5;
C_D = 0.6;
time_delay = 0.1;
S = 1*1.8;

%% Linear Dynamics Kalman Filter

A_kal = [0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];

B_kal = [0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 1/m 0 0;
    0 0 0 0 1/m 0;
    0 0 0 0 0 1/m];

C_kal = eye(6);

D_kal = zeros(6);

%% Angular dynamics Kalman filter

A_i = vertcat(zeros(3), zeros(3));
A_ii = vertcat(eye(3), zeros(3));
A_AD = horzcat(A_i, A_ii);

B_i = vertcat(zeros(3), zeros(3));
B_ii = vertcat(zeros(3), I_inv);
B_AD = horzcat(B_i, B_ii);

C_AD = eye(6);
D_AD = zeros(6);

sys = ss(A_AD, B_AD, C_AD, D_AD);



%A = eye(3);
%B = [1/m; 1/m; 1/m];
%C = eye(3);
%D = zeros(3);
%sys = ss(A,B,C,D);





