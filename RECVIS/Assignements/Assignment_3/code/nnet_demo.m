% Demo script for training two layer fully connected neural network 
% with one hidden layer
% 
% Josef.Sivic@ens.fr
% Adapted from Nicolas Le Roux

clear; % clear all current variables.

% load training data
tmp = load('double_moon_train1000.mat');
Xtr = tmp.X';
Ytr = tmp.Y';

% load the validation data
tmp = load('double_moon_val1000.mat');
Xval = tmp.X';
Yval = tmp.Y';

% train fully connected neural network with 1 hidden layer
h  = 7; % number of hidden units, i.e. the dimensionality of the hidden layer
di = 2; % input dimension (2D) -- do not change
do = 1; % output dimension (1D - classification) -- do not change

lrate     = 0.02; % learning rate
nsamples  = length(Ytr);
visualization_step = 1000; % visualize output only these steps

% randomly initialize parameters of the model
Wi = rand(h,di);
bi = rand(h,1);
Wo = rand(1,h);
bo = rand(1,1);

%
d = [];
Rec_approx = [];
Rec_bp = [];

for i = 1:30*nsamples % hundred passes through the data
    % draw an example at random
    n = randi(nsamples);
    
    X = Xtr(:,n);
    Y = Ytr(:,n); % desired output
    
    % compute gradient 
    [grad_s_Wi, grad_s_Wo, grad_s_bi, grad_s_bo] = ... 
                                gradient_nn(X,Y,Wi,bi,Wo,bo);

    % gradient update                                 
    Wi = Wi - lrate.*grad_s_Wi;
    Wo = Wo - lrate.*grad_s_Wo;
    bi = bi - lrate.*grad_s_bi;
    bo = bo - lrate.*grad_s_bo;

    % plot training error
    [Po,Yo,loss]    = nnet_forward_logloss(Xtr,Ytr,Wi,bi,Wo,bo);
    Yo_class        = sign(Yo);
    tr_error(i)     = sum((Yo_class - Ytr)~=0)./length(Ytr);
    
    % plot validation error
    [Pov,Yov,lossv]    = nnet_forward_logloss(Xval,Yval,Wi,bi,Wo,bo);
    Yov_class          = sign(Yov);
    val_error(i)       = sum((Yov_class - Yval)~=0)./length(Yval);

    % visualization only every visualiztion_step-th iteration       
    if ~mod(i,visualization_step) 

        % show decision boundary
        plot_decision_boundary(Xtr,Ytr,Wi,bi,Wo,bo);
        
        % plot the evolution of the training and test errors
        if 1            
            figure(3); hold off;
            plot(tr_error);
            title(sprintf('Training error: %.2f %%',tr_error(i)*100));
            grid on;
            
            figure(4); hold off;
            plot(val_error);
            title(sprintf('Validation error: %.2f %%',val_error(i)*100));
            grid on;
        end;
        
        
        % Numerically check the correctness of gradients
        % To be completed 
        %
        % compute approximated gradient
%         [~, ~, loss]    = nnet_forward_logloss(Xtr,Ytr,Wi,bi,Wo,bo);
%         [~, ~, d_loss]  = nnet_forward_logloss(Xtr,Ytr,Wi,bi,Wo,bo + 0.01);
%         grad_s_bo_approx = (mean(d_loss) - mean(loss)) / 0.01;
%         d(n) = (grad_s_bo_approx - grad_s_bo);
        % [grad_s_Wi_approx, grad_s_Wo_approx, grad_s_bi_approx, grad_s_bo_approx] = gradient_nn_approx(X,Y,Wi,bi,Wo,bo);
        % break
    end;
    
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stage C: QC2, QC3, QC4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load training data
tmp = load('double_moon_train1000.mat');
Xtr = tmp.X';
Ytr = tmp.Y';
% load the validation data
tmp = load('double_moon_val1000.mat');
Xval = tmp.X';
Yval = tmp.Y';

% train fully connected neural network with 1 hidden layer
h  = 7; % number of hidden units, i.e. the dimensionality of the hidden layer

lrate     = 0.02; % learning rate
nsamples  = length(Ytr);
visualization_step = 20000;
iter = 100;
Rec = [];

% QC2
for i = 1:5
    [tr_err, val_er] = train_and_test(Xtr, Ytr, Xval, Yval, h, lrate, iter, visualization_step);
    Rec(i,1) = tr_err(end);
    Rec(i,2) = val_er(end);
end

% QC3
lrates = [2, 0.2, 0.02, 0.002];
Rec3 = [];
for i = 1:size(lrates, 2)
    for p = 1:3
        [tr_err, val_err] = train_and_test(Xtr, Ytr, Xval, Yval, h, lrates(i), iter, visualization_step);
        Rec3(i,:, 1, p) = tr_err;
        Rec3(i,:, 2, p) = val_err;
    end
end


plot(1:30, Rec3(1:4, 1:30, 2, 1), 'LineWidth', 2)
title('convergence for different learning rate')
xlabel('Iteration')
ylabel('Error on test set')
legend('lrate = 2', 'lrate = 0.2', 'lrate = 0.02', 'lrate = 0.002')

% find convergence step
c = [];
for k = 1:4
    for p = 1:3
        for i = 1:iter
            if Rec3(k, i, 2) == 0
                c(k, p) = i;
                break
            end
        end
    end
end


% QC4
h = [1, 2, 5, 7, 10, 100];
iter = 50;
visualization_step = 50000;
lrate = 0.02;
Rec4 = [];

for i = 1:size(h, 2)
    for p = 1:3
        [tr_err, val_err] = train_and_test(Xtr, Ytr, Xval, Yval, h(i), lrate, iter, visualization_step);
        Rec4(i,:, 1, p) = tr_err;
        Rec4(i,:, 2, p) = val_err;
    end
end

plot(1:iter, Rec4(1:6, 1:iter, 1, 2), 'LineWidth', 2)
title('convergence for different number of hidden unit')
xlabel('Iteration')
ylabel('Error on test set')
legend('h = 1', 'h = 2', 'h = 5', 'h = 7', 'h = 10', 'h = 100')

% find convergence step
c = [];
for k = 1:6
    for p = 1:3
        for i = 1:iter
            if Rec4(k, i, 2, p) == 0
                c(k, p) = i;
                break
            end
        end
    end
end

% plot hyperplane
train_and_test(Xtr, Ytr, Xval, Yval, 1, 0.2, 30, 10000);




