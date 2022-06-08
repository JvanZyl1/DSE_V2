function [newposition] = gps(position)

    % Input: position
    % Output: position with gps accuracies inclduded
    mu = 0; 
    sigma = 0.15;

    r1 = normrnd(mu, sigma);
    r2 = normrnd(mu, sigma);
    r3 = normrnd(mu, sigma);

    newposition = [0,0,0];

    newposition(1) = position(1) + r1;
    newposition(2) = position(2) + r2;
    newposition(3) = position(3) + r3;

end