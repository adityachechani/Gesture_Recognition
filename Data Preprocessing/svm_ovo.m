clc;
clear all;
shapes = ["circle";"rectangle";"triangle"];
X= zeros(40,45);
for i = 1:45
    fname = char(strcat(shapes(ceil(i/15)),"/",shapes(ceil(i/15)),string((mod(i,15)==0)*1 + ~(mod(i,15)==0)*mod(i,15)),".json"));
    [X_d,Y_d]= lsf(fname);
    S = X_d + 1i* Y_d;
    ft = fftshift(fft(S,1024));
    a =(fftshift(ft(493:532)));
    X(:,i) = abs(a);
end
X = X';
y = [1*ones(1,15),2*ones(1,15),3*ones(1,15)]';
pred = zeros(43,1);
