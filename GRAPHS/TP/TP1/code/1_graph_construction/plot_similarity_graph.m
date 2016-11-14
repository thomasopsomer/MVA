function [] = plot_similarity_graph(num_samples, sample_dist, graph_type, graph_thresh, sigma2)
%  [] = plot_similarity_graph()
%      a skeleton function to analyze the construction of the graph similarity
%      matrix, needs to be completed

% Parse args
switch nargin
    case 0
        num_samples = 300 ;
        sample_dist = 'blob';
        sigma2 = 1;
        graph_type = 'knn';
        graph_thresh = 5;
    case 1
        sample_dist = 'blob';
        sigma2 = 1;
        graph_type = 'knn';
        graph_thresh = 5;
    case 2
        sigma2 = 1;
        graph_type = 'knn';
        graph_thresh = 5;
    case 3
        graph_type = 'knn';
        graph_thresh = 5;
    case 4
        graph_thresh = 5;
end

% the sample distribution function with the options necessary for
% the distribution
if strcmp(sample_dist, 'blob') == 1
    sample_dist_fct = @blobs;
elseif strcmp(sample_dist, 'two_moons') == 1
    sample_dist_fct = @two_moons;
end


dist_options = [2, 1, 0]; % blobs: number of blobs, variance of gaussian
%                                    blob, surplus of samples in first blob

[X, Y] = get_samples(sample_dist_fct, num_samples, dist_options);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  choose the type of the graph to build and the respective     %
%  threshold and similarity function options                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_type = graph_type; %'knn' or 'eps'
graph_param.graph_thresh = graph_thresh; % the number of neighbours for the graph or the epsilon threshold
graph_param.sigma2 = sigma2; % exponential_euclidean's sigma^2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use the build_similarity_graph function to build the graph W  %
% W: (n x n) dimensional matrix representing                    %
%    the adjacency matrix of the graph                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W = build_similarity_graph(X, graph_param);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_graph_matrix(X,W);
