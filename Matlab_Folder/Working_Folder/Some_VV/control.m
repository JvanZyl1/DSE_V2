clear all
close all
clc

%CATIA trans
TcgCatia = [1 0 0;
    0 -1 0;
    0 0 -1];

%Propeller arms - changed due to CATIA errors
c_1 = [-640.1998; 0; 506.566]*10^(-3);      %Control Back Top
c_2 = [-1040.1998; 0; -493.434]*10^(-3);    %Control Back Bottom
c_3 = [2259.8002; 0; -293.434]*10^(-3);     %Control Front

%Propeller arms - rotated
c_1 = TcgCatia*c_1;
c1 = transpose(c_1);
c_2 = TcgCatia*c_2;
c2 = transpose(c_2);
c_3 = TcgCatia*c_3;
c3 = transpose(c_3);

xc_1 = c1(1);
zc_1 = c1(3);

xc_2 = c2(1);
zc_2 = c2(3);

xc_3 = c3(1);
zc_3 = c3(3);

F_y = 100;
M_x = -10;
M_z = 25;

A_control = [1 1 1;
    zc_1 zc_2 zc_3;
    xc_1 xc_2 xc_3];
A_cinv = inv(A_control);
force_control = [F_y; M_x; M_z];
controlvec = A_cinv*force_control;
F_c1 = controlvec(1);
F_c2 = controlvec(2);
F_c3 = controlvec(3);

Control_forces = [F_c1; F_c2; F_c3];

A_control = [1 1 1;
        zc_1 zc_2 zc_3;
        xc_1 xc_2 xc_3]; 
Control_vec_2 = A_control*Control_forces;
F_y = Control_vec_2(1);
M_x = Control_vec_2(2);
M_z = Control_vec_2(3);