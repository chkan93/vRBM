N = 10;

load ./mat_data/mnist_classify.mat
image_num = N*max(testlabels);
images = cell(1, image_num);
labels = cell(1, image_num);
root = './generated_data/selected_mnist/';

for i = 1:max(testlabels)
    idx = randsample(find(testlabels == i), N);
    for j = 1:N
       pos = (i-1)*N+j;
       images{pos} = testdata(idx(j), :) > 0.5;
       labels{pos} = testlabels(idx(j));
    end
end


for i=1:image_num
   export_data_asit(strcat(root, 'image_', num2str(i),'.txt'),...
       images{i}); 
   export_data_asit(strcat(root, 'label_', num2str(i),'.txt'),...
       labels{i}); 
end


save(strcat(root, 'matdata.mat'), 'images', 'labels')
