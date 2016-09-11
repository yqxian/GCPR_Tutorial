
%% loading data
load('../data/data_AWA');
[train_X, xval_mean, xval_variance, xval_max] = normalization(train_X);
[trainval_X, xtest_mean, xtest_variance, xtest_max] = normalization(trainval_X);
val_X = normalization(val_X, xval_mean, xval_variance, xval_max);
test_X = normalization(test_X, xtest_mean, xtest_variance, xtest_max);

%% Train the model using train+val data with the eta and K selected on the validation set
disp('Load the model...');
load('../models/model_sje_AWA.mat');
[acc_test, per_class_acc, conf_mat] = sje_test(W, test_X, test_Y('cont'), test_labels);
disp(['Mean class accuracy=' num2str(acc_test)]);

show_conf_mat(conf_mat, per_class_acc, 'testclasses.txt');