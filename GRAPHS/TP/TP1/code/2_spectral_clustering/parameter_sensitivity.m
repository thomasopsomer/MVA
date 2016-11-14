function [] = parameter_sensitivity(graph_type)
%  [] = parameter_sensitivity()
% parameter_sensitivity
%       a skeleton function to test spectral clustering
%       sensitivity to parameter choice

% the number of samples to generate
num_samples = 500;

% the sample distribution function with the options necessary for
% the distribution
sample_dist = @two_moons;
dist_options = [1, 0.02];  % two moons: radius of the moons, variance of the moons

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the experiment parameter                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin < 1
    graph_type = 'knn';
end

graph_param.graph_type = graph_type ; %'knn' or 'eps'
graph_param.sigma2 = 1; % exponential_euclidean's sigma^2

laplacian_normalization = 'unn'; %either 'unn'normalized, 'sym'metric normalization or 'rw' random-walk normalization
chosen_eig_indices = [1,2]; % indices of the ordered eigenvalues to pick

if strcmp(graph_type, 'knn')
    parameter_candidate = 1:2:50;
else
    parameter_candidate = 0.1:0.05:1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parameter_performance = zeros(1, size(parameter_candidate, 2));
for i = 1:length(parameter_candidate)

    graph_param.graph_thresh = parameter_candidate(i); 

    [X, Y] = get_samples(sample_dist, num_samples, dist_options);

    % automatically infer number of labels from samples
    num_classes = length(unique(Y));

    L =  build_laplacian(X, graph_param, laplacian_normalization);

    Y_rec = spectral_clustering(L, chosen_eig_indices, num_classes);

    parameter_performance(i) = ari(Y,Y_rec);
end

plot(parameter_candidate, parameter_performance);
title('parameter sensitivity')


