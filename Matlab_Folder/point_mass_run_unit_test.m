function [a, t] = point_mass_run_unit_test()
sim('untitled1',30);
a = ans.r;
tim = ans.time;
t = tim.signals.values;
end
