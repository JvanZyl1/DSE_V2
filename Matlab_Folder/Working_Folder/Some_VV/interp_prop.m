clear all
close all
clc

xt_1 = 1.2598;
xb_1 = 2.2598;
xt_3 = -1.3402;
x_t1 = xt_1;
x_b1 = xb_1;
x_t3 = xt_3;

M_y = 2000;
F_z = -1000;

a_coeff = 2 - 2*x_t1;
b_coeff = 2 -2*x_b1;
c_coeff = 4 - 4*x_t3;
d_coeff = M_y - F_z;

p_0 = 0;
p_minus1 = 0;
step = 10;
Converged = 0;
p_list = [];
x_list = [];
y_list = [];
J_list = [];
Fzz =[];
Myy =[];
while Converged == 0
    %A_mat = [1 1;xt_1 xb_1];
    %x1 = 1/((xt_1/xb_1) - 1)*(-0.5*F_z + (2-((2*xt_3)/xb_1))*p_0 + 1/(2*xb_1)*M_y);
    %y1 = 1/(2*xb_1)*(M_y - 2*xt_1*x1 - 4*xb_3*p_0);
    %y1 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_0 + 2*p_0 - 1/2*F_z);
    %x1 = 1/2*(F_z - 2*y1 - 4*p_0);
    %vec_1 = [F_z - 4*p_0; M_y - 4*p_0*xt_3];
    %force_1 = 0.5*A_mat*vec_1;
    %x1 = force_1(1);
    %y1 = force_1(2);
    %J_1 = sqrt(x1^2 + y1^2 + p_0^2);
    A_mat = [1 1;
    xt_1 xb_1];
    A_inv = inv(A_mat);
    B = [(F_z - 4*p_0); (M_y - 4*p_0*xt_3)];
    force = (A_inv*B); %Gives it as a total
    kkk =sum(force);
    x1 = force(1); %4*F_t1
    y1 = force(2); %4*F_b1
    %p_0 = 4*F_t3
    J_1 = sqrt(x1^2 + y1^2 + p_0^2);
    
    p_1 = p_0 + step;
    %y2 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_1 + 2*p_1 - 1/2*F_z);
    %x2 = 1/2*(F_z - 2*y2 - 4*p_1);
    %x2 = 1/((xt_1/xb_1) - 1)*(-0.5*F_z + (2-((2*xt_3)/xb_1))*p_1 + 1/(2*xb_1)*M_y);
    %y2 = 1/(2*xb_1)*(M_y - 2*xt_1*x2 - 4*xb_3*p_1);
    A_mat = [1 1;
    xt_1 xb_1];
    A_inv = inv(A_mat);
    B = [(F_z - 4*p_1); (M_y - 4*p_1*xt_3)];
    force = (A_inv*B);
    kkk =sum(force);
    x2 = force(1);
    y2 = force(2);
    J_2 = sqrt(x2^2 + y2^2 + p_1^2);
    
    p_2 = p_0 - step;
    %y3 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_2 + 2*p_2 - 1/2*F_z);
    %x3 = 1/2*(F_z - 2*y3 - 4*p_2);
    %x3 = 1/((xt_1/xb_1) - 1)*(-0.5*F_z + (2-((2*xt_3)/xb_1))*p_2 + 1/(2*xb_1)*M_y);
    %y3 = 1/(2*xb_1)*(M_y - 2*xt_1*x3 - 4*xb_3*p_2);
    A_mat = [1 1;
    xt_1 xb_1];
    A_inv = inv(A_mat);
    B = [(F_z - 4*p_2); (M_y - 4*p_2*xt_3)];
    force = (A_inv*B);
    kkk =sum(force);
    x3 = force(1);
    y3 = force(2);
    J_3 = sqrt(x3^2 + y3^2 + p_2^2);
    
    p = [p_0, p_1, p_2];
    x = [x1, x2, x2];
    y = [y1, y2, y3];
    J = [J_1, J_2, J_3];
    min_J = min(J);
    ind = find(J == min_J);
    if p_minus1 < p_0 && p_0 < p(ind)
        step = step;
    elseif p_minus1 > p_0 && p_0 > p(ind)
        step = step;
    else
        step = step*0.9;
    end
        
    p_minus1 = p_0;
    p_0 = p(ind);
    p_list = [p_list; p_0];
    x_list = [x_list; x(ind)];
    y_list = [y_list; y(ind)];
    J_list = [J_list; J(ind)];
    if step < 100
        Converged = 1;
    end
    %Fzs = x(ind) + y(ind)+ p_0;
    %Mys = xt_1*2*x + xb_1*2*y + 4*xb_3*p_0;
    %Fzz = [Fzz; Fzs];
    %Myy = [Myy; Mys];
end

F_t1 = x_list(length(x_list))/2;
F_t2 = F_t1;
F_t3 = p_list(length(p_list))/4;
F_t4 = F_t3;
F_b3 = F_t3;
F_b4 = F_t3;
F_b1 = y_list(length(y_list))/2;
F_b2 = F_b1;
    

Fzz = F_t1 + F_t2 + F_t3 + F_t4 + F_b1 + F_b2 + F_b3 + F_b4

ax1 = subplot(1,2,1);
plot(1:length(Fzz),Fzz)
title('Fz verificiation', 'interpreter', 'latex', 'fontsize', 16)
xlabel('Iteration Number', 'interpreter', 'latex', 'fontsize', 16)
ylabel('$F_{z}$ value', 'interpreter', 'latex', 'fontsize', 16)
ax = gca; 
ax.FontSize = 16; 

ax1 = subplot(1,2,2);
plot(1:length(Myy),Myy)
title('My verification', 'interpreter', 'latex', 'fontsize', 16)
xlabel('Iteration Number', 'interpreter', 'latex', 'fontsize', 16)
ylabel('M_{y}$ value', 'interpreter', 'latex', 'fontsize', 16)
ax = gca; 
ax.FontSize = 16; 


%{
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
%}
