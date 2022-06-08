clear all
close all
clc


noise_power = 0.000000001;

m = 640; %kg
g = 9.81; %m/s
W = m*g; %N

T = 10.5;
rho = 1.225;
C_D = 0.6;
%S = 1*1.8;
S = 2.9*1;
time_delay = 0.3;%0.1;

rlist = [];
F_control_minus_tau = [];
g_force = [];
S_list = [];
C_D_list = [];
t_d_list = [];
%{
for S = 3:4
    S
    for C_D = 1:
        C_D = C_D/10;
        for time_delay = 1:2
            time_delay = time_delay/10
            t_d_list = [t_d_list, time_delay];
            C_D_list = [C_D_list, C_D];
            S_list = [S_list, S];
            sim('untitled1',30);
            rlist = [rlist, ans.r];
            F_control_minus_tau = [F_control_minus_tau, ans.F_control_minustau];
            g_force = [g_force, ans.g_force];
        end
    end
end
%}

rlist1 = [];
F_control_minus_tau1 = [];
g_force1 = [];
t_delay = [];
for time_delay = 10:5:15
    S = 4;
    C_D = 0.2;
    time_delay = time_delay/100;
    t_delay = [t_delay, time_delay];
    sim('untitled1',30);
    rlist1 = [rlist1, ans.r];
    F_control_minus_tau1 = [F_control_minus_tau1, ans.F_control_minustau];
    g_force1 = [g_force1, ans.g_force];
end

%{
S = 2;
for C_D = 1:2
    C_D = C_D/10;
    for time_delay = 1:2
        time_delay = time_delay/10;
        S_list = [S_list, S];
        t_d_list = [t_d_list, time_delay];
        C_D_list = [C_D_list, C_D];
        sim('untitled1',30);
        rlist = [rlist, ans.r];
        F_control_minus_tau = [F_control_minus_tau, ans.F_control_minustau];
        g_force = [g_force, ans.g_force];
    end
end
%}