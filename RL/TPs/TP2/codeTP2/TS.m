function [rew, draws] = TS(T, MAB)
    % Simulate a bandit game of length T with Thompson Sampling
    
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