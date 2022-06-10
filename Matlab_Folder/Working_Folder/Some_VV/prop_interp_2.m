clear all
close all
clc

xt_1 = 1.2598;
xb_1 = 2.2598;
xt_3 = -1.3402;
x_t1 = xt_1;
x_b1 = xb_1;
x_t3 = xt_3;

M_y = -100;
F_z = 0;

A_mat = [1 1;
    xt_1 xb_1];

A_inv = inv(A_mat);

p_0 = 0.2;
p_minus1 = 0;
step = 1000;
Converged = 0;
p_list = [];
x_list = [];
y_list = [];
J_list = [];
Fzz =[];
Myy =[];
while Converged == 0
    B = [(F_z - 4*p_0); (M_y - 4*p_0*xt_3)];
    force_0 = (A_inv*B);
    J_0 = sqrt(force_0(1)^2 + force_0(2)^2 + p_0^2);
    back = A_mat*force_0;
    backtrack = [4*p_0; 4*p_0*xt_3];
    forceback = back+backtrack;
    diff = sum(abs(forceback - [F_z; M_y]));
    if diff > 10^(-7)
        disp('Error')
        break
    end
    force = force_0;
    J = J_0;
    p = p_0;
    
    p_1 = p_0 + step;
    B = [(F_z - 4*p_1); (M_y - 4*p_1*xt_3)];
    force_1 = (A_inv*B);
    J_1 = sqrt(force_1(1)^2 + force_1(2)^2 + p_1^2);
    back = A_mat*force_1;
    backtrack = [4*p_1; 4*p_1*xt_3];
    forceback = back+backtrack;
    diff = sum(abs(forceback - [F_z; M_y]));
    if diff > 10^(-7)
        disp('Error')
        break
    end
    if J_1 < J_0
        force = force_1;
        J = J_1;
        p = p_1;
    end
    
    p_2 = p_0 - step;
    B = [(F_z - 4*p_2); (M_y - 4*p_2*xt_3)];
    force_2 = (A_inv*B);
    J_2 = sqrt(force_2(1)^2 + force_2(2)^2 + p_2^2);
    back = A_mat*force_2;
    backtrack = [4*p_2; 4*p_2*xt_3];
    forceback = back+backtrack;
    diff = sum(abs(forceback - [F_z; M_y]));
    if diff > 10^(-7)
        disp('Error')
        break
    end
    if J_2 < J_0 && J_2 < J_1
        force = force_2;
        J = J_2;
        p = p_2;
    end
    
    if p_minus1 < p_0 && p_0 < p
        step = step;
    elseif p_minus1 > p_0 && p_0 > p
        step = step;
    else
        step = step*0.9;
    end
        
    p_minus1 = p_0;
    p_0 = p;
    p_list = [p_list; p_0];
    x_list = [x_list; force(1)];
    y_list = [y_list; force(2)];
    J_list = [J_list; J];
    if step < abs(min([F_z,M_y])*10^(-9))
        Converged = 1;
    end
    
    
end


back = A_mat*force;
backtrack = [4*p_0; 4*p_0*xt_3];
forceback = back+backtrack;
diff = sum(abs(forceback - [F_z; M_y]));
if diff > 10^(-1)
    disp('Error')
end

ax1 = subplot(1,4,1);
plot(1:length(p_list),p_list)
title('$F_{t_1}$ and $F_{t_2}$', 'interpreter', 'latex', 'fontsize', 16)
xlabel('Iteration Number', 'interpreter', 'latex', 'fontsize', 16)
ylabel('$F_{t3}$ value', 'interpreter', 'latex', 'fontsize', 16)
yline(300, '--r')
yline(-300, '--r')
ax = gca; 
ax.FontSize = 16; 

ax1 = subplot(1,4,2);
plot(1:length(p_list),x_list)
title('$F_{t_3}$, $F_{t_4}$, $F_{b_3}$ and $F_{b_4}$', 'interpreter', 'latex', 'fontsize', 16)
xlabel('Iteration Number', 'interpreter', 'latex', 'fontsize', 16)
ylabel('$F_{t1}$ value', 'interpreter', 'latex', 'fontsize', 16)
yline(300, '--r')
yline(-300, '--r')
ax = gca; 
ax.FontSize = 16; 

ax1 = subplot(1,4,3);
plot(1:length(p_list),y_list)
title('$F_{b_1}$ and $F_{b_2}$', 'interpreter', 'latex', 'fontsize', 16)
xlabel('Iteration Number', 'interpreter', 'latex', 'fontsize', 16)
ylabel('$F_{b1}$ value', 'interpreter', 'latex', 'fontsize', 16)
yline(300, '--r')
yline(-300, '--r')
ax = gca; 
ax.FontSize = 16; 

ax1 = subplot(1,4,4);
plot(1:length(p_list),J_list)
title('Total absolute force', 'interpreter', 'latex', 'fontsize', 16)
xlabel('Iteration Number', 'interpreter', 'latex', 'fontsize', 16)
ylabel('J value', 'interpreter', 'latex', 'fontsize', 16)
yline(900, '--r')
yline(-900, '--r')
ax = gca; 
ax.FontSize = 16; 