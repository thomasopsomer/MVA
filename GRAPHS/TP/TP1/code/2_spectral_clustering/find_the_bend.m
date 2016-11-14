function [] = find_the_bend(graph_param, blob_var)
%  [] = find_the_bend()
%      a skeleton function for question 2.3 and following, needs to be completed
%

% Parse args
if nargin == 1
    blob_var = 0.03;
elseif nargin == 0
    blob_var = 0.03;
    graph_param.graph_type = 'knn'; %'knn' or 'eps'
    graph_param.graph_thresh = 15; % the number of neighbours for the graph or the epsilon threshold
    graph_param.sigma2 = 1; % exponential_euclidean's sigma^2
end


% the number of samples to generate
num_samples = 600;

% the sample distribution function with the options necessary for
% the distribution
sample_dist = @blobs;
dist_options = [4, blob_var, 0]; % blobs: number of blobs, variance of gaussian
%                                    blob, surplus of samples in first blob

[X, Y] = get_samples(sample_dist, num_samples, dist_options);

% automatically infer number of clusters from samples
num_classes = length(unique(Y));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the experiment parameter                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

laplacian_normalization = 'unn' ; %either 'unn'normalized, 'sym'metric normalization or 'rw' random-walk normalization

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% build the laplacian
L =  build_laplacian(X, graph_param, laplacian_normalization);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute first 15 eigenvalues and apply                        %
% eigenvalues: (n x 1) vector storing the first 15 eigenvalues  %
%               of L, sorted from smallest to largest           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

eigenvalues = eig(L);

figure;
plot(1:15, eigenvalues(1:15), '-o', 'lineWidth', 2)
title('First 15 eigenvalues')
xlabel('Id of eigenvalue')
ylabel('Eigenvalue')

% chosen_eig_indices = [1,2,3,4]; % indices of the ordered eigenvalues to pick
chosen_eig_indices = choose_eig_function(eigenvalues);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute spectral clustering solution using a non-adaptive     %
% method first, and an adaptive one after (see handout)         %
% Y_rec = (n x 1) cluster assignments [1,2,...,c]               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y_rec = spectral_clustering(L, chosen_eig_indices, num_classes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plot_the_bend(X, Y, L, Y_rec, eigenvalues);

