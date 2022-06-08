function accelData = accelerometer(angvel, acc)

    %
    % Create gyroscope sensor object
    params = accelparams 
    
    % Parameters for simulated signal
    N = 1;       % Number of samples
    Fs = 100;       % Sampling rate
    Fc = 0.25;      % Sinusoidal frequency
    
    
    % Create arrays
    t = (0:(1/Fs):((N-1)/Fs)).';
    acc = acc;          %Input accelerations
    orient = quaternion.ones(N, 1);
    angvel = angvel;
    
    % Generate acceleration data
    imu = imuSensor('SampleRate', Fs, 'Accelerometer', params);
    imu.Accelerometer.MeasurementRange = 10;   % Maximum acceleration accelerometer can measure
    imu.Accelerometer.Resolution = 1/Fs;           % Step size of digital measurements
    
    % Biases
    imu.Accelerometer.BiasInstability = 7.5 / 1000 * 9.81;
    imu.Accelerometer.NoiseDensity = 150 / 1000 / 1000 * 9.81; 
    imu.Accelerometer.TemperatureBias = 50 / 1000 / 1000 * 9.81;
    
  
    
    accelData = imu(acc, angvel, orient);
    
    accelData(:,3) = accelData(:,3) - 9.81

    accelData(:,1) = accelData(:,1) * -1
    accelData(:,2) = accelData(:,2) * -1
    accelData(:,3) = accelData(:,3) * -1

end
