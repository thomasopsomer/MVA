function [X,R] = trajectory(T, x0, pi, G, c_m, c_p, H, price, p_sick)
    % T: length of the trajectory
    % x0: initial state
    % pi: policy
    x = x0;
    X = [];
    R = [];
    for k = 1:T
        X = [X, x];
        [x,reward] = tree_sim(x,pi(x), G, c_m, c_p, H, price, p_sick);
        R = [R, reward];
    end
end