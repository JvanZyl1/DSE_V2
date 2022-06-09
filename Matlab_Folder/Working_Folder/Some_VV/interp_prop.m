x_t1 = 1.2598;
x_b1 = 2.2598;
x_t3 = -1.3402;

M_y = 20;
F_z = 10;

a_coeff = 2 - 2*x_t1;
b_coeff = 2 -2*x_b1;
c_coeff = 4 - 4*x_t3;
d_coeff = M_y - F_z;

[X,Y] = meshgrid(-100:100);

V = 1/c_coeff*(a_coeff*X + b_coeff*Y + c_coeff);

total = X + Y + V;


%surf(X,Y,V)
%plot3(X,Y,V)
