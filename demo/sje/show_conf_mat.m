function show_conf_mat(conf_mat, per_class_acc, classnames_path)

classnames = textread('testclasses.txt','%s\n');

for i=1:numel(classnames)
    disp([classnames{i} ' accuracy=' num2str(per_class_acc(i))]);
end
figure;
imagesc(conf_mat);

colormap('hot');
set(gca, 'XTick', 1:10, 'XTickLabel', classnames);
set(gca, 'YTick', 1:10, 'YTickLabel', classnames);