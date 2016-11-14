function [V_n] = eval_policy_mc(n, T, x0, pi, G, gamma, c_m, c_p, H, price, p_sick)
    % policy evaluation in RL using MC
    Ris = zeros(1, n);
    for i = 1:n
        % compute trajectory
        [~,R] = trajectory(T, x0, pi, G, c_m, c_p, H, price, p_sick);
        % compute cum sum of reward
        tmp = cumsum(gamma.^((1:T)-1).* R);
        Ris(i) = tmp(end);
    end
    % compute the empirical mean of cumulative sum of reward
    V_n = mean(Ris);