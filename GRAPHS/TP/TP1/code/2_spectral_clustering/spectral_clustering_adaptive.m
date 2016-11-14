function [Y] = spectral_clustering_adaptive(L, num_classes)
%  [Y] = spectral_clustering_adaptive(L, num_classes)
%      a skeleton function to perform spectral clustering, needs to be completed
%
%  Input
%  L:
%      Graph Laplacian (standard or normalized)
%  num_classes:
%      number of clusters to compute (defaults to 2)
%
%  Output
%  Y:
%      Cluster assignments

if nargin < 2
    num_classes = 2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute eigenvectors                                      %%%%%
% U = (n x n) eigenvector matrix                            %%%%%
% E = (n x n) eigenvalue diagonal matrix                    %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [U,E] = eig(L);
[U,E] = eigs(L, n, 'sm');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[eigenvalues_sorted,reorder] = sort(diag(E));

chosen_eig_indices = choose_eig_function(eigenvalues_sorted);

U = U(:,reorder(chosen_eig_indices));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute the clustering assignment from the eigenvector    %%%%%
% Y = (n x 1) cluster assignments [1,2,...,c]               %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y = kmeans(U,num_classes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
