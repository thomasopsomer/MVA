% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Graph construction
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Purpose of word_case_blob option parameter
dos = [0.01, 0,1, 1, 10];
for i = 1:size(dos, 2)
    how_to_choose_epsilon(dos(i));
end

% compare knn and epsilon graph for two_moons dataset
num_samples = 300 ;
sample_dist = 'two_moons';
graph_thresh = 5 ;
sigma2 = 5;

graph_type = 'knn' ;
graph_thresh = 7 ; % number of neigbors
plot_similarity_graph(num_samples, sample_dist, graph_type, graph_thresh, sigma2)

graph_type = 'eps' ;
graph_thresh = 0.6 ; % epsilon threshold
plot_similarity_graph(num_samples, sample_dist, graph_type, graph_thresh, sigma2)


% compare knn and epsilon graph for blob dataset
num_samples = 300 ;
sample_dist = 'blob';
graph_thresh = 5 ;
sigma2 = 1;

graph_type = 'knn' ;
graph_thresh = 6 ; % number of neigbors
plot_similarity_graph(num_samples, sample_dist, graph_type, graph_thresh, sigma2)

graph_type = 'eps' ;
graph_thresh = 0.6 ; % epsilon threshold
plot_similarity_graph(num_samples, sample_dist, graph_type, graph_thresh, sigma2)
