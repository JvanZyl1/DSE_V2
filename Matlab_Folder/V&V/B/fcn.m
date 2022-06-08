function [Fx_acc,Fy_acc, Fz_acc, Mx_acc, My_acc, Mz_acc] = fcn(Fc, Ft, Fb)

%% Load propeller arms data
xc_1 = 0.1;
yc_1 = 0;
zc_1 = 0.3;
xc_2 = 0.1;
yc_2 = 0;
zc_2 = 0.32;
xc_3 = 0.11;
yc_3 = 0;
zc_3 = 0.31;

xt_1 = 0.2;
yt_1 = 0.2;
zt_1 = 1;
xt_2 = 0.2;
yt_2 = 0.2;
zt_2 = 1;
xt_3 = 0.2;
yt_3 = 0.2;
zt_3 = 1;
xt_4 = 0.2;
yt_4 = 0.2;
zt_4 = 1;

xb_1 = 0.4;
yb_1 = 0.3;
zb_1 = 1.2;
xb_2 = 0.4;
yb_2 = 0.3;
zb_2 = 1.2;
xb_3 = 0.4;
yb_3 = 0.3;
zb_3 = 1.2;
xb_4 = 0.4;
yb_4 = 0.3;
zb_4 = 1.2;


%% Split vectors
Fx_acc = 0;

A_control = [1 1 1;
    zc_1 -zc_2 -zc_3;
    -xc_1 -xc_2 xc_3];
ab_control = A_control*Fc;
Fy_acc = ab_control(1);
Mx_acc = ab_control(2);
Mz_acc = ab_control(3);

A_tb = [-1 -1;
    2*(xt_1 + xb_1) -2*(xt_3 + xb_3)];
F_front = Ft(1) + Ft(2) + Fb(1) + Fb(2);
F_back = Ft(3) + Ft(4) + Fb(3) + Fb(4);
Ftb_vec = [F_front; F_back];
Ab_tb = A_tb*Ftb_vec;

Fz_acc = Ab_tb(1);
My_acc = Ab_tb(2);

end