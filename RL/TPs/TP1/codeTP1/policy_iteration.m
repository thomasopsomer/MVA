function [pi, Vstar, Vrec] = policy_iteration(pi_0, P, R, gamma, iter)
    % Compute optimal policy using policy iteration method    
    % initialization
    pi = pi_0;
    n = size(P,1);
    Vrec = zeros(iter + 1, n);
    %
    for i=1:iter
        % policy evaluation
        V_pi_k = eval_policy(pi, P, R, gamma);
        Vrec(i,:) = V_pi_k';
        % policy improvement using Q
        tmp = zeros(n, size(P,3));
        for y=1:n
            tmp = tmp + squeeze(P(:,y,:))*squeeze(V_pi_k(y));
        end
        Q_pi_k = R + gamma * tmp;
        [~, pi] = max(Q_pi_k, [], 2);
    end
    Vstar = eval_policy(pi, P, R, gamma)';
    Vrec(iter + 1, :) = Vstar';
end