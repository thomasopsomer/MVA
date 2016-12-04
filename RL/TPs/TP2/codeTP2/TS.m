function [rew, draws] = TS(T, MAB, dist)
    % Simulate a bandit game of length T with Thompson Sampling
    
    % arg parse
    if nargin == 2
        dist = 'bernouilli';
    end
    
    if strcmp(dist, 'bernouilli')
        [rew, draws] = TS_bern(T, MAB);
    elseif strcmp(dist, 'exp')
        [rew, draws] = TS_exp(T, MAB);
    elseif strcmp(dist, 'gaussian')
        [rew, draws] = TS_gauss(T, MAB);
    else
        disp('Not implemented error')
    end
end


function [rew, draws] = TS_bern(T, MAB)
    n_bandit = size(MAB, 2);
    S = zeros(1, n_bandit);
    F = zeros(1, n_bandit);
    rew = zeros(1, T);
    draws = zeros(1, T); 
    
    for t = 1:T
        % draw sample according to beta distribution of each arm
        % and take the max
        [~,idx] = max(betarnd(S + 1, F + 1));
        At = MAB{idx};
        r = At.sample();
        if r == 1
            S(idx) = S(idx) + 1;
        else
            F(idx) = F(idx) + 1;
        end
        % fill the rew and draws:
        rew(t) = r;
        draws(t) = idx; 
    end
end


function [rew, draws] = TS_exp(T, MAB)
    n_bandit = size(MAB, 2);
    N = ones(1, n_bandit);
    R = zeros(1, n_bandit);
    rew = zeros(1, T);
    draws = zeros(1, T);
    % init
    for i = 1:n_bandit
        r = MAB{i}.sample();
        R(i) = r;
        rew(i) = r;
    end
    % follow on
    for t = n_bandit:T
        % draw sample according to gamma distribution of each arm
        [~,idx] = min(gamrnd(N, R));
        At = MAB{idx};
        r = At.sample();
        N(idx) = N(idx) + 1;
        R(idx) = R(idx) + r;
        % fill the rew and draws:
        rew(t) = r;
        draws(t) = idx; 
    end
end


function [rew, draws] = TS_gauss(T, MAB)
    %
    n_bandit = size(MAB, 2);
    N = zeros(1, n_bandit);
    mu = zeros(1, n_bandit);
    rew = zeros(1, T);
    draws = zeros(1, T);
    for t = n_bandit:T
        % draw sample according to normal distribution of each arm
        [~,idx] = max(normrnd(mu, 1 ./ (N + 1)));
        At = MAB{idx};
        r = At.sample();
        N(idx) = N(idx) + 1;
        mu(idx) = ((N(idx) - 1) * mu(idx) + r) / N(idx);
        % fill the rew and draws:
        rew(t) = r;
        draws(t) = idx; 
    end
end