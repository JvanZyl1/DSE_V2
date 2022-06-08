%%% For this export the simulink outputs as timeseries


subplot(1,3,1)
plot(out.g_force)
yline(0)
title("Load factor under control maneuver.")
xlabel("Time [s]")
ylabel("g's")
legend(["X", "Y", "Z"])

subplot(1,3,2)
plot(out.r.data, out.r.time)
xline(0)
title("Deviation from trajectory under gust model.")
ylabel("Time [s]")
xlabel("Deviation [m]")

subplot(1,3,3)
plot(out.F_control_minustau)
yline(0)
title("Time-delayed control force.")
xlabel("Time [s]")
ylabel("Force [N]")
sgtitle("Gust control for, C_D:" + C_D + ", S:" + S + ", m:" + m + ", tau:" + time_delay)
