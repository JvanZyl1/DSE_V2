
% Create gyroscope sensor object
params = gyroparams         

% Parameters for simulated signal
N = 1000;       % Number of samples
Fs = 100;       % Sampling rate
Fc = 0.25;      % Sinusoidal frequency

% Create arrays
t = (0:(1/Fs):((N-1)/Fs)).';
acc = zeros(N, 3);          %Input accelerations
angvel = zeros(N, 3);
angvel(:,1) = 8*sin(2*pi*Fc*t);

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
acc(:,1) = 1;
[~, gyroData] = imu(acc, angvel);



% Plot simulated signal
figure
plot(t, angvel(:,1), '--', t, gyroData(:,1))
xlabel('Time (s)')
ylabel('Angular Velocity (rad/s)')
title('Ideal Gyroscope Data')
legend('x (ground truth)', 'x (gyroscope)')



