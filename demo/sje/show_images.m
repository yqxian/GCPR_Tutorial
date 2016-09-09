function show_images(img_list, n_row, n_col, score)

n_img = length(img_list);

count = 1;
for i=1:n_row
  for j=1:n_col
    model_img = imread(img_list{count});
    subplot(n_row, n_col, (i-1)*n_col+j);
    imagesc(model_img);
    title(['Score: ' num2str(score((i-1)*n_row+j))]);
    count = count + 1;
  end
end

print(1,'-dpdf','W1.pdf');
