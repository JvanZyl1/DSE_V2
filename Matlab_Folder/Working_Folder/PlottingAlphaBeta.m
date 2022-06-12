subplot(2,1,1)
plot(out.alpha_coeff)
title('Alpha')
xlabel('Time [sec]')
ylabel('alpha [rad]')
set(gca,'YTick',-2*pi:pi/2:2*pi) 
set(gca,'YTickLabel',{'-pi/2', '-pi/4', '0','pi/4', 'pi/2'})

subplot(2,1,2)
plot(out.beta_coeff)
title('Beta')
xlabel('Time [sec]')
ylabel('beta [rad]')
set(gca,'YTick',-2*pi:pi/2:2*pi) 
set(gca,'YTickLabel',{'-pi/2', '-pi/4', '0','pi/4', 'pi/2'})