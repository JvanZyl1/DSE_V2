subplot(3,2,1)
plot(out.Cx_b, 'linewidth', 3)
title('$C_X$', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Coefficient [-]', 'Interpreter', 'Latex', 'fontsize', 16)
xlim([0,18])
set(gca, 'fontsize', 16)


subplot(3,2,2)
plot(out.Cy_b, 'linewidth', 3)
title('$C_Y$', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Coefficient [-]', 'Interpreter', 'Latex', 'fontsize', 16)
xlim([0,18])
set(gca, 'fontsize', 16)


subplot(3,2,3)
plot(out.Cz_b, 'linewidth', 3)
title('$C_Z$', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Coefficient [-]', 'Interpreter', 'Latex', 'fontsize', 16)
xlim([0,18])
set(gca, 'fontsize', 16)


subplot(3,2,4)
plot(out.Cmp_b, 'linewidth', 3)
title('$C_{m_p}$', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Coefficient [-]', 'Interpreter', 'Latex', 'fontsize', 16)
xlim([0,18])
set(gca, 'fontsize', 16)


subplot(3,2,5)
plot(out.Cmq_b, 'linewidth', 3)
title('$C_{m_q}$', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Coefficient [-]', 'Interpreter', 'Latex', 'fontsize', 16)
xlim([0,18])
set(gca, 'fontsize', 16)


subplot(3,2,6)
plot(out.Cmr_b, 'linewidth', 3)
title('$C_{m_r}$', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Coefficient [-]', 'Interpreter', 'Latex', 'fontsize', 16)
xlim([0,18])
set(gca, 'fontsize', 16)

sgtitle('Coefficients transformed to body frame')