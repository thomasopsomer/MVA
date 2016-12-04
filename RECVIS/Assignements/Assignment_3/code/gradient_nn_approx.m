function [grad_s_Wi_approx, grad_s_Wo_approx, grad_s_bi_approx, grad_s_bo_approx] = gradient_nn_approx(X,Y,Wi,bi,Wo,bo)
    % Compute each gradient using finite difference in each direction

    [~, ~, loss]    = nnet_forward_logloss(X,Y,Wi,bi,Wo,bo);
       
    [~, ~, d_loss]  = nnet_forward_logloss(X,Y,Wi,bi,Wo,bo + 0.01);
    grad_s_bo_approx = (mean(d_loss) - mean(loss)) / 0.01;
    
    delta = ones(size(Wo)) * 0.001;
    [~, ~, d_loss]  = nnet_forward_logloss(X,Y,Wi,bi,Wo + delta,bo);
    grad_s_Wo_approx = (mean(d_loss) - mean(loss)) ./ delta;

    delta = ones(size(Wi)) * 0.001;
    [~, ~, d_loss]  = nnet_forward_logloss(X,Y,Wi + delta,bi,Wo,bo);
    grad_s_Wi_approx = (mean(d_loss) - mean(loss)) ./ delta;

    delta = ones(size(bi)) * 0.001;
    [~, ~, d_loss]  = nnet_forward_logloss(X,Y,Wi,bi + delta,Wo,bo);
    grad_s_bi_approx = (mean(d_loss) - mean(loss)) ./ delta;

    end
    