
F_wanted = [0;3;4];
M_wanted = [1;2;5];
[F_c, F_t, F_b] = propeller_required_forces_control(F_wanted, M_wanted)

[Fx_acc,Fy_acc, Fz_acc, Mx_acc, My_acc, Mz_acc] = fcn(F_c, F_t, F_b)