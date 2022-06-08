%
% Create gyroscope sensor object
params = accelparams 

% Parameters for simulated signal
N = 1;       % Number of samples
Fs = 100;       % Sampling rate
Fc = 0.25;      % Sinusoidal frequency


% Create arrays
t = (0:(1/Fs):((N-1)/Fs)).';
acc = [5,-5,-5];          %Input accelerations
orient = quaternion.ones(N, 1);
angvel = zeros(N, 3);
acc(:,1) = 8*sin(2*pi*Fc*t);

% Generate acceleration data
imu = imuSensor('SampleRate', Fs, 'Accelerometer', params);
imu.Accelerometer.MeasurementRange = 15;   % Maximum acceleration accelerometer can measure
imu.Accelerometer.Resolution = 1/Fs;           % Step size of digital measurements

% Biases
imu.Accelerometer.BiasInstability = 150 / 1000;
imu.Accelerometer.NoiseDensity = 300 / 1000 / 1000;
imu.Accelerometer.TemperatureBias = 50 / 1000 / 1000;



accelData = imu(acc, angvel, orient);
accelData = accelData * -1

% Plot simulated signal
figure
plot(t, acc(:,1), t, accelData(:,1))
xlabel('Time (s)')
ylabel('Acceleratio (m/s^2)')
legend('x (ground truth)', 'x (gyroscope)')
title('Acceleration Data')
