function [G] = growth_matrix(H,q)
    % Computer the growth probability matrix using a
    % truncated geometric distribution
    % Args:
    %   - H: max height
    %   - q: geometric parameter
    G = zeros(H-1);
    for i = 1:H-1
        g = zeros(1, H-1);
        if H-i >= 2
            g(2:(H-i)) = q * (1-q).^(1:(H-i-1));
            g(1) = 1 - sum(g);
        else
            g(1) = 1;
        end
        G(i,:) = g(:);
    end