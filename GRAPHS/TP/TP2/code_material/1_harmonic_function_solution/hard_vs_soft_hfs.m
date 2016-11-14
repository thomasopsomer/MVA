function [accuracy] = hard_vs_soft_hfs()
% [accuracy] = hard_vs_soft_hfs()
% a skeleton function to confront hard vs soft HFS, needs to be completed


% load the data
in_data = load('data_2moons_hfs.mat');
X = in_data.X;
Y = in_data.Y;

% automatically infer number of labels from samples
num_classes = length(unique(Y));
num_samples = length(Y);

% randomly sample 20 labels
l = 20;
% mask labels
Y_masked =  mask_labels(Y, l);
Y_masked(Y_masked ~= 0) = label_noise(Y_masked(Y_masked ~= 0), 4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the experiment parameter                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_type = ; %'knn' or 'eps'
graph_param.graph_thresh = ; % the number of neighbours for the graph or the epsilon threshold
graph_param.sigma2 = ; % exponential_euclidean's sigma^2

laplacian_param.normalization = ; %either 'unn'normalized, 'sym'metric normalization or 'rw' random-walk normalization
laplacian_param.regularization = ; %regularization to add to the laplacian (\gamma_g)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute hfs solution using soft_hfs.m and hard_hfs.m          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hard_labels = ;
soft_labels = ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y_masked(Y_masked == 0) = Y(Y_masked == 0);

plot_classification_comparison(X, Y_masked, graph_param, hard_labels, soft_labels);
accuracy = [mean(hard_labels == Y); mean(soft_labels == Y)];
