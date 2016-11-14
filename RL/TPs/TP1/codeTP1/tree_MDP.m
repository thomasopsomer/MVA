function [ dynamics, reward ] = tree_MDP(max_height, A, sick_prob,growth, maintenance_cost, planting_cost,sell_price)
%the growth matrix is of size (max_height-1)*(max_height-1) and growth(i,j) contains the probability of increasing its size by j when the current height is i. 
%an example for max_height=5, growth=zeros(max_height-1,max_height-1);
%growth(1:2,1:3)=1/3;
%growth(3,1:2)=1/2;
%growth(4,1)=1;

    % the state space is {1 .. max_height} and the special state "sick"
    S = max_height + 1;
    state_sick = max_height + 1;
    
    % the dynamics and reward function, both of them are initialized to 0!
    dynamics = zeros(S, S, A);
    reward   = zeros(S, A);    
    
    %%% action = keep
    for height = 1:(max_height-1)
        for diff_height = 1:(max_height-height)
            dynamics(height, height+diff_height,1)   = (1-sick_prob)*growth(height,diff_height);
        end        
        dynamics(height, state_sick,1) = sick_prob;
        reward(height, 1) = -maintenance_cost;
    end
    
    dynamics(max_height,max_height,1) = 1-sick_prob;
    dynamics(max_height,state_sick,1) = sick_prob;
    reward(max_height, 1) = -maintenance_cost;
    
    % if the tree is sick it stays sick (and we pay no maintenance cost)
    dynamics(state_sick,state_sick,1) = 1.0;
    
    %%% action = cut
    % probability to reset to a tree of height 1
    dynamics(:, 1, 2) = 1.0;
    
    % the reward is proportional to the height of the tree if not sick
    for height=1:max_height
        reward(height,2) = sell_price*height- planting_cost;
    end
    % if the tree is sick we only pay the cost for planting a tree
    reward(state_sick,2) = - planting_cost;

    
    %%% testing the correctness of the transition matrix
    for s = 1:S
        for a = 1:A
            sum_prob = sum(dynamics(s,:,a));
            assert(sum_prob > 1.0-eps);
	    assert(sum_prob < 1.0+eps);
        end
    end
end

