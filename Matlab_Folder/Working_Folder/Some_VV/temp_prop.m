clear all
close all
clc

F_z = 100;
M_y = -200;
z = 90;

xt_1 = 1.2598;
xb_1 = 2.2598;
xt_3 = -1.3402;

A_mat = [1 1;
    xt_1 xb_1];

A_inv = inv(A_mat);

B = [(F_z - 4*z); (M_y - 4*z*xt_3)];

force = (A_inv*B)
kkk =sum(force);

back = A_mat*force;
backtrack = [4*z; 4*z*xt_3];
forceback = back+backtrack