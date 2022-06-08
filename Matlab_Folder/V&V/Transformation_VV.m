clear all
close all
clc

random = rand(1,6, "single");
a = random(1)*pi;
b = random(2)*pi;
c = random(3)*pi;
d = random(4)*pi;
e = random(5)*pi;
f = random(6)*pi;
thetad = [a; b; c];
thetaV = [a; e; f];

i = 4;
if i == 1
    %Unit Test 1 - transpose disturbed angles.
    thetad = transpose(thetad);
    error('Unit Test 1 - passed')
    sim('Transformation_V', 2);
elseif i == 2
    %Unit Test 2 - transpose vertiport angles.
    thetaV = transpose(thetaV);
    error('Unit Test 2 - passed')
    sim('Transformation_V', 2);
elseif i == 3
    %Unit Test 3 - no distrubed angles.
    clear thetad
    error('Unit Test 3 - passed')
    sim('Transformation_V', 2);
elseif i == 4
    %Unit Test 4 - no vertiport angles.
    clear thetaV
    error('Unit Test 4 - passed')
    sim('Transformation_V', 2);
end


