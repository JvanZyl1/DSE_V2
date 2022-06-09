clear all
close all
clc

TcgCatia = [1 0 0;
    0 -1 0;
    0 0 -1];

I_xx	= 411.61; %kgm^2
I_xy	= 1.15676;
I_xz	= 33.1961;
I_yx	= 0;
I_yy	= 1090.74;
I_yz	= -0.287697;
I_zx	= 0;
I_zy	= 0;
I_zz	= 1251.05;

Inertia = [I_xx I_xy I_xz;
    I_yx I_yy I_yz;
    I_zx I_zy I_zz];
I_mat = TcgCatia*Inertia;
I_inv = inv(I_mat);

A_2 = zeros(3);
B_2 = I_inv;
C_2 = eye(3);
D_2 = zeros(3);