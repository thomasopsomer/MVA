% EXERCISE1: basic training and testing of a classifier

% setup MATLAB to use our software
setup ;

% --------------------------------------------------------------------
% Stage A: Data Preparation
% --------------------------------------------------------------------

% Load training data
encoding = 'bovw' ;
%encoding = 'vlad' ;
%encoding = 'fv' ;

% category = 'motorbike' ;
category = 'aeroplane' ;
%category = 'person' ;

pos = load(['data/' category '_train_' encoding '.mat']) ;
neg = load(['data/background_train_' encoding '.mat']) ;

names = {pos.names{:}, neg.names{:}};
histograms = [pos.histograms, neg.histograms] ;
labels = [ones(1,numel(pos.names)), - ones(1,numel(neg.names))] ;
clear pos neg ;

% Load testing data
pos = load(['data/' category '_val_' encoding '.mat']) ;
neg = load(['data/background_val_' encoding '.mat']) ;

testNames = {pos.names{:}, neg.names{:}};
testHistograms = [pos.histograms, neg.histograms] ;
testLabels = [ones(1,numel(pos.names)), - ones(1,numel(neg.names))] ;
clear pos neg ;

% For stage G: throw away part of the training data
% fraction = .1 ;
% fraction = .5 ;
fraction = +inf ;

sel = vl_colsubset(1:numel(labels), fraction, 'uniform') ;
names = names(sel) ;
histograms = histograms(:,sel) ;
labels = labels(:,sel) ;
clear sel ;

% count how many images are there
fprintf('Number of training images: %d positive, %d negative\n', ...
        sum(labels > 0), sum(labels < 0)) ;
fprintf('Number of testing images: %d positive, %d negative\n', ...
        sum(testLabels > 0), sum(testLabels < 0)) ;

% For Stage E: Vary the image representation
% histograms = removeSpatialInformation(histograms) ;
% testHistograms = removeSpatialInformation(testHistograms) ;

% For Stage F: Vary the classifier (Hellinger kernel)
% ** insert code here for the Hellinger kernel using  **
% ** the training histograms and testHistograms       **

% L2 normalize the histograms before running the linear SVM
histograms = bsxfun(@times, histograms, 1./sqrt(sum(histograms.^2,1))) ;
testHistograms = bsxfun(@times, testHistograms, 1./sqrt(sum(testHistograms.^2,1))) ;

% --------------------------------------------------------------------
% Stage B: Training a classifier
% --------------------------------------------------------------------

% Train the linear SVM. The SVM paramter C should be
% cross-validated. Here for simplicity we pick a valute that works
% well with all kernels.
C = 10 ;
[w, bias] = trainLinearSVM(histograms, labels, C) ;

% Evaluate the scores on the training data
scores = w' * histograms + bias ;

% Visualize the ranked list of images
figure(1) ; clf ; set(1,'name','Ranked training images (subset)') ;
displayRankedImageList(names, scores)  ;

% Visualize the precision-recall curve
figure(2) ; clf ; set(2,'name','Precision-recall on train data') ;
vl_pr(labels, scores) ;

% display relevant visual words that the SVM used to classify images
[~,best] = max(scores) ;
displayRelevantVisualWords(names{best}, w)

% --------------------------------------------------------------------
% Stage C: Classify the test images and assess the performance
% --------------------------------------------------------------------

% Test the linear SVM
testScores = w' * testHistograms + bias ;


% Visualize the ranked list of images
figure(3) ; clf ; set(3,'name','Ranked test images (subset)') ;
displayRankedImageList(testNames, testScores)  ;

% Visualize visual words by relevance on the first image
% [~,best] = max(testScores) ;
% displayRelevantVisualWords(testNames{best},w)

% Visualize the precision-recall curve
figure(4) ; clf ; set(4,'name','Precision-recall on test data') ;
vl_pr(testLabels, testScores) ;

% Print results
[drop,drop,info] = vl_pr(testLabels, testScores) ;
fprintf('Test AP: %.2f\n', info.auc) ;

[drop,perm] = sort(testScores,'descend') ;
fprintf('Correctly retrieved in the top 36: %d\n', sum(testLabels(perm(1:36)) > 0)) ;


% --------------------------------------------------------------------
% Stage D:  Learn a classifier for the other classes and assess its
% performance
% --------------------------------------------------------------------

% Load training data
encoding = 'bovw' ;
%encoding = 'vlad' ;
%encoding = 'fv' ;

categories = {'motorbike', 'aeroplane', 'person'};

% til flag for Stage E
til = true;
if til
    figure;
end

% norm flag for Stage E
norm = 'unn';

% kernel flag for Stage F
kernel = 'hellinger';

for i = 1:size(categories, 2)
    cat = categories{i};
    
    % %%% DATA PROCESSING
    
    % Load training data
    pos = load(['data/' cat '_train_' encoding '.mat']) ;
    neg = load(['data/background_train_' encoding '.mat']) ;
    names = {pos.names{:}, neg.names{:}};
    histograms_ = [pos.histograms, neg.histograms] ;
    labels_ = [ones(1,numel(pos.names)), - ones(1,numel(neg.names))] ;
    clear pos neg ;
    
    % Load testing data
    pos = load(['data/' cat '_val_' encoding '.mat']) ;
    neg = load(['data/background_val_' encoding '.mat']) ;
    testNames = {pos.names{:}, neg.names{:}};
    testHistograms_ = [pos.histograms, neg.histograms] ;
    testLabels_ = [ones(1,numel(pos.names)), - ones(1,numel(neg.names))] ;
    clear pos neg ;
    
    % Print number of images of each class
    fprintf('Cat %s :: Number of training images: %d positive, %d negative\n', ...
            cat, sum(labels_ > 0), sum(labels_ < 0)) ;
    fprintf('Cat %s :: Number of testing images: %d positive, %d negative\n', ...
            cat, sum(testLabels_ > 0), sum(testLabels_ < 0)) ;

    % For Stage E: Vary the image representation
    if til
        histograms_ = removeSpatialInformation(histograms_) ;
        testHistograms_ = removeSpatialInformation(testHistograms_) ;
    end

    % For Stage F: use kernel
    if strcmp(kernel, 'hellinger')
        histograms_ = sqrt(abs(histograms_));
        testHistograms_ = sqrt(abs(testHistograms_));
    end
    
    if strcmp(norm, 'l2')
        % L2 normalize the histograms before running the linear SVM
        histograms_ = bsxfun(@times, histograms_, 1./sqrt(sum(histograms_.^2,1))) ;
        testHistograms_ = bsxfun(@times, testHistograms_, 1./sqrt(sum(testHistograms_.^2,1))) ;
    elseif strcmp(norm, 'l1')
        histograms_ = bsxfun(@times, histograms_, 1./sum(abs(histograms_),1)) ;
        testHistograms_ = bsxfun(@times, testHistograms_, 1./sum(abs(testHistograms_),1)) ;
    end

    % %%% TRAIN SVM
    
    C = 10 ;
    [w, bias] = trainLinearSVM(histograms_, labels_, C) ;
    
    %  %%% EVALUATE ON TEST DATA
    
    % Test the linear SVM
    testScores = w' * testHistograms_ + bias ;

    % Visualize the results of the classifier:
    if til
        % precison recall curve
        subplot(1,3,i); hold on;
        vl_pr(testLabels_, testScores) ;
        title(sprintf('Precision-recall on test data for cat %s', cat))
    else
        figure; clf;
        % top ranked images
        subplot(1,2,1); hold on;    
        displayRankedImageList(testNames, testScores)  ;
        title('Ranked test images (subset)')
        % precison recall curve
        subplot(1,2,2); hold on;
        vl_pr(testLabels_, testScores) ;
        title('Precision-recall on test data')
    end
    
    % Print AP results
    [drop,drop,info] = vl_pr(testLabels_, testScores) ;
    [drop,perm] = sort(testScores,'descend') ;
    fprintf('Cat %s :: Test AP: %.2f\n', cat, info.auc) ;
    fprintf('Cat %s :: Correctly retrieved in the top 36: %d\n', cat, sum(testLabels_(perm(1:36)) > 0)) ;
end


% --------------------------------------------------------------------
% Stage E: Vary the image representation
% --------------------------------------------------------------------

% use Stage D and change tile flag

% use Stage D and change norm flag 

% K(h,h)

% L2 normalize the histograms before running the linear SVM
histograms_l2 = bsxfun(@times, histograms, 1./sqrt(sum(histograms.^2,1))) ;
testHistograms_l2 = bsxfun(@times, testHistograms, 1./sqrt(sum(testHistograms.^2,1))) ;

histograms_l1 = bsxfun(@times, histograms, 1./sum(abs(histograms),1)) ;
testHistograms_l1 = bsxfun(@times, testHistograms, 1./sum(abs(testHistograms),1)) ;

sum((histograms_l2(:, 1) .* histograms_l2(:, 1)))
sum((histograms_l1(:, 1) .* histograms_l1(:, 1)))
sum((histograms(:, 1) .* histograms(:, 1)))


% --------------------------------------------------------------------
% Stage F: Vary the classifier
% --------------------------------------------------------------------

% given histogram and testHistogram from Stage A

% hellinger kernel feature map
histograms = sqrt(histograms);
testHistograms = sqrt(testHistograms);

% L2 normalize the histograms before running the linear SVM
histograms = bsxfun(@times, histograms, 1./sqrt(sum(histograms.^2,1))) ;
testHistograms = bsxfun(@times, testHistograms, 1./sqrt(sum(testHistograms.^2,1))) ;

% For using Hellinger kernel use the kernel flag in Stage D


% --------------------------------------------------------------------
% Stage G: Vary the number of training images
% --------------------------------------------------------------------

categories = {'motorbike', 'aeroplane', 'person'};
til = true;
norm = 'l2';
fractions = [0.1:0.1:0.9 +inf];
pr_curve = false;
rk_plot = false;

% Linear Kernel
for i = 1:size(categories, 2)
    cat = categories{i};
    for j = 1:size(fractions, 2)
        fraction = fractions(j);
        kernel = 'linear';
        AP_linear(i,j) = trainAndTestSVM(cat, til, kernel, norm, fraction, pr_curve, rk_plot);
        kernel = 'hellinger';
        AP_hell(i,j) = trainAndTestSVM(cat, til, kernel, norm, fraction, pr_curve, rk_plot);
    end
end

figure;
subplot(1,2,1); hold on;
plot(0.1:0.1:1, AP_hell, 'LineWidth', 2)
axis([0.1 1 0 0.8])
title('Hellinger Kernel Performance for different fraction of training set')
xlabel('Fraction of training set')
ylabel('Average Precison')
lgd = legend({'Motorbike','Aeroplane', 'Person'}, 'Location', 'southeast');
title(lgd,'Categories')

subplot(1,2,2); hold on;
plot(0.1:0.1:1, AP_linear, 'LineWidth', 2)
axis([0.1 1 0 0.8])
title('Linear Kernel Performance for different fraction of training set')
xlabel('Fraction of training set')
ylabel('Average Precison')
lgd = legend({'Motorbike','Aeroplane', 'Person'}, 'Location', 'southeast');
title(lgd,'Categories')


% --------------------------------------------------------------------
% Stage H: First order methods
% --------------------------------------------------------------------

categories = {'motorbike', 'aeroplane', 'person'};
encodings = {'bovw', 'vlad', 'fv'};
til = true;
norm = 'l2';
fraction = +inf;
pr_curve = false;
rk_plot = false;

for i = 1:size(categories, 2)
    cat = categories{i};
    for j = 1:size(encodings, 2)
        encoding = encodings{j};
        kernel = 'linear';
        AP_linear(i,j) = trainAndTestSVM(cat, til, kernel, norm, fraction, pr_curve, rk_plot, encoding);
        kernel = 'hellinger';
        AP_hell(i,j) = trainAndTestSVM(cat, til, kernel, norm, fraction, pr_curve, rk_plot, encoding);
    end
end

% --------------------------------------------------------------------
% Further work: Tune C for better performance
% --------------------------------------------------------------------

categories = {'motorbike', 'aeroplane', 'person'};
encoding = 'fv';
til = true;
norm = 'l2';
fraction = +inf;
pr_curve = false;
rk_plot = false;
kernel = 'hellinger';
% Cs = [0.1 1 10 100 1000];
Cs = [0.5:0.5:10];

AP_test = zeros(size(categories,2), size(Cs,2));
AP_train = zeros(size(categories,2), size(Cs,2));
for i = 1:size(categories, 2)
    cat = categories{i};
    for j = 1:size(Cs, 2)
        C = Cs(j);
        [ap_test, ap_tr] = trainAndTestSVM(cat, til, kernel, norm, fraction, pr_curve, rk_plot, encoding, C);
        AP_test(i,j) = ap_test;
        AP_train(i,j) = ap_tr;
    end
end

plot(Cs, AP_test, 'LineWidth', 2)
title('Finding best SVM C Paramter for Hellinger kernel with Fisher Vector')
xlabel('C')
ylabel('Average Precison')
lgd = legend({'Motorbike','Aeroplane', 'Person'}, 'Location', 'southeast');
title(lgd,'Categories')
