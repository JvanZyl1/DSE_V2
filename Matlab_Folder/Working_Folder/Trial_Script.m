clear all
close all
clc

%% Generic inputs
I_xx = 3866.543;
I_yy = 16529.205;
I_zz = 17264.21;

Inertia = [I_xx 0 0;
    0 I_yy 0;
    0 0 I_zz];
I_mat = Inertia;
Inertia_inv = inv(Inertia);
I_inv = Inertia_inv;

theta_0 = [0;0;0];
w_0 = [0;0;0];
r_0 = [0;0;0];
v_0 = [0;0;0];
a_0 = [0;0;0];

m = 645;
rho = 1.225;
g = 9.81;
T = 10.5;
C_D = 0.6;
time_delay = 0.1;
S = 1*1.8;
f_prop = 100;

%% Linear Dynamics Inputs
%F_aero = [1;2;3];
r_trajectory = [0;0;0];
%a_accelerometer_error = [1;2;3];

%% Maximum force
Fclim = 3000;

Fc1_u = Fclim;
Fc1_l = -Fclim;
Fc2_u = Fclim;
Fc2_l = -Fclim;
Fc3_u = Fclim;
Fc3_l = -Fclim;

Ftlim = 3000;
Fulim_TF = 5600;
Fulim_BF = 2600;
Fulim_Back = 3200;

Ft1_u = Fulim_TF;
Ft1_l = -Fulim_TF;
Ft2_u = Fulim_TF;
Ft2_l = -Fulim_TF;
Ft3_u = Fulim_Back;
Ft3_l = -Fulim_Back;
Ft4_u = Fulim_Back;
Ft4_l = -Fulim_Back;

Fb1_u = Fulim_BF;
Fb1_l = -Fulim_BF;
Fb2_u = Fulim_BF;
Fb2_l = -Fulim_BF;
Fb3_u = Fulim_Back;
Fb3_l = -Fulim_Back;
Fb4_u = Fulim_Back;
Fb4_l = -Fulim_Back;


%% Linear Dynamics Kalman Filter

A_kal = [0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0];

B_kal = [0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 0 0 0;
    0 0 0 1/m 0 0;
    0 0 0 0 1/m 0;
    0 0 0 0 0 1/m];

C_kal = eye(6);

D_kal = zeros(6);

%% Angular dynamics Kalman filter

A_i = vertcat(zeros(3), zeros(3));
A_ii = vertcat(eye(3), zeros(3));
A_AD = horzcat(A_i, A_ii);

B_i = vertcat(zeros(3), zeros(3));
B_ii = vertcat(zeros(3), I_inv);
B_AD = horzcat(B_i, B_ii);



C_AD = eye(6);
D_AD = zeros(6);

sys = ss(A_AD, B_AD, C_AD, D_AD);

%% PID tune of angular 
A_2 = zeros(3);
B_2 = I_inv;
C_2 = eye(3);
D_2 = zeros(3);
sys2 = ss(A_2, B_2, C_2, D_2);

trans_func = tf(sys2);

pid_Mx = pidtune(trans_func(1,1), 'PID');
pid_Mx = [pid_Mx.Kp, pid_Mx.Ki, pid_Mx.Kd];

pid_My = pidtune(trans_func(2,2), 'PID');
pid_My = [pid_My.Kp, pid_My.Ki, pid_My.Kd];

pid_Mz = pidtune(trans_func(3,3), 'PID');
pid_Mz = [pid_Mz.Kp, pid_Mz.Ki, pid_Mz.Kd];

v_vehicle = [20; 0; 0];
theta_vehicle = [0;0; 0];
x_cp = [0.3; 0.2; 0.1];

K_gain = 300; %10000
a_MF = 0.6; %2.5
c_MF = 1.5; %1.75

load('MPCDesignerSession.mat');
%{
a_list = [];
K_list = [];
c_list = [];
angerror_list =[];
Mc_list =[];
radx_list = [];
rady_list = [];
radz_list = [];
xe_list =[];
ye_list = [];
ze_list = [];
for i = 0:1 %c_MF
    i = i/10;
    c_MF = i;
    for j = 5:5:40 %a_MF
        j = j/10;
        a_MF = j;
        for k = 3 %K_gain
            i
            k = k*100;
            K_gain = k;
            sim('simgoid_terry.slx', 60);
            c_list = [c_list; i];
            a_list = [a_list; j];
            K_list = [K_list; k];
            Mc_list = [Mc_list; ans.Mc];
            angerror_list = [angerror_list; ans.angle_error];
            radx_list = [radx_list, ans.radx];
            rady_list = [rady_list, ans.rady];
            radz_list = [radz_list, ans.radz];
            length(ans.errorx);
            %xe_list = [xe_list, ans.errorx];
            %ye_list = [ye_list, ans.errory];
            %ze_list = [ze_list, ans.errorz];
        end
    end
end
%}

%% Generate C_X lookup table

P = [0, 0, -1.32;
    0, 90, 0.29;
    0, 45, -1.15;
    0, 135, 1.29;
    0, 180, 1.29;
    15, 0, -1.33;
    -15, 0, -1.48;
    15, 90, 0.3;
    30, 90, 0.32;
    -15, 90, 0.32];
x = P(:,1) ; y = P(:,2) ; z = P(:,3) ;
x1 = x; y1 = y; z1 = z;
x = [abs(x); -abs(x); abs(x); -abs(x)];
y = [abs(y); abs(y); -abs(y); -abs(y)];
z = [z; z; z; z];
%x = [0, 0, 0, 0, 0, 15, -15, 0, 0, 0];
%y =[0, 90, 45, 135, 180, 0, 0, 90, 90, 90];
%z = [-1.32, 0.29, -1.15, 1.29, 1.29, -1.33, -1.48, 0.3, 0.32, 0.32 ];
ti = -180:1:180;
[XI_Cx, YI_Cx] = meshgrid(ti,ti);
model_Cx = scatteredInterpolant(x, y, z, 'linear', 'linear');
ZI_Cx = model_Cx(XI_Cx, YI_Cx);

%% Generate C_Y lookup table

P = [0, 0, 0;
    0, 90, 2.7;
    0, 45, 1.95;
    0, 135, 2.19;
    0, 180, 0;
    15, 0, 0;
    -15, 0, 0;
    15, 90, 2.85;
    30, 90, 2.76;
    -15, 90, 2.69];

x = P(:,1) ; y = P(:,2) ; z = P(:,3) ;
x1 = x; y1 = y; z1 = z;
x = [abs(x); -abs(x); abs(x); -abs(x)];
y = [abs(y); abs(y); -abs(y); -abs(y)];
z = [z; z; z; z];
%x = [0, 0, 0, 0, 0, 15, -15, 0, 0, 0];
%y =[0, 90, 45, 135, 180, 0, 0, 90, 90, 90];
%z = [-1.32, 0.29, -1.15, 1.29, 1.29, -1.33, -1.48, 0.3, 0.32, 0.32 ];
ti = -180:1:180;
[XI_Cy, YI_Cy] = meshgrid(ti,ti);
model_Cy = scatteredInterpolant(x, y, z, 'linear', 'linear');
ZI_Cy = model_Cy(XI_Cy, YI_Cy);

%% Generate C_Z values
P = [0, 0, -0.23;
    0, 90, -0.65;
    0, 45, -0.68;
    0, 135, -1.04;
    0, 180, 0.2;
    15, 0, 0.55;
    -15, 0, -1.23;
    15, 90, 0.51;
    30, 90, 1.45;
    -15, 90, -1.4];

x = P(:,1) ; y = P(:,2) ; z = P(:,3) ;
x1 = x; y1 = y; z1 = z;
x = [abs(x); -abs(x); abs(x); -abs(x)];
y = [abs(y); abs(y); -abs(y); -abs(y)];
z = [z; z; z; z];
%x = [0, 0, 0, 0, 0, 15, -15, 0, 0, 0];
%y =[0, 90, 45, 135, 180, 0, 0, 90, 90, 90];
%z = [-1.32, 0.29, -1.15, 1.29, 1.29, -1.33, -1.48, 0.3, 0.32, 0.32 ];
ti = -180:1:180;
[XI_Cz, YI_Cz] = meshgrid(ti,ti);
model_Cz = scatteredInterpolant(x, y, z, 'linear', 'linear');
ZI_Cz = model_Cz(XI_Cz, YI_Cz);

%% Generate C_mpitch values

P = [0, 0, -1.10E-02;
    0, 90, -0.17;
    0, 45, -0.21;
    0, 135, 0.47;
    0, 180, 0.072;
    15, 0, -1.14;
    -15, 0, 1.2;
    15, 90, -0.79;
    30, 90, -1.22;
    -15, 90, 0.29];

x = P(:,1) ; y = P(:,2) ; z = P(:,3) ;
x1 = x; y1 = y; z1 = z;
x = [abs(x); -abs(x); abs(x); -abs(x)];
y = [abs(y); abs(y); -abs(y); -abs(y)];
z = [z; z; z; z];
%x = [0, 0, 0, 0, 0, 15, -15, 0, 0, 0];
%y =[0, 90, 45, 135, 180, 0, 0, 90, 90, 90];
%z = [-1.32, 0.29, -1.15, 1.29, 1.29, -1.33, -1.48, 0.3, 0.32, 0.32 ];
ti = -180:1:180;
[XI_p, YI_p] = meshgrid(ti,ti);
model_p = scatteredInterpolant(x, y, z, 'linear', 'linear');
ZI_p = model_p(XI_p, YI_p);

%% Generate C_mq values

P = [0, 0, 0;
    0, 90, -0.86;
    0, 45, -0.75;
    0, 135, -0.83;
    0, 180, 0;
    15, 0, 0;
    -15, 0, 0;
    15, 90, -1.35;
    30, 90, -1.76;
    -15, 90, -0.6];

x = P(:,1) ; y = P(:,2) ; z = P(:,3) ;
x1 = x; y1 = y; z1 = z;
x = [abs(x); -abs(x); abs(x); -abs(x)];
y = [abs(y); abs(y); -abs(y); -abs(y)];
z = [z; z; z; z];
%x = [0, 0, 0, 0, 0, 15, -15, 0, 0, 0];
%y =[0, 90, 45, 135, 180, 0, 0, 90, 90, 90];
%z = [-1.32, 0.29, -1.15, 1.29, 1.29, -1.33, -1.48, 0.3, 0.32, 0.32 ];
ti = -180:1:180;
[XI_q, YI_q] = meshgrid(ti,ti);
model_q = scatteredInterpolant(x, y, z, 'linear', 'linear');
ZI_q = model_q(XI_q, YI_q);

%% Generate C_mr values

P = [0, 0, 0;
    0, 90, 0.83;
    0, 45, 1.24;
    0, 135, -0.085;
    0, 180, 0;
    15, 0, 0;
    -15, 0, 0;
    15, 90, 0.68;
    30, 90, 0.49;
    -15, 90, 0.88];

x = P(:,1) ; y = P(:,2) ; z = P(:,3) ;
x1 = x; y1 = y; z1 = z;
x = [abs(x); -abs(x); abs(x); -abs(x)];
y = [abs(y); abs(y); -abs(y); -abs(y)];
z = [z; z; z; z];
%x = [0, 0, 0, 0, 0, 15, -15, 0, 0, 0];
%y =[0, 90, 45, 135, 180, 0, 0, 90, 90, 90];
%z = [-1.32, 0.29, -1.15, 1.29, 1.29, -1.33, -1.48, 0.3, 0.32, 0.32 ];
ti = -180:1:180;
[XI_r, YI_r] = meshgrid(ti,ti);
model_r = scatteredInterpolant(x, y, z, 'linear', 'linear');
ZI_r = model_r(XI_r, YI_r);

%% Reading the shard data

a = csvread('data.csv', 1, 1);

d_shard = 1001; %1002
u_0 = a(1:d_shard,1);
u_1 = a(1:d_shard,2);
u_2 = a(1:d_shard,3);
xdata = a(1:d_shard,4);
ydata = a(1:d_shard,5);
zdata = a(1:d_shard,6);

Tzy_Shard = [cos(pi/2) -sin(pi/2) 0; sin(pi/2) cos(pi/2) 0; 0 0 1]*[1 0 0;
    0 cos(pi) -sin(pi);
    0 sin(pi) cos(pi)];

Tzy_Shard_inv = inv(Tzy_Shard);

r0_shard = [xdata(1); ydata(2); zdata(3)];
rfinal_shard = [xdata(length(xdata)); ydata(length(ydata)); zdata(length(zdata))];
rdiff_shard = r0_shard - rfinal_shard;

m_shard = (abs(max(zdata)) + abs(min(zdata)))/(abs(max(ydata)) + abs(min(ydata))); %Gradient of shard in shard frame
angle_shard = atan(m_shard); %a - y, o  - z
V0_shard = 100* 100/(60*60);
Vz0_shard = V0_shard*cos(angle_shard);
Vy0_shard = V0_shard*sin(angle_shard);
V0_shard = [0; Vz0_shard; Vy0_shard];

time = abs(rdiff_shard(2)/V0_shard(2));
delta_time = time/length(xdata);

%% Aero transformation

TcgCatia = [1 0 0;
    0 -1 0;
    0 0 -1];

r_cgCatia = [2; 0; 0];

%git hub

