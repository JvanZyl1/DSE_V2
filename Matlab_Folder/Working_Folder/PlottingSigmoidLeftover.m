Fx = out.Fx_data();
Fy = out.Fy_data();
Fz = out.Fz_data();

a = 0.5;
b = 1;
r = (b-a).*rand(length(Fx),1) + a;

Fx_pre = Fx.*r;
Fy_pre = Fy.*r;
Fz_pre = Fz.*r;


xq = 0:0.001:40;
vq1 = interp1(out.tout,Fx_pre,xq);
vq2 = interp1(out.tout,Fy_pre,xq);
vq3 = interp1(out.tout,Fz_pre,xq);
plot(out.tout,Fx_pre,'o',xq,vq1,':.');

