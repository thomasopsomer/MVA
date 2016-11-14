function [pi, Vstar, Vrec] = value_iteration(v_0, P, R, gamma, iter)
    % Compute optimal policy using value iteration method
    
    % initialisation
    V = v_0;
    n = size(P,1);
    Vrec = zeros(iter, n);
    for k = 1:iter
        % compute Q_k
        tmp = zeros(n, size(P,3));
        for y=1:n
            tmp = tmp + squeeze(P(:,y,:)) * squeeze(V(y));
        end
        Q_k = R + gamma * tmp;
        % V_k+1 = max{a} (Q_k(a))
        [V, pi] = max(Q_k, [], 2);
        Vrec(k,:) = V';
    end
    Vstar = V';

