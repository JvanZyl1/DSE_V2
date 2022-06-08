%% create MPC controller object with sample time
mpc1 = mpc(plant_C, 0.1);
%% specify prediction horizon
mpc1.PredictionHorizon = 10;
%% specify control horizon
mpc1.ControlHorizon = 2;
%% specify nominal values for inputs and outputs
mpc1.Model.Nominal.U = [0;0;0];
mpc1.Model.Nominal.Y = [0;0;0];
%% specify constraints for OV
mpc1.OV(1).Min = -1.5707963267949;
mpc1.OV(1).Max = 1.5707963267949;
mpc1.OV(2).Min = -1.5707963267949;
mpc1.OV(2).Max = 1.5707963267949;
mpc1.OV(3).Min = -1.5707963267949;
mpc1.OV(3).Max = 1.5707963267949;
%% specify overall adjustment factor applied to weights
beta = 2.9447;
%% specify weights
mpc1.Weights.MV = [0 0 0]*beta;
mpc1.Weights.MVRate = [0.1 0.1 0.1]/beta;
mpc1.Weights.OV = [1 1 1]*beta;
mpc1.Weights.ECR = 100000;
%% specify simulation options
options = mpcsimopt();
options.RefLookAhead = 'off';
options.MDLookAhead = 'off';
options.Constraints = 'on';
options.OpenLoop = 'off';
%% run simulation
sim(mpc1, 101, mpc1_RefSignal, mpc1_MDSignal, options);
