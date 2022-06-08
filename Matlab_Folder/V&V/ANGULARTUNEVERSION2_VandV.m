clear all
close all
clc




%% Generic inputs
I_xx = 3866.543;
I_yy = 16529.205;
I_zz = 17264.21;

Inertia = [I_xx 0 0;
    0 I_yy 0;
    0 0 I_zz];
I_mat = Inertia;
Inertia_inv = inv(Inertia);
I_inv = Inertia_inv;

%% PID tune of angular 
A_2 = zeros(3);
B_2 = I_inv;
C_2 = eye(3);
D_2 = zeros(3);

%% Initial integration constants
theta_0 = [0;0;0];
w_0 = [0;0;0];
r_0 = [0;0;0];
v_0 = [0;0;0];
a_0 = [0;0;0];


%% Values for drag model
m = 645;
rho = 1.225;
g = 9.81;
T = 10.5;
C_D = 0.6;
time_delay = 0.1;
S = 1*1.8;

%% Test inputs
v_vehicle = [20; 10; 0];
constant_v = 1;
sine_v = 0;
x_amp = 10;
y_amp = 15;
z_amp = 5;
x_freq = 1;
y_freq = 1;
z_freq = 1;
x_cp = [0.3; 0.2; 0.4];
theta_wanted = [pi/2; 0; 0];

%% Load MPC tuning
load('MPCDesignerSession.mat');

sim('AD_Terry_VV', 100.0)

