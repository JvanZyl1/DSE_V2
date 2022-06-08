clear all
close all
clc

Test = 4;

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

if Test == 1
    I_mat = 0;
    sim('prop_tilt_gyro_model_1',T_prop);
    error("Unit Test 1 passed")

elseif Test == 2
    I_mat = I_mat*0;
    I_inv = I_inv*0;
    sim('prop_tilt_gyro_model_1',T_prop);
    Bool = all(ans.sim3 == 0);
    if Bool ~= 1
        disp("Unit Test 2 Failed.")
    end

elseif Test == 3
    theta_final = [0;0;0];
    sim('prop_tilt_gyro_model_1',T_prop);
    Bool = all(ans.sim3 == 0);
    if Bool ~= 1
        disp("Unit Test 3 Failed.")
    end
elseif Test == 4
    T_prop = 0;
    sim('prop_tilt_gyro_model_1',T_prop);
    error("Unit Test 4 passed")
end
    
