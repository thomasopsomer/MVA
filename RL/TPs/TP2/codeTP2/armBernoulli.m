classdef armBernoulli<handle
    % % Bernoulli arm 
    
    properties
        p % vector of the means parameter
        mean % expectations of the arm
        var % variances of the arm 
    end
    
    methods
        function self = armBernoulli(p)
            self.p=p; 
            self.mean = p;
            self.var = p*(1-p);
        end
        
        function [reward] = sample(self)
            % return a sample from arm k
            reward = (rand()<self.p);
        end
                
    end    
end
