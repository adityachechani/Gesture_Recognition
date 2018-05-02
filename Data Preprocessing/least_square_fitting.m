 clc;
clear all;
close all;
fname = 'rectangle/rectangle45.json';

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
scatter3(x,y,z) %interpolated

figure; %2
f=fit([x,y],z,'poly11','Normalize','on','Robust','Bisquare');

coeffs = coeffvalues(f);
pc = coeffs(1);
px = coeffs(2);
py = coeffs(3);
plot( f, [x, y], z );

XYZ = [x';y';z'];
title(sprintf('Plotting plane z=(%f)*x+(%f)*y+(%f)',px, py, pc));

Np = [-px/pc, -py/pc, 1/pc];
N0 = [0, 0, 1];

XYZ = [x(:),y(:),z(:)];
rot_vector = cross(Np/norm(Np),[0,0,1]);
angle = asind(norm(rot_vector));

[XYZnew, R, t] = AxelRot(XYZ', angle, rot_vector, []);
X =(XYZnew(1,:))';
Y = (XYZnew(2,:))';
Z = (XYZnew(3,:))';

figure; %3
plot3(x, y, z, 'r');
hold on
plot3(XYZnew(1,:) , XYZnew(2,:), XYZnew(3,:));
figure;%4
plot(x , y , 'r');
hold on
plot(XYZnew(1,:) , XYZnew(2,:));