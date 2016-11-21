% Generate double moon data with labels {-1,1} and save it
%
% <Josef.Sivic@ens.fr>
% Adapted from python from Nicolas Le Roux

npoints = 500;

% Generate npoints points between -pi/2 and pi/2
Theta1 = rand(npoints,1)*pi - pi/2;

% Generate npoints points between pi/2 and 3pi/2
Theta2 = rand(npoints,1)*pi + pi/2

R = 2;
C1 = [0, 0];
C2 = [.8, -1.8];

X1 = zeros(npoints, 2);
X1(:, 1) = R*cos(Theta1) + C1(1) + .6*rand(npoints,1);
X1(:, 2) = R*sin(Theta1) + C1(2) + .6*rand(npoints,1);

X2 = zeros(npoints, 2);
X2(:, 1) = R*cos(Theta2) + C2(1) + .6*rand(npoints,1);
X2(:, 2) = R*sin(Theta2) + C2(2) + .6*rand(npoints,1);


figure(1); clf; hold on;
plot(X1(:,1),X1(:,2),'b.');
plot(X2(:,1),X2(:,2),'r.');

axis equal; grid on;
axis([-2 4 -5 3]);

% concatenate the two
X = [X1; X2];

% target labels
Y                = zeros(npoints*2,1);
Y(1:npoints)     = -1;
Y(npoints+1:end) = 1;
 
save('double_moon.mat','X','Y','-mat');

