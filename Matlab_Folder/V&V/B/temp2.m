function [c] = temp2()
T = readtable('proparms.txt','Delimiter',' ');
[r,c] = size(T);
for ii = 1:r
    eval([T.Var1{ii} '=' num2str(T.Var2(ii))])
end

zc_1 = -0.3;
xc_2 = 0.1;
yc_2 = -0.2;
zc_2 = 0.3;
xc_3 = 0.1;
yc_3 = -0.2;
zc_3 = 0.3;

xt_1 = 0;
yt_1 = -0.9;
zt_1 = 2.4;
xt_2 = 0;
yt_2 = -0.9;
zt_2 = 1.8;
xt_3 = 0;
yt_3 = -0.9;
zt_3 = -1.2;
xt_4 = 0;
yt_4 = -0.9;
zt_4 = -1.2;

xb_1 = -0.01;
yb_1 = 0;
zb_1 = 1.4;
xb_2 = -0.01;
yb_2 = 0;
zb_2 = 1.4;
xb_3 = -0.01;
yb_3 = 0;
zb_3 = 1.4;
xb_4 = -0.01;
yb_4 = 0;
zb_4 = 1.4;
xb_5 = -0.01;
yb_5 = 0;
zb_5 = 1.4;
xb_6 = -0.01;
yb_6 = 0;
zb_6 = 1.4;