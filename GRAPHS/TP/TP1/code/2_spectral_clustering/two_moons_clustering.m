function [] = two_moons_clustering(graph_param, chosen_eig_indices)
%  [] = two_moons_clustering()
%       a skeleton function for questions 2.7

% load the data

in_data = load('data_2moons.mat', '-mat');
X = in_data.X;
Y = in_data.Y;

% automatically infer number of labels from samples
num_classes = length(unique(Y));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the experiment parameter                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 0
    graph_param.graph_type = 'knn'; %'knn' or 'eps'
    graph_param.graph_thresh = 7; % the number of neighbours for the graph or the epsilon threshold
    graph_param.sigma2 = 1; % exponential_euclidean's sigma^2
    chosen_eig_indices = [1,2];
elseif nargin == 1
    chosen_eig_indices = [1,2];
end

laplacian_normalization = 'sym'; %either 'unn'normalized, 'sym'metric normalization or 'rw' random-walk normalization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% build laplacian
L =  build_laplacian(X, graph_param, laplacian_normalization);

Y_rec = spectral_clustering(L, chosen_eig_indices, num_classes);

plot_clustering_result(X, Y, L, Y_rec, kmeans(X, num_classes));

