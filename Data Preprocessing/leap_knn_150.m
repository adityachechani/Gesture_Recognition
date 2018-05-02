clc;
clear all;
shapes = ["circle";"rectangle";"triangle"];
X= zeros(40,150);
for i = 1:150
    fname = char(strcat(shapes(ceil(i/50)),"/",shapes(ceil(i/50)),string((mod(i,50)==0)*1 + ~(mod(i,50)==0)*mod(i,50)),".json"));
    [X_d,Y_d]= lsf(fname);
    S = X_d + 1i* Y_d;
    ft = fftshift(fft(S,1024));
    a =(fftshift(ft(493:532)));
    X(:,i) = abs(a);
end
X = X';
y = [1*ones(1,50),2*ones(1,50),3*ones(1,50)]';
t = (1:150)';
a =[ones(30,1);zeros(20,1)];
a1 = a(randperm(length(a)));
a2 = a(randperm(length(a)));
a3 = a(randperm(length(a)));
train_idx = logical([a1;a2;a3]);
% load bestinx.mat
test_idx = ~train_idx;
Xtrain = X(train_idx,:);
Xtest = X(test_idx,:);
ytrain = y(train_idx);
ytest= y(test_idx);


    XX= sum(Xtrain.*Xtrain,2);
    XXdash = 2 * Xtrain * Xtest';
    distance = XX-XXdash;
   [v,idx] = min(distance);
    pred = ytrain(idx);
%     [v,i]= sort(distance,'ascend');
%     pred = (mode(ytrain(i(1:3,:))))';
ccr = sum(pred==ytest)/length(ytest);
conf = confusionmat(pred,ytest);



