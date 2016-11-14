function [] = how_to_choose_epsilon(dos)
%  [] = how_to_choose_epsilon()
%       a skeleton function to analyze the influence of the graph structure
%       on the epsilon graph matrix, needs to be completed

if nargin == 0
    dos = 1;
end

% the number of samples to generate
num_samples = 100;

% the sample distribution function
sample_dist = @worst_case_blob;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% the option necessary for worst_case_blob, try different       %
% values                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dist_options = dos; % read worst_case_blob.m to understand the meaning of
%                               the parameter

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X, Y] = get_samples(sample_dist, num_samples, dist_options);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use the similarity function and the max_span_tree function    %
% to build the maximum spanning tree max_tree                   %
% sigma2: the exponential_euclidean's sigma2 parameter          %
% similarities: (n x n) matrix with similarities between        %
%              all possible couples of points                   %
% max_tree: (n x n) indicator matrix for the edges in           %
%           the maximum spanning tree                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sigma2 = 0.1; % exponential_euclidean's sigma^2

similarities = exponential_euclidean(X, sigma2) ;
max_tree = max_span_tree(similarities);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set graph_thresh to the minimum weight in max_tree            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmp = max_tree .* similarities;
graph_thresh = min(similarities(tmp > 0));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_type = 'eps';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use the build_similarity_graph function to build the graph W  %
% W: (n x n) dimensional matrix representing                    %
%    the adjacency matrix of the graph                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_thresh = graph_thresh; % the number of neighbours for the graph
graph_param.sigma2 = sigma2; % exponential_euclidean's sigma^2

W = build_similarity_graph(X, graph_param);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_graph_matrix(X,W);
end