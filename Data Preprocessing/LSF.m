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
plot3(x, y, z, 'ro');
xlabel('x');
ylabel('y');
zlabel('z');

figure;
% fitobject = fit([x,y],z,'lowess')
f=fit([x,y],z,'poly11','Normalize','on','Robust','Bisquare');
% T = table(x,y,z);

coeffs = coeffvalues(f)
pc = coeffs(1);
px = coeffs(2);
py = coeffs(3);
plot( f, [x, y], z );
% plot(f,x,y);

% Xcolv = x(:); % Make X a column vector
% 
% Ycolv = y(:); % Make Y a column vector
% 
% Zcolv = z(:); % Make Z a column vector
% 
% Const = ones(size(Xcolv)); % Vector of ones for constant term
% 
% Coefficients = [Xcolv Ycolv Const]\Zcolv; % Find the coefficients
% 
% XCoeff = Coefficients(1); % X coefficient
% 
% YCoeff = Coefficients(2); % X coefficient
% 
% CCoeff = Coefficients(3); % constant term
% 
% % Using the above variables, z = XCoeff * x + YCoeff * y + CCoeff
% 
% figure;
% L=plot3(x,y,z,'ro'); % Plot the original data points
% 
% set(L,'Markersize',2*get(L,'Markersize')) % Making the circle markers larger
% 
% set(L,'Markerfacecolor','r') % Filling in the markers
% 
% hold on
% 
% [xx, yy]=meshgrid(0:0.1:1,0:0.1:1); % Generating a regular grid for plotting
% 
% zz = XCoeff * xx + YCoeff * yy + CCoeff;
% 
% surf(xx,yy,zz) % Plotting the surface
% xlabel('x');
% ylabel('y');
% zlabel('z');
% 
% title(sprintf('Plotting plane z=(%f)*x+(%f)*y+(%f)',XCoeff, YCoeff, CCoeff))