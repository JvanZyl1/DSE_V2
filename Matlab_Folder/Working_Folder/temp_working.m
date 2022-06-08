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


t = length(u_0)
point = (t+delta_time)/delta_time
point = round(point)
