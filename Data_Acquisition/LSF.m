clc;
clear all;fname = 'rectangle.json';

fid = fopen(fname);
raw = fread(fid,inf);
str = char(raw');
fclose(fid);

val = jsondecode(str);
x = val(:,1);
y = val(:,2);
% z = val(:,3);

x = (x - min(x))/(max(x) - min(x));
y = (y - min(y))/(max(y) - min(y));
figure;
plot(x,y);
% x_fft = fft(x);
% y_fft = fft(y);
% 
% figure;
% plot(x, x_fft);
% 
% figure;
% plot(y, y_fft);
% sf = fit([x, z],y,'poly11');
% figure;
% plot3(x,y,z);
% figure;
% plot(sf,[x,z],y)