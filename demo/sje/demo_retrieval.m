function demo_retrieval(class_name, n_nearest)


model = '../models/model_sje_cont_AWA.mat';
data = '../data/data_AWA_cont.mat';

load(model);
load(data);
imageroot = '/Users/yxian/Desktop/GCPR_tutorial/demo/images/';
save(data, 'imageroot', 'img_list', 'test_classnames', 'test_labels', 'test_X', 'test_Y');

[~, idx_class] = ismember(class_name, test_classnames);
n_testclasses = size(test_Y, 2);
best_matches = {};


P = test_X * W;
S = P * test_Y;

[S_sorted, idx] = sort(S, 1, 'descend');
best_matches = idx(1:n_nearest, :);
    
matched_imglist = {};
count = 1;

for l=1:n_nearest
    img_path = strcat(imageroot,img_list{best_matches(l,idx_class)});
    %disp(img_path);
    matched_imglist{count} = img_path;
    count = count + 1;
end
%plot 
show_images(matched_imglist, 1, n_nearest, S_sorted(1:n_nearest, idx_class));