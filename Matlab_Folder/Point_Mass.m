clear all
close all
clc

%%% Not used any more

m = 100; %kg
g = 9.81; %m/s
W = m*g; %N

Inertia = [0.9 0 0;
    0 0.08 0;
    0 0 0.08];
Inertia_inverse = inv(Inertia);
Inertia = diag(Inertia);
Inertia_inverse = diag(Inertia_inverse);

rho = 0.991;
C_D = 0.2;
S = 4.5;
