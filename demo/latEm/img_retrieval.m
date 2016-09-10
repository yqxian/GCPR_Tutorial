

model = '../models/model_latEm_cont_AWA.mat';
data = '../data/data_AWA_cont.mat';
result_path = './AWA.html';

load(model);
load(data);

imageroot = '/Users/yxian/Desktop/GCPR_tutorial/demo/images/';


n_nearest = 5;
K = length(W);
n_testclasses = size(test_Y, 2);
best_matches = {};

disp(['Retrieval for ' num2str(K) ' matrices']);
for i=1:K
	Q = W{i} * test_Y;
	S = Q' * test_X';
	[S_sorted, idx] = sort(S, 2, 'descend');
	best_matches{i} = idx(:, 1:n_nearest);	
end
matched_imglist = {};
count = 1;
disp('Generate html file...');
%write the retrieved image names to a list file
fp = fopen(result_path, 'w');
fprintf(fp, '%s\n', '<html>');
fprintf(fp, '%s\n', '<body>');
for i=1:K
	fprintf(fp, '%s\n', strcat('<p> W',num2str(i),' </p>'));
	for j=1:n_testclasses
		fprintf(fp, '%s\n', strcat('<p> ',test_classnames{j},' </p>'));
		for l=1:n_nearest
			img_path = strcat(imageroot,img_list{best_matches{i}(j,l)});
			fprintf(fp, '%s\n', strcat('<img src=''',img_path,''' width=224 height=224 />'));
			matched_imglist{count} = img_path;
			count = count + 1;
		end
	end
end
fprintf(fp, '%s\n', '</html>');
fprintf(fp, '%s\n', '</body>');
fclose(fp);
%plot 
%show_images(matched_imglist, 10, n_nearest);
