function [] = plot_decision_boundary(Xtr,Ytr,Wi,bi,Wo,bo)
% Plot the decision boundary of a 2 layer NN and training points Xtr,Ytr
%
% Input: 
%
% Josef.Sivic@ens.fr
% Adapted from Nicolas Le Roux
%

x_min = -4; 
x_max = 6;  
y_min = -5; 
y_max = 3;  

x = [x_min:0.1:x_max];
y = [y_min:0.1:y_max];

[XX,YY] = meshgrid(x,y);

X = [XX(:)';YY(:)'];
Y = nnet_forward_logloss(X,[],Wi,bi,Wo,bo);

Z = reshape(Y,size(XX,1),size(XX,2));
figure(1); hold off;
contourf(XX,YY,Z);
axis equal; colorbar;

hold on;
indp = find(Ytr==1);
indn = find(Ytr==-1);
h = plot(Xtr(1,indp),Xtr(2,indp),'y.');
set(h,'color',[1,.4,0]);
h = plot(Xtr(1,indn),Xtr(2,indn),'b.');
set(h,'color',[0,.4,1]);
pause(0.001);
drawnow;


end

