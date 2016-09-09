%% Set the parameters
param.eta = 1e-3;               %learning rate, should be tuned on the validation set
param.nepoch = 15;              %number of epochs, fixed
param.cls_emb = 'cont';         %name of class embedding to evaluate, you can also use 'glove', 'wordnet' and 'cont'

%% loading data
load('../data/data_AWA');
[train_X, xval_mean, xval_variance, xval_max] = normalization(train_X);
[trainval_X, xtest_mean, xtest_variance, xtest_max] = normalization(trainval_X);
val_X = normalization(val_X, xval_mean, xval_variance, xval_max);
test_X = normalization(test_X, xtest_mean, xtest_variance, xtest_max);

%% Train the model using train+val data with the eta and K selected on the validation set
disp('Train the model...');
disp(['eta=' num2str(param.eta) ', nepoch=' num2str(param.nepoch)]);
W = sje_train(trainval_X, trainval_labels, trainval_Y(param.cls_emb), param.eta, param.nepoch);
[acc_test, per_class_acc, conf_mat] = sje_test(W, test_X, test_Y(param.cls_emb), test_labels);
disp(['Test: mean class accuracy=' num2str(acc_test)]);

show_conf_mat(conf_mat, per_class_acc, 'testclasses.txt');