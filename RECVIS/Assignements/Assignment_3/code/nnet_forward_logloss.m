function [Po,Yo,loss] = nnet_forward_logloss(X,Y,Wi,bi,Wo,bo)
% Compute the output Po, Yo and the loss of the network for the input X
% This is a 2 layer (1 hidden layer network)
%
% Input: X ... (in R^2) set of input points, one per column
%        Y ... {-1,1} the target values for the set of points X
%        Wi, bi, Wo, bo ... parameters of the network
%
% Output: Po ... probabilisitc output of the network P(class=1 | x) 
%                 Po is in <0 1>. 
%                 Note: P(class=-1 | x ) = 1 - Po
%         Yo ... output of the network Yo is in <-inf +inf>
%         loss ... logistic loss of the network on examples X 
%                  with ground target values Y in {-1,1}
%

% The number of input points
npoints = size(X,2);

% Repeat the parameters bi and bo so that the network is applicable
% on a set of inputs X, where each point is one column of X
Bi   = repmat(bi,1,npoints);
Bo   = repmat(bo,1,npoints);

% Hidden layer
H    = relu(Wi*X + Bi);

% Output of the network
Yo   = Wo*H + bo;

% Probabilistic output P(class=1 | x)
% Note that P(class=-1 | x ) = 1 - P(class=1|x)
% This is achieved by passing the output through a sigmoid
Po   = sigm(Yo);

% Logistic loss s(Y,Yo) between output Yo and 
% the target (ground truth) output Y  
if ~isempty(Y)
  loss = log(1+exp(-Y.*Yo));
else
  loss = [];
end;

return;

