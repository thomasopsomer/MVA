function [next_state, reward] = tree_sim(state, action, G, c_m, c_p, H, price, p_sick)
% tree sim receives as input a state and an action
% it returns the next state and the reward.
% Args:
%     - G: Growth probability matrix
if action == 1 && state < H+1
    reward = -c_m;
    next_state = get_next_state(state, H, p_sick, G);
elseif action == 2 && state < H+1
    reward = state * price - c_p;
    next_state = 1;
elseif state == H+1
    reward = - c_p;
    next_state = 1;
end


function [next_state] = get_next_state(state, H, p_sick, G)
    % get new state
    if state == H
        next_state = H + (2 - simu([p_sick 1-p_sick]));
    else
        s = simu([p_sick 1-p_sick]);
        if s == 2
            % next_state = actual height + growth
            next_state = state + simu(G(state, :));
        else
            next_state = H + 1;
        end
    end