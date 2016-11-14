function [] = point_and_circle_clustering(laplacian_normalization)
%  [] = point_and_circle_clustering()
%       a skeleton function for questions 2.8

% load the data

in_data = load('data_pointandcircle.mat', '-mat');
X = in_data.X;
Y = in_data.Y;

% automatically infer number of labels from samples
num_classes = length(unique(Y));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the experiment parameter                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_type = 'knn'; %'knn' or 'eps'
graph_param.graph_thresh = 10; % the number of neighbours for the graph or the epsilon threshold
graph_param.sigma2 = 1; % exponential_euclidean's sigma^2

if nargin == 0
    laplacian_normalization = 'rw'; %either 'unn'normalized, 'sym'metric normalization or 'rw' random-walk normalization
end
chosen_eig_indices = 1:num_classes; % indices of the ordered eigenvalues to pick

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% build laplacian
L_unn =  build_laplacian(X, graph_param, 'unn');
L_norm =  build_laplacian(X, graph_param, laplacian_normalization);


Y_unn = spectral_clustering(L_unn, chosen_eig_indices, num_classes);
Y_norm = spectral_clustering(L_norm, chosen_eig_indices, num_classes);

plot_clustering_result(X, Y, L_unn, Y_unn, Y_norm, 1);
