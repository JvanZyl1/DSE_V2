

fplot(@(t) 12.4 - 4.5*sin(3*pi*t/10.5)*(1 - cos(2*pi*t/10.5)), 'linewidth', 3)
xlim([0,10.5])
title('Gust profile', 'Interpreter', 'Latex', 'fontsize', 16)
ylabel('Gust speed [$m/s$]', 'Interpreter', 'Latex', 'fontsize', 16)
xlabel('Time [$s$]', 'Interpreter', 'Latex', 'fontsize', 16)
set(gca, 'fontsize', 16)