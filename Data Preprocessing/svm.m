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
for apl = 2:44
    %% OVA Train
    
    test_vector = X(apl,:);
    train_vector = X([1:apl-1,apl+1:45],:);
    train_label = y([1:apl-1,apl+1:45]);
    
    warning('off');
    m = length(unique(y));
    SVMStruct = cell(m,m);

    for i = 1:m
        for j = i+1:m
            idx_train  = ((train_label == i) | (train_label == j));
            train_vector_ova = train_vector(idx_train,:);
            train_label_ova = train_label(idx_train);

            SVMStruct{i,j} = svmtrain(train_vector_ova,train_label_ova,...
                    'autoscale', 'false', ...
                    'boxconstraint', 32 .* ones(size(train_vector_ova,1), 1),...
                    'kernelcachelimit', 10e5,...
                    'kernel_function','rbf',...
                    'rbf_sigma', 32);       
        end
    end 

    y_pred = zeros(1,(m*(m-1)/2));
    svm_cnt = 1;
    for i = 1:m
        for j = i+1:m
            y_pred(:,svm_cnt) = svmclassify(SVMStruct{i,j},test_vector);
            svm_cnt = svm_cnt+1;
        end
    end 
    pred(apl-1) = mode(y_pred,2);
end
ccr = sum(pred==y(2:44))/43;
conf = confusionmat(pred,y(2:44));
