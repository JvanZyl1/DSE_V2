clear all
close all
clc

[pid_Mx, pid_My, pid_Mz] = angular_tune(2,2,2);
% Option 1 use to generate lookup table
% Option 2 use in loop to output new gains
% Option 3 use for primary gain tuning
% Option 4 use in a neural network training scenairo;