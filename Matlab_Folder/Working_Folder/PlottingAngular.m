sgtitle('Angular Dynamics', 'Interpreter', 'Latex', 'fontsize', 16)

subplot(3,1,1)
plot(out.angle_deg, 'linewidth', 3)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Angle [deg]', 'Interpreter', 'Latex', 'fontsize', 16)
title('Angle deviation', 'Interpreter', 'Latex', 'fontsize', 16)
legend('x', 'y', 'z', 'Interpreter', 'Latex', 'fontsize', 16)
set(gca, 'fontsize', 16)

subplot(3,1,2)
plot(out.omega, 'linewidth', 3)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('$\omega$', 'Interpreter', 'Latex', 'fontsize', 16)
title('Angle Velocity [$rad/s$]', 'Interpreter', 'Latex', 'fontsize', 16)
legend('x', 'y', 'z', 'Interpreter', 'Latex', 'fontsize', 16)
set(gca, 'fontsize', 16)

subplot(3,1,3)
plot(out.alpha_3, 'linewidth', 3)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('$\alpha$', 'Interpreter', 'Latex', 'fontsize', 16)
title('Angular Acceleration [$rad/s^2$]', 'Interpreter', 'Latex', 'fontsize', 16)
legend('x', 'y', 'z', 'Interpreter', 'Latex', 'fontsize', 16)
set(gca, 'fontsize', 16)
xlim([0.1,35])