function y = sigm(x)
% SIGM Retruns sigmoid of 
% if x is matrix of vector the function returns pointwise sigmoid
%  
% Josef.Sivic@ens.fr
% Adapted from python scripts of Nicolas Le Roux
%

y = 1./(1 + exp(-x));


end

