sgtitle('Learning Linear Dynamics', 'Interpreter', 'Latex', 'fontsize', 16)

subplot(2,1,1)
plot(out.fifty_r, 'linewidth', 3)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Position [m]', 'Interpreter', 'Latex', 'fontsize', 16)
title('Position', 'Interpreter', 'Latex', 'fontsize', 16)
legend('x', 'y', 'z', 'Interpreter', 'Latex', 'fontsize', 16)
set(gca, 'fontsize', 16)

subplot(2,1,2)
plot(out.fifty_acc, 'linewidth', 3)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Acceleration [$m/s^2$]', 'Interpreter', 'Latex', 'fontsize', 16)
title('Velocity', 'Interpreter', 'Latex', 'fontsize', 16)
set(gca, 'fontsize', 16)