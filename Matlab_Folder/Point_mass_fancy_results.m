clear all
close all
clc

noise_power = 0.000000001;

m = 600; %kg
g = 9.81; %m/s
W = m*g; %N

T = 10.5;
rho = 1.225;
C_D = 0.6;
time_delay = 0.3;%0.1;

S = 1*1.8;
kp = 155;
ki = 2.35133152512994;
kd = 596.091945881486;
sim('untitled1',30);
g_1 = out.g_force;
r_data_1 = out.r.data;
r_time_1 = out.r.time;
F_1 = out.F_control_minustau;

subplot(1,3,1)
plot(g_1)
yline(0)
title("Load factor under control maneuver.")
xlabel("Time [s]")
ylabel("g's")

subplot(1,3,2)
plot(r_data_1, r_time_1)
xline(0)
title("Deviation from trajectory under gust model.")
ylabel("Time [s]")
xlabel("Deviation [m]")

subplot(1,3,3)
plot(F_1)
yline(0)
title("Time-delayed control force.")
xlabel("Time [s]")
ylabel("Force [N]")
sgtitle("Gust control for, C_D:" + C_D + ", S:" + S + ", m:" + m + ", tau:" + time_delay)