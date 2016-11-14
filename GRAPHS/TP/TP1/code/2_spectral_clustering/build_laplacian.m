function [L] =  build_laplacian(X, graph_param, laplacian_normalization)
%  [L] =  build_laplacian(X, graph_param, laplacian_normalization)
%      a skeleton function to construct a laplacian from data,
%      needs to be completed
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
%  laplacian_normalization:
%      string selecting which version of the laplacian matrix to construct
%      either 'unn'normalized, 'sym'metric normalization
%      or 'rw' random-walk normalization
%
%  Output
%  Y:
%      Cluster assignments

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% use the build_similarity_graph function to build the graph W  %
% W: (n x n) dimensional matrix representing                    %
%    the adjacency matrix of the graph                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

W = build_similarity_graph(X, graph_param);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% build the laplacian                                           %
% L: (n x n) dimensional matrix representing                    %
%    the Laplacian of the graph                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% build the diagonal degree matrix
D = zeros(size(W));
for i = 1:size(W, 1)
    D(i,i) = sum(W(i, :));
end

% build laplacien L = D - W

if strcmp(laplacian_normalization, 'unn')
    % Lun =D?W
    L = D - W;
elseif strcmp(laplacian_normalization, 'sym')
    %Lsym = D^(?1/2)LD^(?1/2) = I ? D^(?1/2)WD^(?1/2)
    L = eye(size(W)) - D^(-1/2) * W * D^(-1/2);
elseif strcmp(laplacian_normalization, 'rw')
    % Lrw = D^-1L = I ? D^(?1)W
    L = eye(size(W)) - D^(-1) * W;
else
    error('unkown normalization mode')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
