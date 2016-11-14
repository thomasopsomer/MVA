function [accuracy] = two_moons_hfs()
% [accuracy] = two_moons_hfs()
% a skeleton function to perform HFS, needs to be completed


% load the data

in_data = load('data_2moons_hfs.mat');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% at home, try to use the larger dataset (question 1.2)         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%in_data = load('data_2moons_hfs_large.mat');
%fprintf('using larger dataset!\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = in_data.X;
Y = in_data.Y;

% automatically infer number of labels from samples
num_classes = length(unique(Y));
num_samples = length(Y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the experiment parameter                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_type = ; %'knn' or 'eps'
graph_param.graph_thresh = ; % the number of neighbours for the graph or the epsilon threshold
graph_param.sigma2 = ; % exponential_euclidean's sigma^2

laplacian_param.normalization = ; %either 'unn'normalized, 'sym'metric normalization or 'rw' random-walk normalization
laplacian_param.regularization = ; %regularization to add to the laplacian (\gamma_g)

l = ;% number of labeled (unmasked) nodes provided to the hfs algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mask labels
Y_masked =  mask_labels(Y, l);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute hfs solution using either soft_hfs.m or hard_hfs.m    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

labels = ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_classification(X, Y, graph_param, labels);
accuracy = mean(labels == Y);
