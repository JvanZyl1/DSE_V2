clear all
close all
clc

%% Maximum force
Fclim = 30000;

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


i = 6;
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
end