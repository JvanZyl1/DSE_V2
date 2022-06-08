clear all
close all
clc

h = 0.1; % Height of prop
h_mass_prop = 0.5; %Where the prop_cg is placed in relation to prop height
theta_0 = [0; 0; 0]; %Initial angle
theta_final = [pi; 0; 0]; %Final angle
w_0 = [0;0;0];
I_mat = [0.0841557 0 0 ;
    0 0.0841557 0;
    0 0 0.904730357];
I_diag = diag(I_mat);
I_inv = inv(I_mat);
I_inv = diag(I_mat);
I_mat = I_diag;
w_s_0 = 3500*2*pi/2;
w_p_dot = 0;
w_s_dot = 0;
psI_dot = 0;
psI_0 = 0;



T_prop = 1;
w_p_0 = 90*pi/(180*T_prop);
sim('prop_tilt_gyro_model_1',T_prop);
plot(ans.sim3)
title("Torque vectoring moments:" + T_prop + "seconds to rotate 90 degrees.")
xlabel("Time [s]")
ylabel("Torque [Nm]")

