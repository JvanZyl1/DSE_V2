sgtitle('The Shard Gust Profile', 'Interpreter', 'Latex', 'fontsize', 16)
subplot(3,1,1)
plot(out.u0, 'linewidth', 3)
title('x-direction: back-to-front', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Gust Speed [m/s]', 'Interpreter', 'Latex', 'fontsize', 16)

set(gca, 'fontsize', 16)

subplot(3,1,2)
plot(out.u1, 'linewidth', 3)
title('y-direction: left-to-right', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Gust Speed [m/s]', 'Interpreter', 'Latex', 'fontsize', 16)

set(gca, 'fontsize', 16)

subplot(3,1,3)
plot(out.u2, 'linewidth', 3)
title('z-direction: top-to-bottom', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [sec]', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Gust Speed [m/s]', 'Interpreter', 'Latex', 'fontsize', 16)

set(gca, 'fontsize', 16)