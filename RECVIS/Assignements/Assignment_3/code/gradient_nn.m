function [grad_s_Wi, grad_s_Wo, grad_s_bi, grad_s_bo] = ...
                                gradient_nn(X,Y,Wi,bi,Wo,bo)
% Compute gradient of the logistic loss of the 
% neural network on example X with target label Y, 
% with respect to the parameters Wi,bi,Wo,bo.
%
% Input: X ... 2x1 vector of the input example
%        Y ... 1x1 the target label in {-1,1}   
%        Wi,bi,Wo,bo ... parameters of the network
%        Wi ... [hxd]
%        bi ... [hx1]
%        Wo ... [1xh]
%        bo ... 1x1
%        where h... is the number of hidden units
%              d... is the number of input dimensions (d=2)
%
% Output: 
%  grad_s_Wi [hxd] ... gradient of loss s(Y,Y(X)) w.r.t  Wi
%  grad_s_Wo [1xh] ... gradient of loss s(Y,Y(X)) w.r.t. Wo
%  grad_s_bi [hx1] ... gradient of loss s(Y,Y(X)) w.r.t. bi
%  grad_s_bo [1x1] ... gradient of loss s(Y,Y(X)) w.r.t. bo
%

% To be completed:
H = relu(Wi * X + bi);
d_l_y_bar = (-Y / (1 + exp(Y .* (Wo * H + bo))));

% grad_s_Wo
grad_s_Wo = d_l_y_bar * H';
% grad_s_bo
grad_s_bo = d_l_y_bar;
% grad_s_Wi
grad_s_Wi = d_l_y_bar * Wo' .* (H > 0) * X';
% grad_s_bi
grad_s_bi = d_l_y_bar * Wo' .* (H > 0);

end

