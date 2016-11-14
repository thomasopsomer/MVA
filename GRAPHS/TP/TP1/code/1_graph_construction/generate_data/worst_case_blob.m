function [X, Y] = worst_case_blob(num_samples, dist_options)

    gen_pam = dist_options(1);
    blob_var = 0.3;

    X = [];
    Y = [];

    X = [X;sqrt(blob_var)*randn(num_samples,2)];
    Y = [Y; ones(num_samples, 1)];

    X(end,:) = [max(X(:,1)) + gen_pam, 0];

    end

