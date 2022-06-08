clear all
close all
clc

I_xx = 1;
I_xy = 2;
I_xz = 1;
I_yx = 2;
I_yy = 1;
I_yz = 2;
I_zx = 3;
I_zy = 4;
I_zz = 2;

I_mat = [I_xx I_xy I_xz;
    I_yx I_yy I_yz;
    I_zx I_zy I_zz];

wx_l = [];
wy_l = [];
wz_l = [];
Kp_x = [];
Ki_x = [];
Kd_x = [];
Kp_y = [];
Ki_y = [];
Kd_y = [];
Kp_z = [];
Ki_z = [];
Kd_z = [];
for wx = 0:0.1:pi
    for wy = 0:0.1:pi
        for wz = 0:0.1:pi
            [pid_Mx, pid_My, pid_Mz] = angular_tune(wx,wy,wz, I_mat);
            wx_l = [wx_l; wx];
            wy_l = [wy_l; wy];
            wz_l = [wz_l; wz];
            Kp_x = [Kp_x; pid_Mx(1)];
            Ki_x = [Ki_x; pid_Mx(2)];
            Kd_x = [Kd_x; pid_Mx(3)];
            Kp_y = [Kp_y; pid_My(1)];
            Ki_y = [Ki_y; pid_My(2)];
            Kd_y = [Kd_y; pid_My(3)];
            Kp_z = [Kp_z; pid_Mz(1)];
            Ki_z = [Ki_z; pid_Mz(2)];
            Kd_z = [Kd_z; pid_Mz(3)];
        end
    end
end
% Option 1 use to generate lookup table
% Option 2 use in loop to output new gains
% Option 3 use for primary gain tuning
% Option 4 use in a neural network training scenairo;