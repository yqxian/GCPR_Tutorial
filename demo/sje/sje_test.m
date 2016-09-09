function [mean_class_accuracy, per_class_acc, conf_mat] = sje_test(W, X, Y, labels)

n_samples = length(labels);
n_class = length(unique(labels));

scores = X * W * Y;
[~, predict_label] = max(scores');


%compute the confusion matrix
label_mat = sparse(labels,1:n_samples,1,n_class,n_samples);
predict_mat = sparse(predict_label,1:n_samples,1,n_class, n_samples);

conf_mat = label_mat * predict_mat';

conf_mat_diag = diag(conf_mat);
n_per_class = sum(label_mat');


per_class_acc = conf_mat_diag ./ n_per_class';

%per class accuracy
mean_class_accuracy = sum(conf_mat_diag ./ n_per_class') / n_class;

