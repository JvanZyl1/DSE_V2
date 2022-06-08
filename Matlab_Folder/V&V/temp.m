clear all
close all
clc


%% Unit Test's 0-3: 0 inputs
m = 600;
time_delay = 0.1;
g = 0.91;

F_aero = [1;2;3];
r_trajectory = [2;3;4];
a_accelerometer_error = [1;2;3];

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

