x = [0, 0, 0, 0, 0, 15, -15, 0, 0, 0];
y =[0, 90, 45, 135, 180, 0, 0, 90, 90, 90];
z = [0, 0, 0, 0, 0, 0, 0, 15, 30,-15];
v = [-1.32, 0.29, -1.15, 1.29, 1.29, -1.33, -1.48, 0.3, 0.32, 0.32 ];
d = 0:1:180;
[xq,yq,zq] = meshgrid(d,d,0);
vq = griddata(x,y,z,v,xq,yq,zq);

%alpha - x
alpha = 0;
beta = 90;
phi = 30;
x_wanted = abs(alpha) + 1;
y_wanted = abs(beta) + 1;
z_wanted = abs(phi) + 1;

[xq,yq,zq] = meshgrid(d,d,z_wanted);
vq = griddata(x,y,z,v,xq,yq,zq);

vq(x_wanted, y_wanted)