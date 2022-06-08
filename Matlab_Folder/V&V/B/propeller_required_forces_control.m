function [F_c, F_t, F_b] = propeller_required_forces_control(F_wanted, M_wanted)

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

%% Decompose force and moment input

F_x = F_wanted(1);
F_y = F_wanted(2);
F_z = F_wanted(3);

M_x = M_wanted(1);
M_y = M_wanted(2);
M_z = M_wanted(3);

%% Find control forces
A_control = [1 1 1;
    zc_1 -zc_2 -zc_3;
    -xc_1 -xc_2 xc_3];
A_cinv = inv(A_control);
force_control = [F_y; M_x; M_z];
controlvec = A_cinv*force_control;
F_c1 = controlvec(1);
F_c2 = controlvec(2);
F_c3 = controlvec(3);

%% Find top and bottom forces
A_tb = [-1 -1;
    2*(xt_1 + xb_1) -2*(xt_3 + xb_3)];
A_tbinv = inv(A_tb);
force_tb = [F_z; M_y];
tbvec = A_tbinv * force_tb;
f_front = tbvec(1);
F_t1 = f_front/4;
F_t2 = f_front/4;
F_b1 = f_front/4;
F_b2 = f_front/4;
f_back = tbvec(2);
F_t3 = f_back/4;
F_t4 = f_back/4;
F_b3 = f_back/4;
F_b4 = f_back/4;



%% Make matrix
F_c = [F_c1; F_c2; F_c3];
F_t = [F_t1; F_t2; F_t3; F_t4];
F_b = [F_b1; F_b2; F_b3; F_b4];

end
