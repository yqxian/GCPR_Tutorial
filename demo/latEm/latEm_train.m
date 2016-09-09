function W = latEm_train(X, labels, Y, eta, n_epoch, K)
%
% Code for training latEm(algorithm 1 in the paper) described in  
% Y. Xian, Z. Akata, G. Sharma, Q. Nguyen, M. Hein, B. Schiele. 
% Latent Embeddings for Zero-shot Classification. IEEE CVPR 2016.
% Cite the above paper if you are using this code.
%
% Usage: [W] = latEm_train(X, labels, Y, eta, n_epoch, K)
%
% Inputs:
%   X:                  images embedding matrix, each row is an image instance
%   Y:                  class embedding matrix, each col is for a class
%   labels:             ground truth labels of all image instances
%   eta:                learning rate for SGD algorithm
%   n_epoch:            number of epochs for SGD algorithm
%   K:                  number of embeddings to learn
%
%
% Outputs:
%   W:                  a cell array with K embeddings
%
%
% Yongqin Xian
% e-mail: yxian@mpi-inf.mpg.de
% Computer Vision and Multimodal Computing, Max Planck Institute Informatics
% Saarbruecken, Germany
% http://d2.mpi-inf.mpg.de
%

n_train = size(X,1);
n_class = size(Y,2);

%% Initialization
W = {};
for i=1:K
    W{i} = 1.0/sqrt(size(X, 2)) * randn(size(X, 2), size(Y, 1));
end
%% SGD optimization for LatEm
for e=1:n_epoch
    perm = randperm(n_train);
    for i = 1:n_train
        ni = perm(i);
        best_j = -1;
        picked_y = labels(ni);
        while(picked_y==labels(ni))
            picked_y =  randi(n_class);
        end
        [max_score, best_j] = argmaxOverMatrices(X(ni,:), Y(:,picked_y), W);
        [best_score_yi, best_j_yi] = argmaxOverMatrices(X(ni,:), Y(:,labels(ni)), W);
        if(max_score + 1 > best_score_yi)
            if(best_j==best_j_yi)
                W{best_j} = W{best_j} - eta * X(ni,:)' * (Y(:,picked_y) - Y(:,labels(ni)))';
            else
                W{best_j} = W{best_j} - eta * X(ni,:)' * Y(:,picked_y)';
                W{best_j_yi} = W{best_j_yi} + eta * X(ni,:)' * Y(:,labels(ni))';
            end
        end
    end
    acc_test = latEm_test(W, X, Y, labels);
    disp(['Epoch ' num2str(e) ', train: mean class accuracy=' num2str(acc_test)]);
end