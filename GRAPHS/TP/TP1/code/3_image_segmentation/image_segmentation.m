function [] = image_segmentation(input_img, input_ext)
%  [] = image_segmentation(input_img, input_ext)
%      a skeleton function to perform image segmentation, needs to be completed
%  Input
%  input_img:
%      (string) name of the image file, without extension (e.g. 'four_elements')
%  input_ext:
%      (string) extension of the image file (e.g. 'bmp')

X = double(imread(input_img,input_ext));
X = reshape(X,[],3);

im_side = sqrt(size(X,1));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Y_rec should contain an index from 1 to c where c is the      %
% number of segments you want to split the image into           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% graph & laplacian params
graph_param.graph_type = 'knn'; %'knn' or 'eps'
graph_param.graph_thresh = 45; % the number of neighbours for the graph or the epsilon threshold
graph_param.sigma2 = 5; % exponential_euclidean's sigma^2
laplacian_normalization = 'rw';

% build laplacian
L =  build_laplacian(X, graph_param, laplacian_normalization);

% compute first 10 eigenvalues
[U,E] = eigs(L, 10, 'sm');

% use eigenvalues to find number of cluster
chosen_eig_indices = choose_eig_function(diag(E));
num_classes = size(chosen_eig_indices, 2);

% % Plot first 10 eigenvalues for debug of nb of cluster
% figure;
% plot(1:10, diag(E), '-o', 'lineWidth', 2)
% title('First 10 eigenvalues')
% xlabel('Id of eigenvalue')
% ylabel('Eigenvalue')

% keep the good eigenvector for clustering
U = U(:,chosen_eig_indices);

% compute the clustering assignment from the eigenvector        %
Y_rec = kmeans(U,num_classes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure()

subplot(1,2,1);
imagesc(imread(input_img,input_ext));
axis square;

subplot(1,2,2);
imagesc(reshape(Y_rec,im_side,im_side));
axis square;
end


