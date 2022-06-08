legend_tags =  [];
for i = 1:length(t_delay)
    t_del = t_delay(1,i);
    tag = "Time Delay:" + t_del + "s";
    legend_tags = [legend_tags, tag];
end

subplot(1,3,1)
plot(g_force1)
title("Load factor under control maneuver.")
xlabel("Time [s]")
ylabel("g's")

subplot(1,3,2)
plot(rlist1)
title("Deviation from trajectory under gust model.")
xlabel("Time [s]")
ylabel("Deviation [m]")

subplot(1,3,3)
plot(F_control_minus_tau1)
title("Time-delayed control force.")
xlabel("Time [s]")
ylabel("Force [N]")
sgtitle("Gust control" + ", C_D:" + C_D + ", S:" + S)
legend(legend_tags)
