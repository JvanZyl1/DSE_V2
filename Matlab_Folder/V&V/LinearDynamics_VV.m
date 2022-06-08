clear all
close all
clc


%% Unit Test's 0-3: 0 inputs
m = 600;
time_delay = 0.1;
g = 0.91;

F_aero = [1;2;3];
r_trajectory = [2;3;4];
a_accelerometer_error = [1;2;3];


i = 14;
if i == 1
    %Unit Test 1 : mass equal to 0
    m = 0;
    error("Unit Test 1 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 2
    %Unit Test 2 : time_delay equal to 0
    time_delay = 0;
    error("Unit Test 2 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 3
    %Unit Test 3 : g equal to 0
    g = 0;
    error("Unit Test 3 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 4
    %Unit Test 4 : no mass
    clear m
    error("Unit Test 4 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 5
    %Unit Test 5 : no time_delay
    clear time_delay
    error("Unit Test 5 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 6
    %Unit Test 6 : no g
    clear g
    error("Unit Test 6 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 7
    %Unit Test 7 : no F_aero
    clear F_aero
    error("Unit Test 7 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 8
    %Unit Test 8 : no a_accelerometer_error
    clear a_accelerometer_error
    error("Unit Test 8 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 9
    %Unit Test 9 : no r_trajectory
    clear r_trajectory
    error("Unit Test 9 passed.")
    sim('LinearDynamics_V', 10)
elseif i == 10
    %Unit Test 10 : F_aero is a row vector
    F_aero = transpose(F_aero);
    error("Unit Test 10 passed.")
    sim('LinearDynamics_V',10)
elseif i == 11
    %Unit Test 11 : a_accelerometer_error is a row vector
    a_accelerometer_error = transpose(a_accelerometer_error);
    error("Unit Test 11 passed.")
    sim('LinearDynamics_V',10)
elseif i == 12
    %Unit Test 12 : r_trajectory is a row vector
    r_trajectory = transpose(r_trajectory);
    error("Unit Test 12 passed.")
    sim('LinearDynamics_V',10)
elseif i == 13
    %Module Test 1 : increasing force
    sim('LinearDynamics_V', 10)
    subplot(2,2,1)
    plot(ans.F1);
    set(gca,'FontSize',16)
    xlabel('t [s]', 'fontsize', 16);
    ylabel('F [N]', 'fontsize', 16);
    title('Time vs Force', 'fontsize', 16);
    subplot(2,2,2)
    plot(ans.g_force1);
    set(gca,'FontSize',16)
    xlabel('t [s]', 'fontsize', 16);
    ylabel('a [g]', 'fontsize', 16);
    title('Time vs Acceleration', 'fontsize', 16);
    subplot(2,2,3)
    plot(ans.v1);
    set(gca,'FontSize',16)
    xlabel('t [s]', 'fontsize', 16);
    ylabel('v [ m/s]', 'fontsize', 16);
    title('Time vs Velcity', 'fontsize', 16);
    subplot(2,2,4)
    plot(ans.r1);
    set(gca,'FontSize',16)
    xlabel('t [s]', 'fontsize', 16);
    ylabel('r [m]', 'fontsize', 16);
    title('Time vs Position', 'fontsize', 16);
elseif i == 14
    %Subsystem Test 1 : PID controlled
    r_trajectory = [5;4;3];
    sim('LinearDynamics_V', 50);
    plot(ans.r)
    set(gca,'FontSize',16)
    xlabel('t [s]', 'fontsize', 16);
    ylabel('r [m]', 'fontsize', 16);
    title('Time vs Deviation', 'fontsize', 16);
    legend('x = 5', 'y = 4', 'z = 3')
end