function [V_pi] = eval_policy(pi, P, R, gamma)
    % evaluate a policy using matrix inversion
    %
    % compute P_pi R_pi
    n = size(P,1);
    P_pi = zeros(n);
    R_pi = zeros(n, 1);
    for i = 1:n
        for j = 1:n
            P_pi(i,j) = P(i,j,pi(i));
        end
        R_pi(i) = R(i, pi(i));
    end
    % Compute V_pi
    V_pi = (eye(n) - gamma * P_pi)^(-1) * R_pi;
    
            
        
    
    