function [X, Y] = blobs(num_samples,dist_options)
%[X, Y] = blobs(num_samples,dist_options)
%   Creates N gaussian blobs evenly spaced across a circle
%
%  Input
%  num_samples:
%      number of samples to create in the dataset
%  dist_options:
%      [how many separate blobs to create,
%       gaussian variance of each blob,
%       surplus of samples added to first blob to create unbalanced classes]
%
%  Output
%  X:
%      (n x m) matrix of m-dimensional samples
%  Y:
%      (n x 1) matrix of "true" cluster assignment [1:c]

    num_blobs = dist_options(1);
    blob_var = dist_options(2);
    blob_surplus = dist_options(3);

    if mod(num_samples, num_blobs) ~= 0
        error('The number of samples must be a multiple of the number of blobs');
    end

    X = [];
    Y = [];

    for i = 1:num_blobs

        if i == 1
            X = [X;repmat([cos(2*pi*i/num_blobs), sin(2*pi*i/num_blobs)], blob_surplus,1) + sqrt(blob_var)*randn(blob_surplus,2)];
            Y = [Y; i * ones(blob_surplus, 1)];
        end

        X = [X;repmat([cos(2*pi*i/num_blobs), sin(2*pi*i/num_blobs)],num_samples/num_blobs,1) + sqrt(blob_var)*randn(num_samples/num_blobs,2)];
        Y = [Y; i * ones(num_samples/num_blobs, 1)];
    end

