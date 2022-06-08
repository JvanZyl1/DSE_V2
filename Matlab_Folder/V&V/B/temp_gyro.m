function gyroData  = temp_gyro(x_acc, y_acc, z_acc, x_vel, y_vel, z_vel)
    % Ouputs: Angular velocity
    % Create gyroscope sensor object
    acc = [x_acc, y_acc, z_acc]
    angvel = [x_vel, y_vel, z_vel]
    
    params = gyroparams         
    
    % Parameters for simulated signal
    N = 1;       % Number of samples
    Fs = 100;       % Sampling rate
    Fc = 0.25;      % Sinusoidal frequency
    
    % Create arrays
    t = (0:(1/Fs):((N-1)/Fs)).';
    acc = acc;          % Input accelerations
    angvel = angvel;
    %angvel(:,1) = 8*sin(2*pi*Fc*t);
    
    % Generate gyroscopic data
    imu = imuSensor('SampleRate', Fs, 'Gyroscope', params);
    imu.Gyroscope.MeasurementRange = 6.5;   % Maximum angular velocity gyroscope can measure
    imu.Gyroscope.Resolution = 1/Fs;           % Step size of digital measurements
    
    % Biases
    
    imu.Gyroscope.BiasInstability = 0.12 * 3.14159 / 180;       % rad/hr
    imu.Gyroscope.NoiseDensity = 0.15 * 3.14159 / 180;          % rad/s
    imu.Gyroscope.RandomWalk = 0.017 * 3.14159 / 180;           % rad/sqrt(hr)
    imu.Gyroscope.TemperatureBias = 0.25 * 3.14159 / 180;       % rad/s
    imu.Gyroscope.AccelerationBias = 0.3;
    
    % Define real accelerations
    %acc(:,1) = 1;
    [~, gyroData] = imu(acc, angvel);

end


