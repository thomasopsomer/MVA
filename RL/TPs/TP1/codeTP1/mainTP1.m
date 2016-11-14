%% Problem specification

% state space (including a sick state)
H = 10;
S = H + 1;
sick_state = H + 1;
init_state = 1;

% action space (a=1 keep; a=2 cut)
A = 2;

% discount parameter
gamma = 0.99;
% maintenance and planting cost
c_m =3.0;
% planting cost
c_p = 5.0;
% price for selling a tree
price = 1;


%% Parameters of the dynamics

% probability of getting sick
p_sick = 0.15;
% Growth probability matrix using geometric distribution
% actually truncated geometric
q = 0.2;
G = growth_matrix(H, q);


%% The MDP
% computes the transition array P=P(x,y,a) and expected value matrix R=R(x,a)
disp('Computing the true MDP...');
[P,R] = tree_MDP(H, A, p_sick, G, c_m, c_p, price);


%% Parameters for the RL part

% number of trajectories used in MC or TD(0)
runs = 250;
% maximum number of steps per trajectory in MC and TD(0) (this will limit
% the accuracy of the two methods)
max_step = 1000;

%% Example of policy that may be evaluated
pi = zeros(S,1);
% keep
pi(1:5) = 1;
% cut
pi(6:H) = 2;
pi(sick_state) = 2;

%% Policy evaluation: DP (matrix inversion) versus RL (Monte-Carlo)

% Dynamic Programming
[P, R] = tree_MDP(H, A, p_sick, G, c_m, c_p, price);
V_pi = eval_policy(pi, P, R, gamma);

% RL
x0 = 1;
V_n = eval_policy_mc(runs, max_step, x0, pi, G, gamma, c_m, c_p, H, price, p_sick);

% plot V_n(x_0) - V_pi(x_0)
Ns = 1:10:350;
V_ns = zeros(1, size(Ns, 2));
for i = 1:size(Ns, 2)
    V_ns(i) = eval_policy_mc(Ns(i), max_step, x0, pi, G, gamma, c_m, c_p, H, price, p_sick);
end
figure(1);
plot(Ns, (V_ns - V_pi(x0)), 'LineWidth', 2)
ylabel('V_{n}(x_{0}) - V^{\pi}(x_{0})')
xlabel('n: Number of iteration')


%% Value Iteration

v_0 = ones(S,1);
iter = 500;
[pi, Vstar, Vrec] = value_iteration(v_0, P, R, gamma, iter);

diff_inf = [];
for k = 1:size(Vrec, 1)
    diff_inf(k) = max(Vstar - Vrec(k,:));
end

figure(2);
subplot(1,2,1); hold on;
plot(1:iter, diff_inf, 'LineWidth', 2)
title('Value Iteration')
ylabel('||V^* - V_{k}||')
xlabel('n: Number of iteration')


%% Policy Iteration
pi_0 = ones(S,1);
iter = 10;
[pi, Vstar, Vrec] = policy_iteration(pi_0, P, R, gamma, iter);

diff_inf = [];
for k = 1:size(Vrec, 1)
    diff_inf(k) = max(Vstar - Vrec(k,:));
end

subplot(1,2,2); hold on;
plot(1:11, diff_inf, 'LineWidth', 2)
title('Policy Iteration')
ylabel('||V^* - V_{k}||')
xlabel('n: Number of iteration')


