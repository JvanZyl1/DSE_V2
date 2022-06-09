%% PID tune linear

m = 941.102; %kg

%xdot = [a_x, a_y, a_z, v_x, v_y, v_z];
%x = [v_x, v_y, v_z, r_x, r_y, r_z];
%y = [v_x, v_y, v_z, r_x, r_y, r_z];
%u = [F_x, F_y, F_z, -, -, -];
A = [0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    1 0 0 0 0 0;
    0 1 0 0 0 0;
    0 0 1 0 0 0];
B = [1/m 0 0 0 0 0;
    0 1/m 0 0 0 0;
    0 0 1/m 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];
C = eye(6);
D = zeros(6);

sys_lin = ss(A,B,C,D);
tf_lin = tf(sys_lin);
pid_Fx = pidtune(tf_lin(1,1), 'PID');
pid_Fx = [pid_Fx.Kp, pid_Fx.Ki, pid_Fx.Kd];

pid_Fy = pidtune(tf_lin(2,2), 'PID');
pid_Fy = [pid_Fy.Kp, pid_Fy.Ki, pid_Fy.Kd];

pid_Fz = pidtune(tf_lin(3,3), 'PID');
pid_Fz = [pid_Fz.Kp, pid_Fz.Ki, pid_Fz.Kd];

%% Results
%Kp, Ki, Kd, N
Fx_pid = [160.734193661502, 6.85755125615993, 923.025793270617, 10.4897155810233];
Fy_pid = [160.734193661502, 6.85755125615993, 923.025793270617, 10.4897155810233];
Fz_pid = [160.734193661502, 6.85755125615993, 923.025793270617, 10.4897155810233];