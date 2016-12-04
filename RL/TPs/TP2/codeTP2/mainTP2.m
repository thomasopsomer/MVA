%% First MAB (simple case)

% MAB 1 (simple case)
Arm1=armBernoulli(0.4);
Arm2=armBernoulli(0.8);
Arm3=armBernoulli(0.5);
Arm4=armBernoulli(0.3);
MAB={Arm1,Arm2,Arm3,Arm4};

% bandit : set of arms

NbArms=length(MAB);

Means=zeros(1,NbArms);
for i=1:NbArms
    Means(i)=MAB{i}.mean;
end

% Display the means of your bandit (to find the best)
Means
muMax=max(Means);


%% Comparison of the regret on one run of the bandit algorithm

T=50000; % horizon

[rew1,draws1]=UCB(T,MAB);
reg1=muMax*(1:T) - cumsum(rew1);
[rew2,draws2]=TS(T,MAB);
reg2=muMax*(1:T) - cumsum(rew2);
[rew3,draws3]=naive(T,MAB);
reg3=muMax*(1:T) - cumsum(rew3);

figure(1);
plot(1:T,reg1, 1:T,reg2, 1:T,reg3)
title('case 1: Regret on a single run for UCB and TS')
xlabel('Time')
ylabel('Regret')
legend('UCB', 'TS', 'Naive')
%% (Expected) regret curve for UCB and Thompson Sampling

n = 100;
cs1 = zeros(n, T);
cs2 = zeros(n, T);
cs3 = zeros(n, T);
for k = 1:n
    [rew1, draws1]=UCB(T,MAB);
    cs1(k, :) = cumsum(rew1);
    [rew2, draws2]=TS(T,MAB);
    cs2(k, :) = cumsum(rew2);
    %[rew3,draws3]=naive(T,MAB);
    % cs3(k, :) = cumsum(rew3);
end

R_t_1 = muMax*(1:T) - mean(cs1, 1);
R_t_2 = muMax*(1:T) - mean(cs2, 1);
% R_t_3 = muMax*(1:T) - mean(cs3, 1); 
LR_bound = LR_lower_bound(MAB) .* log(1:T);

% plot results :)
figure(2);
plot(1:T, R_t_1, 1:T, R_t_2, 1:T, LR_bound, 'LineWidth', 2)
%plot(1:T, R_t_1, 1:T, R_t_2, 1:T, R_t_3, 1:T, LR_bound, 'LineWidth', 2)
% plot(1:T, R_t_1, 1:T, R_t_2, 'LineWidth', 2)
title('case 1: Expected regret for UCB and TS')
xlabel('Time')
ylabel('Regret')
% legend('UCB', 'TS', 'Naive', 'Lai and Robbins bound', 'Location','northwest')
legend('UCB', 'TS', 'Lai and Robbins bound', 'Location','northwest')



%% Second MAB (harder case

% MAB 2 (harder case, arms a quite close in term of mean)
Arm1=armBernoulli(0.65);
Arm2=armBernoulli(0.8);
Arm3=armBernoulli(0.78);
Arm4=armBernoulli(0.75);
MAB={Arm1,Arm2,Arm3,Arm4};

% bandit : set of arms

NbArms=length(MAB);

Means=zeros(1,NbArms);
for i=1:NbArms
    Means(i)=MAB{i}.mean;
end

% Display the means of your bandit (to find the best)
Means
muMax=max(Means);


%% Comparison of the regret on one run of the bandit algorithm

T=50000; % horizon

[rew1,draws1]=UCB(T,MAB);
reg1=muMax*(1:T) - cumsum(rew1);
[rew2,draws2]=TS(T,MAB);
reg2=muMax*(1:T) - cumsum(rew2);
%[rew3,draws3]=naive(T,MAB);
%reg3=muMax*(1:T) - cumsum(rew3);

figure(3);
plot(1:T,reg1, 1:T,reg2, 1:T,reg3)
title('case 2: Regret on a single run for UCB and TS')
xlabel('Time')
ylabel('Regret')
legend('UCB', 'TS', 'Naive')
%% (Expected) regret curve for UCB and Thompson Sampling

n = 100;
cs1 = zeros(n, T);
cs2 = zeros(n, T);
cs3 = zeros(n, T);
for k = 1:n
    [rew1, draws1]=UCB(T,MAB);
    cs1(k, :) = cumsum(rew1);
    [rew2, draws2]=TS(T,MAB);
    cs2(k, :) = cumsum(rew2);
    % [rew3,draws3]=naive(T,MAB);
    % cs3(k, :) = cumsum(rew3);
end

R_t_1 = muMax*(1:T) - mean(cs1, 1);
R_t_2 = muMax*(1:T) - mean(cs2, 1);
% R_t_3 = muMax*(1:T) - mean(cs3, 1); 
LR_bound = LR_lower_bound(MAB) .* log(1:T);

% plot results :)
figure(4);
% plot(1:T, R_t_1, 1:T, R_t_2, 1:T, R_t_3, 1:T, LR_bound, 'LineWidth', 2)
plot(1:T, R_t_1, 1:T, R_t_2, 1:T, LR_bound, 'LineWidth', 2)
% plot(1:T, R_t_1, 1:T, R_t_2, 'LineWidth', 2)
title('case 2: Expected regret for UCB and TS')
xlabel('Time')
ylabel('Regret')
legend('UCB', 'TS', 'Lai and Robbins bound', 'Location','northwest')


%% Non-parametric bandits

% arm exponential
Arm1=armExp(1.5);
Arm2=armExp(0.8);
Arm3=armExp(2);
Arm4=armExp(1.8);
MAB={Arm1,Arm2,Arm3,Arm4};

% bandit : set of arms

NbArms=length(MAB);

Means=zeros(1,NbArms);
for i=1:NbArms
    Means(i)=MAB{i}.mean;
end

% Display the means of your bandit (to find the best)
Means
muMax=max(Means);


disp = 'gaussian';
T = 5000;

%% (Expected) regret curve for UCB and Thompson Sampling

n = 1000;
cs1 = zeros(n, T);
cs2 = zeros(n, T);
cs3 = zeros(n, T);
for k = 1:n
    [rew1, draws1]=UCB(T,MAB);
    cs1(k, :) = cumsum(rew1);
    [rew2, draws2]=TS(T,MAB, disp);
    cs2(k, :) = cumsum(rew2);
    %[rew3,draws3]=naive(T,MAB);
    %cs3(k, :) = cumsum(rew3);
end

R_t_1 = muMax*(1:T) - mean(cs1, 1);
R_t_2 = muMax*(1:T) - mean(cs2, 1);
%R_t_3 = muMax*(1:T) - mean(cs3, 1); 
LR_bound = LR_lower_bound(MAB) .* log(1:T);

% plot results :)
figure(4);
plot(1:T, R_t_1, 1:T, R_t_2, 1:T, LR_bound, 'LineWidth', 2)
% plot(1:T, R_t_1, 1:T, R_t_2, 'LineWidth', 2)
title('Non-parametric bandits: Expected regret for UCB and TS')
xlabel('Time')
ylabel('Regret')
legend('UCB', 'TS', 'Lai and Robbins bound', 'Location','northwest')
