function[pid_Mx, pid_My, pid_Mz] = angular_tune(wx_0, wy_0, wz_0, I_mat)
I_xx = I_mat(1,1);
I_xy = I_mat(1,2);
I_xz = I_mat(1,3);

I_yx = I_mat(2,1);
I_yy = I_mat(2,2);
I_yz = I_mat(2,3);

I_zx = I_mat(3,1);
I_zy = I_mat(3,2);
I_zz = I_mat(3,3);
%% Calculate A matrix
%Calculate numerators
a = (I_yy*I_zz - I_yz*I_zy)*(I_zx*wy_0 - I_yx*wz_0) + (I_xx*I_zy - I_xy*I_zz)*(I_xx*wz_0 - I_zx*wy_0 - I_zz*wz_0) + (I_xy*I_yz - I_xz*I_yy)*(I_zx*wx_0 + I_zy*wy_0 + I_zz*wz_0 - I_yx*wy_0);
b = (I_yy*I_zz - I_yz*I_zy)*(I_zx*wx_0 + I_zy*wy_0 + I_zz*wz_0 - I_yy*wz_0) + (I_xz*I_zy - I_xy*I_zz)*(I_xy*wz_0 - I_zz*wx_0) + (I_xy*I_yz - I_xz*I_yy)*(I_zz*wx_0 - I_yx*wx_0 - I_yy*wy_0 - I_yz*wz_0);
c = (I_yy*I_zz - I_yz*I_zy)*(I_zz*wy_0 - I_yx*wx_0 - I_yy*wy_0 - I_yz*wz_0) + (I_xz*I_zy - I_xy*I_zz)*(I_xx*wx_0 + I_xy*wy_0 + I_xz*wz_0 - I_zz*wx_0) + (I_xy*I_yz - I_xz*I_yy)*(I_zz*wx_0 - I_yz*wy_0);
d = (I_yz*I_zx - I_yx*I_zz)*(I_zx*wy_0 - I_yx*wz_0) + (I_xx*I_zz - I_xz*I_zx)*(I_xx*wz_0 - I_zx*wx_0 - I_zy*wy_0 - I_zz*wz_0) + (I_xz*I_yx - I_xx*I_yz)*(I_zx*wx_0 + I_zz*wz_0 - I_yx*wy_0);
e = (I_yz*I_zx - I_yx*I_zz)*(I_zx*wx_0 + I_zy*wy_0 + I_zz*wz_0 - I_yy*wz_0) + (I_xx*I_zz - I_xz*I_zx)*(I_xy*wz_0 - I_zz*wz_0) + (I_xz*I_yx - I_xx*I_yz)*(I_zz*wx_0 - I_yx*wx_0 - I_yy*wy_0 - I_yz*wz_0);
f = (I_yz*I_zx - I_yx*I_zz)*(I_zz*wy_0 - I_yx*wx_0 - I_yy*wy_0 -I_yz*wz_0) + (I_xx*I_zz - I_xz*I_zx)*(I_xx*wx_0 + I_xy*wy_0 + I_xz*wz_0 - I_zz*wx_0) + (I_xz*I_yx - I_xx*I_yz)*(I_zz*wx_0 - I_yz*wy_0);
g = (I_yx*I_zy - I_yy*I_zx)*(I_zx*wy_0 - I_yx*wz_0) + (I_xy*I_zx - I_xx*I_zy)*(I_xx*wz_0 - I_zx*wx_0 - I_zy*wy_0 - I_zz*wz_0) + (I_xx*I_yy - I_xy*I_yx)*(I_zx*wx_0 + I_zy*wy_0 + I_zz*wz_0 - I_yx*wy_0);
h = (I_yx*I_zy - I_yy*I_zx)*(I_zx*wx_0 + I_zy*wy_0 + I_zz*wz_0 - I_yy*wz_0) + (I_xy*I_zx - I_xx*I_zy)*(I_xy*wz_0 - I_zz*wx_0) + (I_xx*I_yy - I_xy*I_yx)*(I_zz*wx_0 - I_yx*wx_0 - I_yy*wy_0 - I_yz*wz_0);
i = (I_yx*I_zy - I_yy*I_zx)*(I_zz*wy_0 - I_yx*wx_0 - I_yy*wy_0 - I_yz*wz_0) + (I_xy*I_zx - I_xx*I_zy)*(I_xx*wx_0 + I_xy*wy_0 + I_xz*wz_0 - I_zz*wx_0) + (I_xx*I_yy - I_xy*I_yx)*(I_zz*wx_0 - I_yz*wy_0);
%Calculate denominator
A_d= I_xx*I_yy*I_zz + I_xy*I_yz*I_zx + I_xz*I_yx*I_zy - I_zx*I_yy*I_xz - I_zy*I_yz*I_xx - I_zz*I_yx*I_xy;
%Form A-matrix
A_mat = [a/A_d b/A_d c/A_d;
    d/A_d e/A_d f/A_d;
    g h i;];

%% Calculate B-matrix
ab = (I_yy*I_zz - I_yz*I_zy)/A_d;
bb = (I_xz*I_zy - I_xy*I_zz)/A_d;
cb = (I_xy*I_yz - I_xz*I_yy)/A_d;
db = (I_yz*I_zx - I_yx*I_zz)/A_d;
eb = (I_xx*I_zz - I_xz*I_zx)/A_d;
fb = (I_xz*I_yx - I_xx*I_yz)/A_d;
gb = (I_yx*I_zy - I_yy*I_zx)/A_d;
hb = (I_xy*I_zx - I_xx*I_zy)/A_d;
ib = (I_xx*I_yy - I_zy*I_yx)/A_d;

B_mat = [ab bb cb;
    db eb fb;
    gb hb ib;];

%% Make C & D matrix

C = eye(3);
D = zeros(3);

%% Make system

sys = ss(A_mat,B_mat,C,D);
trans_func = tf(sys);

pid_Mx = pidtune(trans_func(1,1), 'PID');
pid_Mx = [pid_Mx.Kp, pid_Mx.Ki, pid_Mx.Kd];

pid_My = pidtune(trans_func(2,2), 'PID');
pid_My = [pid_My.Kp, pid_My.Ki, pid_My.Kd];

pid_Mz = pidtune(trans_func(3,3), 'PID');
pid_Mz = [pid_Mz.Kp, pid_Mz.Ki, pid_Mz.Kd];
end