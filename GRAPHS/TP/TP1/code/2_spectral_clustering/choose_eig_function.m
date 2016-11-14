function [eig_ind] = choose_eig_function(eigenvalues)
%  [eig_ind] = choose_eig_function(eigenvalues)
%     chooses indices of eigenvalues to use in clustering
%
% Input
% eigenvalues:
%     eigenvalues sorted in ascending order
%
% Output
% eig_ind:
%     the indices of the eigenvectors chosen for the clustering
%     e.g. [1,2,3,5] selects 1st, 2nd, 3rd, and 5th smallest eigenvalues

% 
% 1. We find the index of the biggest encrease in the eigenvalue function
% 
n_eig = size(eigenvalues,1);
discrete_derive = zeros(1, n_eig -1);
for i = 1:(n_eig -1)
    discrete_derive(i) = eigenvalues(i+1) - eigenvalues(i);
end
[~, m_index] = max(discrete_derive);

%
% 2. Find the first significant bump in increment
%
if m_index > 2
    % initialize
    best_m_index = m_index;
    % compute second derivative & look for the first sign changes
    % in second derivative
    descrete_derive_2 = zeros(1, m_index-1);
    for i = 1:(m_index-1)
        descrete_derive_2(i) = discrete_derive(i+1) - discrete_derive(i);
        if descrete_derive_2(i) < 0 && descrete_derive_2(i-1) > 0
            best_m_index = i;
            break
        end
    end
else
    best_m_index = m_index;
end

eig_ind = 1:best_m_index;
