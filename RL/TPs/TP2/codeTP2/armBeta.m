classdef armBeta<handle
    % arm having a Beta distribution
    
    properties
        a % first parameter
        b % second parameter
        mean % expectation of the arm
        var % variance of the arm 
    end
    
    methods
        function self = armBeta(a,b)
            self.a=a; 
            self.b = b;
            self.mean = a/(a+b);
            self.var = (a*b)/((a+b)^2*(a+b+1));
        end
        
        function [reward] = sample(self)
            reward = betarnd(self.a,self.b);
        end
                
    end    
end