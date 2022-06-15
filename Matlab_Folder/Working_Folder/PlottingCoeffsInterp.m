figure;
sgtitle('Interpolated aerodynamic coefficients.', 'Interpreter','Latex', 'fontsize', 16)

subplot(3,2,1)
surf(XI_Cx, YI_Cx, ZI_Cx);shading interp; hold on
%plot3(XI_Cx,YI_Cx,ZI_Cx); hold on
colorbar
hold off
zlabel('$C_{X}$ [$~$]', 'Interpreter','Latex', 'fontsize', 16);
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
set(gca, 'fontsize', 16)

subplot(3,2,2)
surf(XI_Cy, YI_Cy, ZI_Cy);shading interp; hold on
%plot3(XI_Cy,YI_Cy,ZI_Cy); hold on
colorbar
hold off
zlabel('$C_{Y}$ [$~$]', 'Interpreter','Latex', 'fontsize', 16);
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
set(gca, 'fontsize', 16)

subplot(3,2,3)
surf(XI_Cz, YI_Cz, ZI_Cz);shading interp; hold on
%plot3(XI_Cz,YI_Cz,ZI_Cz); hold on
colorbar
hold off
zlabel('$C_{Z}$ [$~$]', 'Interpreter','Latex', 'fontsize', 16);
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
set(gca, 'fontsize', 16)

subplot(3,2,4)
surf(XI_p, YI_p, ZI_p);shading interp; hold on
%plot3(XI_p,YI_p,ZI_p); hold on
colorbar
hold off
zlabel('$C_{m_p}$ [$~$]', 'Interpreter','Latex', 'fontsize', 16);
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
set(gca, 'fontsize', 16)

subplot(3,2,5)
surf(XI_q,YI_q,ZI_q); shading interp; hold on
%plot3(XI_q,YI_q,ZI_q); hold on
colorbar
hold off
zlabel('$C_{m_q}$ [$~$]', 'Interpreter','Latex', 'fontsize', 16);
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
set(gca, 'fontsize', 16)

subplot(3,2,6)
surf(XI_r, YI_r, ZI_r);shading interp; hold on
%plot3(XI_r,YI_r,ZI_r); hold on
colorbar
hold off
zlabel('$C_{m_r}$ [$~$]', 'Interpreter','Latex', 'fontsize', 16);
xlabel('$\beta$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
ylabel('$\alpha$ [$\deg$]', 'Interpreter','Latex', 'fontsize', 16);
set(gca, 'fontsize', 16)




