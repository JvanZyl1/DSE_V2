function [T_dt] = Tdt(theta, phi, psi)

a = cos(theta)*cos(psi);
b = cos(theta)*sin(psi);
c = - sin(theta);
d = sin(phi)*sin(theta)*cos(psi) - cos(phi)*sin(psi);
e = sin(phi)*sin(theta)*sin(psi) + cos(phi)*cos(psi);
f = sin(phi)*cos(theta);
g = cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi);
h = cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi);
i = cos(phi)*cos(theta);

T_dt = [a b c;
    d e f;
    g h i];


end