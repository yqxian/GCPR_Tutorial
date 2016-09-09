function W = sje_train(X, labels, Y, eta, n_epoch)

n_train = size(X,1);

%% Initialization
W = 1.0/sqrt(size(X, 2)) * randn(size(X, 2), size(Y, 1));

%% SGD optimization for LatEm
for e=1:n_epoch
    perm = randperm(n_train);
    for i = 1:n_train
        ni = perm(i);
        scores = X(ni,:) * W * Y;
        scores(labels(ni)) = scores(labels(ni)) - 1;
        [~, max_idx] = max(scores);
        if(max_idx ~= labels(ni))
            W = W + eta * X(ni,:)' * (Y(:,labels(ni)) - Y(:,max_idx))';
        end
    end
    acc_test = sje_test(W, X, Y, labels);
    disp(['Epoch ' num2str(e) ', train: mean class accuracy=' num2str(acc_test)]);
end