legend_tags =  [];
for i = 1:length(S_list)
    i
    Cd = C_D_list(1,i);
    sval = S_list(1,i);
    t_delay = t_d_list(1,i);
    tag = "C_D:" + Cd + "S:" + sval + "Time Delay:" + t_delay;
    legend_tags = [legend_tags, tag];
end

subplot(1,3,1)
plot(g_force)
title("Load factor under control maneuver.")
xlabel("Time [ms]")
ylabel("g's")

subplot(1,3,2)
plot(rlist)
title("Deviation from trajectory under gust model.")
xlabel("Time [ms]")
ylabel("Deviation [m]")

subplot(1,3,3)
plot(F_control_minus_tau)
title("Time-delayed control force.")
xlabel("Time [ms]")
ylabel("Force [N]")
sgtitle("Gust control.")
legend(legend_tags)

