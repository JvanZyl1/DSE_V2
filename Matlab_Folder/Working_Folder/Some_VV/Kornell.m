a = 1.2598;
b = 2.2598;
c = -1.3402;

F = 2784;
M = -1000;
syms x y z
eq1 = 2*x+2*y+4*z==F;
eq2 = 2*a*x+2*b*y+4*c*z==M;

xyz = solve([eq1, eq2]);
x = xyz.x
x_fun = matlabFunction(x);

y = xyz.y
y_fun = matlabFunction(y);

syms t
func = sqrt(x_fun(t)^2+y_fun(t)^2+t^2);

test = matlabFunction(func);

result = fminbnd(test,-10000,10000);

F1 = x_fun(result);
F2 = y_fun(result);
F3 = result;

total = sqrt(F1^2 + F2^2 + F3^2);

2*a*F1+2*b*F2+4*c*F3 - M
2*F1+2*F2+4*F3 - F
