
model = '../models/model_latEm_cont_AWA.mat';
data = '../data/data_AWA_cont.mat';
result_path = './AWA.html';


load(model);
load(data);

imageroot = '/Users/yxian/Desktop/GCPR_tutorial/demo/images/';

n_testclasses = length(unique(test_labels));
n_images = size(test_X, 1);

disp('Generate html file...');
%write the retrieved image names to a list file
fp = fopen(result_path, 'w');
fprintf(fp, '%s\n', '<html>');
fprintf(fp, '%s\n', '<body>');

best_matches = {};
K = length(W);
disp(['Retrieval for cont, '  num2str(K) ' matrices']);
for i=1:K
    Q = W{i} * test_Y;
    S = Q' * test_X';
    S2 = S(:);
    img_idx = repmat(1:n_images, n_testclasses, 1);
    img_idx = img_idx(:);
    [S_sorted, idx] = sort(S2, 'descend');
    img_idx = img_idx(idx);
    top200_idx = img_idx(1:200);
    %top200_idx = remove_duplicate(top200_idx);
    best_matches{i} = top200_idx(1:n_nearest);	
    %keyboard;
end
%keyboard;
matched_imglist = {};
count = 1;
for i=1:K
    fprintf(fp, '%s\n', strcat('<p> ','cont', ', W', num2str(i),' </p>'));
    for l=1:n_nearest
        img_path = strcat(imageroot,'/', img_list{best_matches{i}(l)});
        %img_path = strcat(imageroot,img_list{best_matches{i}(l)});
        fprintf(fp, '%s\n', strcat('<img src=''',img_path,''' width=224 height=224 />'));
        matched_imglist{count} = img_path;
        count = count + 1;
    end
end

    
fprintf(fp, '%s\n', '</html>');
fprintf(fp, '%s\n', '</body>');
fclose(fp);
