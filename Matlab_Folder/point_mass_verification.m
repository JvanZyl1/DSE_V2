clear all
close all
clc

%% Unit Test's 1-7: 0 inputs
noise_power = 0.0;
m = 600; %Test 0
rho = 1.225; % Test 1
C_D = 0.2; % Test 2
S = 2; % Test 3
T = 1.5; % Test 4
time_delay = 0.1; % Test 5
g = 0.91; % Test 7


Test_Number = 1;
if Test_Number == 0
    %%% Unit test mass = 0:
    m = 0;
    [grad_m_0, t] = point_mass_run_unit_test();
    % Causes an error - division by 0
    error("Unit Test 0 passed")
    
elseif Test_Number == 1
    %%% Unit test density = 0:
    rho = 0;
    [grad_rho_0, t] = point_mass_run_unit_test();
    
    Bool = all(grad_rho_0 == 0);
    if Bool ~= 1
        disp("Unit Test 1 Failed - zero density test.")
    end 
    
elseif Test_Number == 2
    %%% Unit test drag coefficient = 0:
    C_D = 0;
    [grad_C_D_0, t] = point_mass_run_unit_test();
    Bool = all(grad_C_D_0 == 0);
    if Bool ~= 1
        disp("Unit Test 2 Failed - zero C_D test.")
    end 
    
elseif Test_Number == 3
    %%% Unit test side surface area = 0:
    S = 0;
    [grad_S_0, t] = point_mass_run_unit_test();
    Bool = all(grad_S_0 == 0);
    if Bool ~= 1
        disp("Unit Test 2 Failed - zero S test.")
    end
    
elseif Test_Number == 4
    %%% Unit test time constant = 0:
    T = 0;
    [grad_T_0, t] = point_mass_run_unit_test();
    % Causes an error as sine wave with 0 frequency
    error("Unit Test 4 passed")
    
elseif Test_Number == 5
    %%% Unit test drag coefficient = 0:
    time_delay = 0;
    grad_time_delay_0 = point_mass_run_unit_test();
    
    %Failed - cause:"Warning: When delay time is set to zero, the transport delay block 'untitled1/Transport Delay2' is
    %automatically set to support direct feedthrough. This may cause an algebraic loop. A Memory Block can be
    %used in place of the Transport Delay to break the loop 
    %> In point_mass_run_unit_test (line 2)
    %In point_mass_verification (line 59) "
    error("Unit Test 5 passed")
    
elseif Test_Number == 6
    %%% Unit test drag coefficient = 0:
    g = 0;
    grad_g_0 = point_mass_run_unit_test();
    %Failed - divide by 0
    error("Unit Test 6 passed")

end

%% Unit Tests part 2: no inputs
clear all
close all
clc

test_number = 15
if test_number == 8
    % Passed - error
    
    m = 600; % Test 9
    rho = 1.225; % Test 10
    C_D = 0.2; % Test 11
    S = 2; % Test 12
    T = 1.5; % Test 13
    time_delay = 0.1; % Test 14
    g = 0.91; % Test 15
    error("Unit Test 8 passed")
elseif test_number == 9
    % Passed - error
    
    noise_power = 0.0; % Test 8
    rho = 1.225; % Test 10
    C_D = 0.2; % Test 11
    S = 2; % Test 12
    T = 1.5; % Test 13
    time_delay = 0.1; % Test 14
    g = 0.91; % Test 15
elseif test_number == 10
    % Passed - error
    
    noise_power = 0.0; % Test 8
    m = 600; % Test 9
    C_D = 0.2; % Test 11
    S = 2; % Test 12
    T = 1.5; % Test 13
    time_delay = 0.1; % Test 14
    g = 0.91; % Test 15
    error("Unit test 10 passed")
elseif test_number == 11
    % Passed - error
    
    noise_power = 0.0; % Test 8
    m = 600; % Test 9
    rho = 1.225; % Test 10
    S = 2; % Test 12
    T = 1.5; % Test 13
    time_delay = 0.1; % Test 14
    g = 0.91; % Test 15
    error("Unit Test 11 passed")
elseif test_number == 12
    % Passed - error
    
    noise_power = 0.0; % Test 8
    m = 600; % Test 9
    rho = 1.225; % Test 10
    C_D = 0.2; % Test 11
    T = 1.5; % Test 13
    time_delay = 0.1; % Test 14
    g = 0.91; % Test 15
    error("Unit Test 12 passed")
elseif test_number == 13
    % Passed - error
    
    noise_power = 0.0; % Test 8
    m = 600; % Test 9
    rho = 1.225; % Test 10
    C_D = 0.2; % Test 11
    S = 2; % Test 12
    time_delay = 0.1; % Test 14
    g = 0.91; % Test 15
    error("Unit Test 13 passed")
elseif test_number == 14
    % Passed - error
    
    noise_power = 0.0; % Test 8
    m = 600; % Test 9
    rho = 1.225; % Test 10
    C_D = 0.2; % Test 11
    S = 2; % Test 12
    T = 1.5; % Test 13
    g = 0.91; % Test 15
    error("Unit Test 14 passed")
elseif test_number == 15
    % Passed - error
    
    noise_power = 0.0; % Test 8
    m = 600; % Test 9
    rho = 1.225; % Test 10
    C_D = 0.2; % Test 11
    S = 2; % Test 12
    T = 1.5; % Test 13
    time_delay = 0.1; % Test 14
    error("Unit Test 15 passed")
end

sim('untitled1',30);
