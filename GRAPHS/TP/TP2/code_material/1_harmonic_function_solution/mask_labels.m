function [Y_masked] =  mask_labels(Y, l)
%  [Y_masked] =  mask_labels(Y, l)
%      a skeleton function to select a subset of labels and mask the rest
%
%  Input
%  Y:
%      (n x 1) label vector, where entries Y_i take a value in [1..C] (num classes)
%  l:
%      number of unmasked (revealed) labels to include in the output
%
%  Output
%  Y_masked:
%      (n x 1) masked label vector, where entries Y_i take a value in [1..C]
%           if the node is labeled, or 0 if the node is unlabeled (masked)

num_samples = size(Y,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% randomly sample l nodes to remain labeled, mask the others    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Y_masked = ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
