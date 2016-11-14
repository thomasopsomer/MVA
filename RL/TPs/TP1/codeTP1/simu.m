function [sample] = simu(P)
% draw a sample from a distribution on 1 ... length(P)
% such that Proba(X=i)=P(i)
x=cumsum(P);
u=rand();
i=1;
while (u > x(i))
   i=i+1;
end
sample=i;
   

