function [W] = build_similarity_graph(X, graph_param, graph_similarity_function)
%  [W] = build_similarity_graph(X, graph_param, graph_similarity_function)
%      Computes the similarity matrix for a given dataset of samples.
%
%  Input
%  X:
%      (n x m) matrix of m-dimensional samples
%  graph_param:
%      structure containing the graph construction parameters as fields
%  graph_param.graph_type:
%      knn or eps graph, as a string, controls the graph that
%      the function will produce
%  graph_param.graph_thresh:
%      controls the main parameter of the graph, the number
%      of neighbours k for k-nn, and the threshold eps for epsilon graphs
%  graph_param.sigma2:
%      the sigma value for the exponential function, already squared
%  graph_similarity_function:
%      the similarity function between points, defaults to inverse exponential.
%
%  Output
%  W:
%      (n x n) dimensional matrix representing the adjacency matrix of the graph


if nargin < 2
    error('build_similarity_graph: not enough arguments')
elseif nargin > 2
    error('build_similarity_graph: too many arguments')
end

% unpack the type of the graph to build and the respective      %
% threshold and similarity function options                     %

graph_type = graph_param.graph_type;
graph_thresh = graph_param.graph_thresh; % the number of neighbours for the graph
sigma2 = graph_param.sigma2; % exponential_euclidean's sigma^2

if nargin < 3
    graph_similarity_function = @exponential_euclidean;
end

similarities = graph_similarity_function(X, sigma2);

n = size(X,1);

W = zeros(n,n);

if strcmp(graph_type,'knn') == 1

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  compute a k-nn graph from the similarities                   %
    %  for each node x_i, a k-nn graph has weights                  %
    %  w_ij = d(x_i,x_j) for the k closest nodes to x_i, and 0      %
    %  for all the k-n remaining nodes                              %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    [D,I] = sort(similarities,2,'descend');

    i_index = I(:, 1:graph_thresh);
    j_index = repmat([1:n]', 1,graph_thresh);
    z_values = D(:, 1:graph_thresh);

    W(sub2ind(size(W),j_index(:),i_index(:))) = z_values(:);
    W(sub2ind(size(W),i_index(:),j_index(:))) = z_values(:);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

elseif strcmp(graph_type,'eps') == 1

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  compute an epsilon graph from the similarities               %
    %  for each node x_i, an epsilon graph has weights              %
    %  w_ij = d(x_i,x_j) when w_ij > eps, and 0 otherwise           %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    W(similarities >= graph_thresh) = similarities(similarities >= graph_thresh);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

else

    error('build_similarity_graph: not a valid graph type')

end
