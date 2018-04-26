clc;
clear all;
fid = fopen(char('rectangle.json')); 
raw = fread(fid,inf); 
str = char(raw'); 
fclose(fid); 
val = jsondecode(str);
x = val(:,1);
y = val(:,2);
z = val(:,3);
sf = fit([x, y],z,'poly11');


% figure;
% plot3(x,y,z)
% z = val(:,3);
% sf = fit([x, z],y,'poly11');
% figure;
% plot3(x,y,z);
% figure;
% plot(sf,[x,z],y)
x = (x- min(x))/(max(x)- min(x));
y = (y- min(y))/(max(y)- min(y));
figure;
plot(x,y)
s = x + 1i*y;
p = 165
s_dft = fft(s,p);
s_inv = ifft(s_dft,p);
% x_recon = real(s_inv);
% y_recon = imag(s_inv);
figure;
plot(s_inv)
% p =10;
% a = fftshift(s_dft);
% ind = round(((p)/100)*128);
% a_sort = sort((abs(a)),'descend');
% a(abs(a) <  a_sort(ind))=0;
% b = ifft(fftshift(a),512);
% figure;
% plot(b);
