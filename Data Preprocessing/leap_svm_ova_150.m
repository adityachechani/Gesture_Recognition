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

load bestinx
train_vector = X(train_idx,:);
test_vector = X(test_idx,:);
train_label = y(train_idx);
test_label= y(test_idx);
m = length(unique(train_label));
test_CCR = zeros(m,1);
a = zeros(2,2,m);
for class = 1:3
    
    train_label(train_label ~= class) = -1;
    train_label(train_label == class) = 1;
    test_label(test_label ~= class) = -1;
    test_label(test_label == class) = 1;

    warning('off');

        n_plus = sum(train_label == 1);
        n_minus = sum(train_label == -1);
        vector_compensated = length(train_label) .* ((train_label == 1)./n_plus + (train_label == -1)./n_minus);


    SVMStruct = svmtrain(train_vector,train_label,...
                'autoscale', 'false', ...
                'boxconstraint', 2 .* vector_compensated,...
                'kernelcachelimit', 10e5,...
                'kernel_function','rbf',...
                'rbf_sigma', 16);  
    y_pred = svmclassify(SVMStruct,test_vector);
    test_CCR(class) = mean(test_label==y_pred);
 a(:,:,class) = confusionmat(test_label, y_pred);
train_label = y(train_idx);
test_label= y(test_idx);
disp(class)
end
