%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Two blob clustering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load data to look at the graph
in_data = load('data_2blobs.mat', '-mat');
X = in_data.X;
Y = in_data.Y;

% %%% Q2.1 With Connected Graph

espilon = find_epsilon(X)

graph_param.graph_type = 'eps'; %'knn' or 'eps'
graph_param.graph_thresh = epsilon;
graph_param.sigma2 = 1; % exponential_euclidean's sigma^2

W = build_similarity_graph(X, graph_param);
plot_graph_matrix(X,W);

% clustering results
two_blobs_clustering(graph_param, [1])

% %%% Q2.2 With Not connected Graph
% just take a value for epsilon bigger than the optimal epsilon

graph_param.graph_type = 'eps';
graph_param.graph_thresh = epsilon;
graph_param.sigma2 = 1;

W = build_similarity_graph(X, graph_param);
plot_graph_matrix(X,W);

two_blobs_clustering(graph_param, [1])


% %%% Q2.3 - 4 blob - blob var 0.03

blob_var = 0.03;
graph_param.graph_type = 'eps';
graph_param.graph_thresh = 0.7;
graph_param.sigma2 = 1;

find_the_bend(graph_param, blob_var)

% %%% Q2.4 - 4 blob - blob var 0.20

blob_var = 0.20
% try with epsilon graph (but bad results :/) needs to find the good eps
% easier with knn
graph_param.graph_type = 'eps';
graph_param.graph_thresh = 0.7;
graph_param.sigma2 = 1;

find_the_bend(graph_param, blob_var)

% try with knn graph
graph_param.graph_type = 'knn';
graph_param.graph_thresh = 12;
graph_param.sigma2 = 1;

find_the_bend(graph_param, blob_var)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Two moon clustering
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_type = 'knn';
graph_param.graph_thresh = 7;
graph_param.sigma2 = 1;

two_moons_clustering(graph_param, [1,2])

% sensitive to number of neighbors:
nns = [5, 7, 9]
for i = 1:size(nns, 2)
    graph_param.graph_thresh = nns(i);
    two_moons_clustering(graph_param, [1,2])
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compare Laplacians
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

point_and_circle_clustering('sym')
point_and_circle_clustering('rw')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compare clustering stability for different eps / k
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2) ;
% compare for diffrent k in the knn graph
subplot(1,2,1) ; hold on ;
parameter_sensitivity('knn')
title('Sensitivity to k');
xlabel('k')
ylabel('ARI value')
% compare for diffrent eps in the eps graph
subplot(1,2,2) ; hold on ;
parameter_sensitivity('eps')
title('Sensitivity to \epsilon')
xlabel('\epsilon')
ylabel('ARI value')


