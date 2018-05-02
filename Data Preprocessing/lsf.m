function [ X,Y ] = lsf( fname )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

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
f=fit([x,y],z,'poly11','Normalize','on','Robust','Bisquare');
coeffs = coeffvalues(f);
pc = coeffs(1);
px = coeffs(2);
py = coeffs(3);

Np = [-px/pc, -py/pc, 1/pc];
N0 = [0, 0, 1];

XYZ = [x(:),y(:),z(:)];
rot_vector = cross(Np/norm(Np),[0,0,1]);
angle = asind(norm(rot_vector));

[XYZnew, R, t] = AxelRot(XYZ', angle, rot_vector, []);
X =(XYZnew(1,:))';
Y = (XYZnew(2,:))';
Z = (XYZnew(3,:))';
end

