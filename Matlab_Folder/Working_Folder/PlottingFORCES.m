subplot(2,2,1)
plot(out.Faeroy)
xlabel('Time [s]')
ylabel('Force in y')
title('Controller props reqs')
xlim([10,40])


subplot(2,2,2)
plot(out.Maerox)
xlabel('Time [s]')
ylabel('Moment in z')
title('Controller props reqs')
xlim([10,40])