function [Y] = spectral_clustering(L, chosen_eig_indices, num_classes)
%  [Y] = spectral_clustering(L, chosen_eig_indices, num_classes)
%      a skeleton function to perform spectral clustering, needs to be completed
%
%  Input
%  L:
%      Graph Laplacian (standard or normalized)
%  chosen_eig_indices:
%      indices of eigenvectors to use for clustering
%  num_classes:
%      number of clusters to compute (defaults to 2)
%
%  Output
%  Y:
%      Cluster assignments

if nargin < 3
    num_classes = 2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute eigenvectors                                          %
% U = (n x n) eigenvector matrix                                %
% E = (n x n) eigenvalue diagonal matrix                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(chosen_eig_indices, 2);

% [U,E] = eig(L);
[U,E] = eigs(L, n, 'sm');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[eigenvalues_sorted, reorder] = sort(diag(E));

U = U(:,reorder(chosen_eig_indices));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute the clustering assignment from the eigenvector        %
% Y = (n x 1) cluster assignments [1,2,...,c]                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Y = ;
Y = kmeans(U,num_classes);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
