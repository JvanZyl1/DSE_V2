clear all
clc
close all

v_gust = [1; 2; 3];
v_vehicle = [2;3;4];
rho = 1.225;
S = 2.5;
C_D = 0.6;

k = 0;
i = 1;
if k == 1
    if i == 1
        %Unit Test 1 - Set v_gust equal to a row vector:
        v_gust = transpose(v_gust);
        sim('Drag_Model_V',10);
        error('Unit Test 1 passed')
        v_gust = transpose(v_gust); %Reset
    elseif i == 2
        %Unit Test 2 - Set v_vehicle equal to a row vector:
        v_vehicle = transpose(v_vehicle);
        sim('Drag_Model_V',10);
        error('Unit Test 2 passed')
    elseif i == 3
        %Unit Test 3 - Remove input rho:
        clear all
        v_gust = [1; 2; 3];
        v_vehicle = [2;3;4];
        S = 2.5;
        C_D = 0.6;
        sim('Drag_Model_V',10);
        error('Unit Test 3 passed')
    elseif i == 4
        %Unit Test 4 - Remove input S:
        clear all
        v_gust = [1; 2; 3];
        v_vehicle = [2;3;4];
        rho = 1.225;
        C_D = 0.6;
        sim('Drag_Model_V',10);
        error('Unit Test 4 passed')
    elseif i == 5
        %Unit Test 5 - Remove input C_D:
        clear all
        v_gust = [1; 2; 3];
        v_vehicle = [2;3;4];
        rho = 1.225;
        S = 2.5;
        sim('Drag_Model_V',10);
        error('Unit Test 5 passed')
    elseif i ==6
        %Unit Test 6 - Visual inspection of step function, watch step = 0
        %at 10.5
        sim('Drag_Model_V',12);
        plot(ans.step)
    elseif i ==7
        %Unit Test 7 - Check that the squaring functions work
        v_total = v_gust + v_vehicle;
        v_sq = v_total.^2;
        sim('Drag_Model_V',12);
        vsumsq = ans.v_sumsq;
        error = vsumsq - v_sq;
        if error == 0
            disp("Unit Test 7 passed.")
        end 
    end
elseif k == 0
    %Module Test - Matlab to Simulink Comparison
    sim('Drag_Model_V',12);
    v_gust = [1; 2; 3];
    v_vehicle = [2;3;4];
    rho = 1.225;
    S = 2.5;
    C_D = 0.6;
    V_total = v_gust + v_vehicle;
    V_squared = V_total.^2;
    Drag = 0.5*rho*V_squared*C_D*S;
    plot(ans.F_gust)
    set(gca,'FontSize',20)
    yline(Drag(1), '--')
    yline(Drag(2), '--')
    yline(Drag(3), '--')
    title('Drag over time', 'fontsize', 16)
    xlabel('Time [s]', 'fontsize', 16)
    ylabel('Gust size', 'fontsize', 16)
end