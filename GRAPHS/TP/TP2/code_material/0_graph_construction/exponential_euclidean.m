function [similarities] = exponential_euclidean(X, sigma2)
% [W] = exponential_euclidean(X, sigma)
%     Applies an inverse exponential (Gaussian) function to
%     the euclidean distance to generate a similarity measure.
% 
% Input
% X:
%     (n x m) matrix of m-dimensional samples
% sigma2:
%     the sigma value for the exponential function, already squared
% 
% Output
% similarities:
%     (n x n) dimensional matrix containing the
%     similarities between each pair of points.

    similarities = squareform(pdist(X,'euclidean'));
    similarities = exp(-similarities./(2*sigma2));

