function [X, Y] = two_moons(num_samples,dist_options)
%[X, Y] = two_moons(num_samples,dist_options)
%   Creates two intertwined moons
%
%  Input
%  num_samples:
%      number of samples to create in the dataset
%  dist_options:
%      [radius of the moons,
%       variance of the moons]
%
%  Output
%  X:
%      (n x m) matrix of m-dimensional samples
%  Y:
%      (n x 1) matrix of "true" cluster assignment [1:c]

    moon_radius = dist_options(1);
    moon_var = dist_options(2);

    if mod(num_samples, 2) ~= 0
        error('The number of samples must be a multiple of the number of blobs');
    end

    X=zeros(num_samples,2);

    for i=1:num_samples/2
        r = moon_radius + 4 * (i-1)/num_samples;
        t = (i - 1) * 3/num_samples * pi;
        X(i, 1) = r*cos(t);
        X(i, 2) = r*sin(t);
        X(i + num_samples/2, 1) = r*cos(t + pi);
        X(i + num_samples/2, 2) = r*sin(t + pi);
    end

    X= X + sqrt(moon_var) * randn(num_samples, 2);
    Y = [ ones(num_samples/2, 1); 2*ones(num_samples/2, 1)];

