clc;
clear;
close all;

px = 6; py = 3; pc = 27;
[x y] = meshgrid(-5:0.5:5);
z = 6*x+3*y+27;

figure;
mesh(x,y,z)

xlabel("x");
ylabel("y");
zlabel("z");

Np = [-px/pc, -py/pc, 1/pc];
N0 = [0, 0, 1];

XYZ = [x(:),y(:),z(:)];
rot_vector = cross(Np/norm(Np),[0,0,1]);
angle = asind(norm(rot_vector))

[XYZnew, R, t] = AxelRot(XYZ', angle, rot_vector, []);

X =(XYZnew(1,:))';
Y = (XYZnew(2,:))';
Z = (XYZnew(3,:))';

[x y] = meshgrid(X,Y);
f = scatteredInterpolant(X,Y,Z);
z = f(x,y);

figure;
surf(x,y,z) %interpolated
zlim([3 5]);
zticks(3:1:5);

