x_t1 = 1.2598;
x_b1 = 2.2598;
x_t3 = -1.3402;

M_y = 2000;
F_z = -1000;

a_coeff = 2 - 2*x_t1;
b_coeff = 2 -2*x_b1;
c_coeff = 4 - 4*x_t3;
d_coeff = M_y - F_z;

p_0 = 0;
p_minus1 = 0;
step = 5600;
Converged = 0;
p_list = [];
x_list = [];
y_list = [];
J_list = [];
while Converged == 0
    y1 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_0 + 2*p_0 - 1/2*F_z);
    x1 = 1/2*(F_z - 2*y1 - 4*p_0);
    J_1 = sqrt(x1^2 + y1^2 + p_0^2);
    
    p_1 = p_0 + step;
    y2 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_1 + 2*p_1 - 1/2*F_z);
    x2 = 1/2*(F_z - 2*y2 - 4*p_1);
    J_2 = sqrt(x2^2 + y2^2 + p_1^2);
    
    p_2 = p_0 - step;
    y3 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_2 + 2*p_2 - 1/2*F_z);
    x3 = 1/2*(F_z - 2*y3 - 4*p_2);
    J_3 = sqrt(x3^2 + y3^2 + p_2^2);
    
    p = [p_0, p_1, p_2]
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
    if step < 0.01
        Converged = 1;
    end
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
