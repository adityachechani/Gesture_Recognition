clc;
clear all;
fname = 'triangle.json';

fid = fopen(fname);
raw = fread(fid,inf);
str = char(raw');
fclose(fid);

val = jsondecode(str);
x = val(:,1);
y = val(:,2);
z = val(:,3);

x = (x - min(x))/(max(x) - min(x));
y = (y - min(y))/(max(y) - min(y));
z = (z - min(z))/(max(z) - min(z));

figure;
f=fit([x,y],z,'poly11','Normalize','on','Robust','Bisquare');

coeffs = coeffvalues(f);
pc = coeffs(1);
px = coeffs(2);
py = coeffs(3);
plot( f, [x, y], z );
hold on
Z = pc + px.*x + py.*y;
plot3(x, y, Z, 'ro');
title(sprintf('Plotting plane z=(%f)*x+(%f)*y+(%f)',px, py, pc));

n = [px, py, -1];
m = [0, 0, -1];

n_mag = norm(n)
m_mag = norm(m)
d = dot(n,m)

theta = acos(1./n_mag)