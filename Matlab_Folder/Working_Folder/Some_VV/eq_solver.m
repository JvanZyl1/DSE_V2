syms x y z 
x_t1 = 1.2598;
x_b1 = 2.2598;
x_t3 = -1.3402;

F_z = 10;
M_y = -50;

Eq1 = x + y + z == F_z;                      % Original Equation
Eq2 = x_t1*x + x_b1*y + x_t3*z == M_y;       % Original Equation
z1 = solve(Eq1,z);                           % Solve For ‘z’
z2 = solve(Eq2,z);                           % Solve For ‘z’
Eq1 = subs(Eq1,z, z2);                       % Substitute
Eq2 = subs(Eq2, z, z1);                      % Substitute
[Xs,Ys] = solve(Eq1, Eq2, [x,y]);            % Solve For ‘x’ And  ‘y’