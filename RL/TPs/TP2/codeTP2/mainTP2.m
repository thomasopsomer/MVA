%% Build your own bandit problem 

% this is an example, please change the parameters or arms!
Arm1=armBernoulli(0.5);
Arm2=armBernoulli(0.8);
Arm3=armBernoulli(0.7);
Arm4=armBernoulli(0.4);

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

T=5000; % horizon

[rew1,draws1]=UCB(T,MAB);
reg1=muMax*(1:T) - cumsum(rew1);
[rew2,draws2]=TS(T,MAB);
reg2=muMax*(1:T) - cumsum(rew2);


plot(1:T,reg1,1:T,reg2)
legend('UCB', 'TS')
%% (Expected) regret curve for UCB and Thompson Sampling

n = 100;
cs1 = zeros(n, T);
cs2 = zeros(n, T);
for k = 1:n
    [rew1, draws1]=UCB(T,MAB);
    cs1(k, :) = cumsum(rew1);
    [rew2, draws2]=TS(T,MAB);
    cs2(k, :) = cumsum(rew2);
end

R_t_1 = muMax*(1:T) - mean(cs1, 1);
R_t_2 = muMax*(1:T) - mean(cs2, 1);

% plot results :)
plot(1:T,R_t_1,1:T,R_t_2)
title('Expected regret for UCB and TS')
legend('UCB', 'TS','Location','northwest')



