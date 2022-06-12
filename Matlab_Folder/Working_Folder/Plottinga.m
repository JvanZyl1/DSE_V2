

subplot(2,2,1)
plot(out.theta_tot)
xlabel('Time [s]')
ylabel('Magnitude of Angle Deviation [deg]')
title('Angle')


subplot(2,2,2)
plot(out.alpha)
xlabel('Time [s]')
ylabel('Magnitude of Angular Acceleration [rad/s^2]')
title('Angular Acceleration')

subplot(2,2,3)
plot(out.rtot)
xlabel('Time [s]')
ylabel('Magnitude of Postion Deviation [m]')
title('Position')

subplot(2,2,4)
plot(out.acc)
xlabel('Time [s]')
ylabel('Magnitude of Acceleration [m/s^2]')
title('Linear Acceleration')