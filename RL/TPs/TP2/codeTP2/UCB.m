function [rew, draws] = UCB(T, MAB)
    % Simulate a bandit game of length T with UCB alogrithm
    
    n_bandit = size(MAB, 2);
    mu = zeros(n_bandit, 1);
    N = zeros(n_bandit, 1);
    rew = zeros(1, T);
    draws = zeros(1, T);
    for t = 1:T
        % initialisation phase try each arm one time
        if t <= n_bandit
            idx = t;
        else
            [~, idx] = max(mu + sqrt((1 ./ N) * log(t) / 2));
        end
        At = MAB{idx};
        r =  At.sample();
        % count which arm has been used
        N(idx) = N(idx) + 1;
        % compute new mean for this arm
        mu(idx) = ((N(idx)-1) * mu(idx) + r) / N(idx);
        % fill the rew and draws:
        rew(t) = r;
        draws(t) = idx;
    end