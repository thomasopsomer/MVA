function [Q] =  build_laplacian_regularized(X, graph_param, laplacian_param)
%  [Q] =  build_laplacian_regularized(X, graph_param, laplacian_param)
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
%  laplacian_param:
%      structure containing the laplacian construction parameters as fields
%  laplacian_param.normalization:
%      string selecting which version of the laplacian matrix to construct
%      either 'unn'normalized, 'sym'metric normalization
%      or 'rw' random-walk normalization
%  laplacian_param.regularization:
%      regularization to add to the laplacian (\gamma_g)

% build the similarity graph W
W = build_similarity_graph(X, graph_param);

% unpack the type of the laplacian normalization and regularization parameter
laplacian_normalization = laplacian_param.normalization;
laplacian_regularization = laplacian_param.regularization;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% build the laplacian                                           %
% L: (n x n) dimensional matrix representing                    %
%    the Laplacian of the graph                                 %
% Q: (n x n) dimensional matrix representing                    %
%    the laplacian with gamma_g regularization                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(laplacian_normalization, 'unn')
    ;
elseif strcmp(laplacian_normalization, 'sym')
    ;
elseif strcmp(laplacian_normalization, 'rw')
    ;
else
    error('unkown normalization mode')
end

Q = ;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
