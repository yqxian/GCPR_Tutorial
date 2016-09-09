function [mean_class_accuracy, per_class_acc, conf_mat] = latEm_test(W, X, Y, labels)
%
% Code for testing the performance of the latent embedding model described in  
% Y. Xian, Z. Akata, G. Sharma, Q. Nguyen, M. Hein, B. Schiele. 
% Latent Embeddings for Zero-shot Classification. IEEE CVPR 2016.
% Cite the above paper if you are using this code.
%
% Usage: [mean_class_accuracy] = latEm_test(W, X, Y, labels)
%
% Inputs:
%   W:                  latent embeddings
%   X:                  images embedding matrix, each row is an image instance
%   Y:                  class embedding matrix, each col is for a class
%   labels:             ground truth labels of all image instances
%
%
% Outputs:
%   mean_class_accuracy: the classification accuracy averaged over all classes
%
%
% Yongqin Xian
% e-mail: yxian@mpi-inf.mpg.de
% Computer Vision and Multimodal Computing, Max Planck Institute Informatics
% Saarbruecken, Germany
% http://d2.mpi-inf.mpg.de
%


all_scores = [];
n_samples = length(labels);
n_class = length(unique(labels));

K = length(W);
scores = cell(K,1);
max_scores = zeros(K, n_samples);
tmp_label = zeros(K, n_samples);

for j=1:K
    projected_X = X * W{j};
    scores{j} = projected_X * Y;
    [max_scores(j,:),tmp_label(j,:)] = max(scores{j}');
end

[best_scores,best_idx] = max(max_scores,[],1);
label_idx = sub2ind(size(tmp_label), best_idx, 1:n_samples);
predict_label = tmp_label(label_idx);


%compute the confusion matrix
label_mat = sparse(labels,1:n_samples,1,n_class,n_samples);
predict_mat = sparse(predict_label,1:n_samples,1,n_class, n_samples);

conf_mat = label_mat * predict_mat';

conf_mat_diag = diag(conf_mat);
n_per_class = sum(label_mat');

per_class_acc = conf_mat_diag ./ n_per_class';
%mean class accuracy
mean_class_accuracy = sum(conf_mat_diag ./ n_per_class') / n_class;

%per sample accuracy
mean_sample_accuracy = sum(conf_mat_diag) / n_samples;
