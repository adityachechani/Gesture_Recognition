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

XYZ = [x';y';z'];

N1 = [px/pc, py/pc, -1/pc];

% N1 = [1 -4 3]; % Normal vector to plane
N2= [0 0 -1]; % normal vector to x-y plane
cosang = dot(N1,N2); % actually n1.n2 = |n1||n2|cosang
angle = acosd((cosang / norm(N1)*norm(N2)));

XYZnew = AxelRot(XYZ, angle, [1 0 0],[]);
X =(XYZnew(1,:))';
Y = (XYZnew(2,:))';
end
