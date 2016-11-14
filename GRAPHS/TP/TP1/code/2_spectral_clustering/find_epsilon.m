function [epsilon] = find_epsilon(X)
% finding a good espilon with min max spanning tree
similarities = exponential_euclidean(X, 1) ;
max_tree = max_span_tree(similarities);
tmp = max_tree .* similarities;
epsilon = min(similarities(tmp > 0));