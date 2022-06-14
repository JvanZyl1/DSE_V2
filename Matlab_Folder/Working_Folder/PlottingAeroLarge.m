set(gca, 'fontsize', 20)
surf(XI_Cz, YI_Cz, ZI_Cz);shading interp; hold on
%plot3(XI_Cx,YI_Cx,ZI_Cx); hold on
colorbar
hold off
zlabel('$C_{Z}$ [$~$]', 'Interpreter','Latex', 'fontsize', 16);
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);