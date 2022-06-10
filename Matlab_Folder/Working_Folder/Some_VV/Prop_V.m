clear all
close all
clc

%% Maximum force
Fclim = 3000;

Fc1_u = Fclim;
Fc1_l = -Fclim;
Fc2_u = Fclim;
Fc2_l = -Fclim;
Fc3_u = Fclim;
Fc3_l = -Fclim;

Ftlim = 30000;
Fulim_TF = 56000;
Fulim_BF = 26000;
Fulim_Back = 32000;

Ft1_u = Fulim_TF;
Ft1_l = -Fulim_TF;
Ft2_u = Fulim_TF;
Ft2_l = -Fulim_TF;
Ft3_u = Fulim_Back;
Ft3_l = -Fulim_Back;
Ft4_u = Fulim_Back;
Ft4_l = -Fulim_Back;

Fb1_u = Fulim_BF;
Fb1_l = -Fulim_BF;
Fb2_u = Fulim_BF;
Fb2_l = -Fulim_BF;
Fb3_u = Fulim_Back;
Fb3_l = -Fulim_Back;
Fb4_u = Fulim_Back;
Fb4_l = -Fulim_Back;

Tdv = [1 0 0;
    0 1 0;
    0 0 1];

Tvd = transpose(Tdv);

Fc = [0;0;0];
Mc = [0;0;0];

fprop = 1000;

sig = 1;

%% ...
%CATIA trans
TcgCatia = [1 0 0;
    0 -1 0;
    0 0 -1];

%Propeller arms - changed due to CATIA errors
t_1 = [1259.8002; 1300; 839.472]*10^(-3);   %Top Front Left
t_2 = [1259.8002; -1300; 839.472]*10^(-3);  %Top Front Right
t_3 = [-1340.1998; 1300; 839.472]*10^(-3);  %Top Back Left
t_4 = [-1340.1998; -1300; 839.472]*10^(-3); %Top Back Right

b_1 = [2259.8002; 1300; -561.25]*10^(-3);   %Bottom Front Left
b_2 = [2259.8002; -1300; -561.25]*10^(-3);  %Bottom Front Right
b_3 = [-1340.1998; 1300; -561.25]*10^(-3);  %Bottom Back Left
b_4 = [-1340.1998; -1300; -561.25]*10^(-3); %Bottom Back Right

c_1 = [-640.1998; 0; 506.566]*10^(-3);      %Control Back Top
c_2 = [-1040.1998; 0; -493.434]*10^(-3);    %Control Back Bottom
c_3 = [2259.8002; 0; -293.434]*10^(-3);     %Control Front

%Propeller arms - rotated
t_1 = TcgCatia*t_1;
t1 = transpose(t_1);
t_2 = TcgCatia*t_2;
t2 = transpose(t_2);
t_3 = TcgCatia*t_3;
t3 = transpose(t_3);
t_4 = TcgCatia*t_4;
t4 = transpose(t_4);
b_1 = TcgCatia*b_1;
b1 = transpose(b_1);
b_2 = TcgCatia*b_2;
b2 = transpose(b_2);
b_3 = TcgCatia*b_3;
b3 = transpose(b_3);
b_4 = TcgCatia*b_4;
b4 = transpose(b_4);
c_1 = TcgCatia*c_1;
c1 = transpose(c_1);
c_2 = TcgCatia*c_2;
c2 = transpose(c_2);
c_3 = TcgCatia*c_3;
c3 = transpose(c_3);

prop_arms = [t1;t2;t3;t4;b1;b2;b3;b4;c1;c2;c3];

props = struct('t1', t1, 't2', t2, 't3', t3, 't4', t4, 'b1', b1, 'b2', b2, 'b3', b3, 'b4', b4, 'c1', c1, 'c2', c2, 'c3', c3);

%% ..


i = 7;
if i == 1
    %Unit Test 1 : no Tdv
    clear Tdv
    error("Unit Test 1 passed.")
    sim('Prop_VV', 10)
elseif i == 2
    %Unit Test 2 : no Tvd
    clear Tvd
    error("Unit Test 2 passed.")
    sim('Prop_VV', 10)
elseif i == 3
    %Unit Test 3 : no Fc
    clear Fc
    error("Unit Test 3 passed.")
    sim('Prop_VV', 10)
elseif i == 4
    %Unit Test 4 : no Mc
    clear Mc
    error("Unit Test 4 passed.")
    sim('Prop_VV', 10)
elseif i == 5
    %Unit Test 4 : no f_prop
    clear fprop
    error("Unit Test 5 passed.")
    sim('Prop_VV', 10)
elseif i == 0
    sim('Prop_VV',10)
elseif i == 6
    %Module Test 1 : no saturation or digisation, gives same input and
    %output, us the right model.
    Fc = rand(3,1);
    Mc = rand(3,1);
    sim('Prop_VV',10)
    fig = figure(1);
    hold on
    subplot(2,1,1); 
    plot(ans.Fccheck1);
    xlim([0,10.5])
    yline(Fc(1), '--r');
    yline(Fc(2), '--r');
    yline(Fc(3), '--r');
    hold off
    subplot(2,1,2);
    plot(ans.Mccheck1);
    xlim([0,10.5])
    ylim([-1,1.5])
    yline(Mc(1), '--r');
    yline(Mc(2), '--r');
    yline(Mc(3), '--r');
    hold off
elseif i ==7
    Fc = rand(3,1);
    Mc = rand(3,1);
    F_x  = Fc(1);
    F_y = Fc(2);
    F_z = Fc(3);
    M_x = Mc(1);
    M_y = Mc(2);
    M_z = Mc(3);
    
    xc_1 = abs(props.c1(1));
    yc_1 = abs(props.c1(2));
    zc_1 = abs(props.c1(3));

    xc_2 = abs(props.c2(1));
    yc_2 = abs(props.c2(2));
    zc_2 = abs(props.c2(3));

    xc_3 = abs(props.c3(1));
    yc_3 = abs(props.c3(2));
    zc_3 = abs(props.c3(3));

    xt_1 = abs(props.t1(1));
    yt_1 = abs(props.t1(2));
    zt_1 = abs(props.t1(3));

    xt_2 = abs(props.t2(1));
    yt_2 = abs(props.t2(2));
    zt_2 = abs(props.t2(3));

    xt_3 = abs(props.t3(1));
    yt_3 = abs(props.t3(2));
    zt_3 = abs(props.t3(3));

    xt_4 = props.t4(1);
    yt_4 = props.t4(2);
    zt_4 = props.t4(3);

    xb_1 = props.b1(1);
    yb_1 = props.b1(2);
    zb_1 = props.b1(3);

    xb_2 = props.b2(1);
    yb_2 = props.b2(2);
    zb_2 = props.b2(3);

    xb_3 = props.b3(1);
    yb_3 = props.b3(2);
    zb_3 = props.b3(3);

    xb_4 = props.b4(1);
    yb_4 = props.b4(2);
    zb_4 = props.b4(3);
    
    %% Control
    
    A_control = [1 1 1;
        zc_1 zc_2 zc_3;
        xc_1 xc_2 xc_3];
    Control_vec = [F_y; M_x; M_z];
    A_control_inverse = inv(A_control);
    Control_forces = A_control_inverse*Control_vec;
    
    Control_vec_2 = A_control*Control_forces;
    Control_works = Control_vec - Control_vec_2
    
    %% Top and Bottom
    x_t1 = xt_1;
    x_b1 = xb_1;
    x_t3 = xt_3;
    a_coeff = 2 - 2*x_t1;
    b_coeff = 2 -2*x_b1;
    c_coeff = 4 - 4*x_t3;
    d_coeff = M_y - F_z;

    p_0 = 0;
    p_minus1 = 0;
    step = 5600;
    Converged = 0;
    p_list = [];
    x_list = [];
    y_list = [];
    J_list = [];
    while Converged == 0
        y1 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_0 + 2*p_0 - 1/2*F_z);
        x1 = 1/2*(F_z - 2*y1 - 4*p_0);
        J_1 = sqrt(x1^2 + y1^2 + p_0^2);

        p_1 = p_0 + step;
        y2 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_1 + 2*p_1 - 1/2*F_z);
        x2 = 1/2*(F_z - 2*y2 - 4*p_1);
        J_2 = sqrt(x2^2 + y2^2 + p_1^2);

        p_2 = p_0 - step;
        y3 = (1/((x_b1/x_t1) -1))*(M_y/(2*x_t1) - (x_t3/x_t1)*p_2 + 2*p_2 - 1/2*F_z);
        x3 = 1/2*(F_z - 2*y3 - 4*p_2);
        J_3 = sqrt(x3^2 + y3^2 + p_2^2);

        p = [p_0, p_1, p_2];
        x = [x1, x2, x2];
        y = [y1, y2, y3];
        J = [J_1, J_2, J_3];
        min_J = min(J);
        ind = find(J == min_J);
        if p_minus1 < p_0 && p_0 < p(ind)
            step = step;
        elseif p_minus1 > p_0 && p_0 > p(ind)
            step = step;
        else
            step = step*0.9;
        end

        p_minus1 = p_0;
        p_0 = p(ind);
        p_list = [p_list; p_0];
        x_list = [x_list; x(ind)];
        y_list = [y_list; y(ind)];
        J_list = [J_list; J(ind)];
        if step < 0.01
            Converged = 1;
        end
    end
    F_t1  = y_list(length(y_list))
    F_t2 = F_t1
    F_t3 = p_0
    F_t4 = F_t3
    F_b3 = F_t3
    F_b4 = F_t3
    F_b1 = x_list(length(x_list))
    F_b2 = F_b1
    
    Tb_vec = [2*F_t1; 2*F_b1; 4*F_t3];
    A_tb = [1 1 1;
        x_t1 x_b1 x_t3];
    Force_vec = A_tb*Tb_vec
    Force_given = [F_z; M_y];
    Tb_work = Force_vec - Force_given
end