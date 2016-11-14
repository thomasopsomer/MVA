function [AP_test, AP_tr] = trainAndTestSVM(category, til, kernel, norm, fraction, pr_curve, rk_plot, encoding, C)
    % Arg Parse
    if nargin == 7
        encoding = 'bovw';
        C = 10;
    elseif nargin == 8
        C = 10;
    end
    
    % %%% DATA PROCESSING
    % Load training data
    pos = load(['data/' category '_train_' encoding '.mat']) ;
    neg = load(['data/background_train_' encoding '.mat']) ;
    names = {pos.names{:}, neg.names{:}};
    histograms_ = [pos.histograms, neg.histograms] ;
    labels_ = [ones(1,numel(pos.names)), - ones(1,numel(neg.names))] ;
    clear pos neg ;
    
    % For stage G: throw away part of the training data
    sel = vl_colsubset(1:numel(labels_), fraction, 'uniform') ;
    names = names(sel) ;
    histograms_ = histograms_(:,sel) ;
    labels_ = labels_(:,sel) ;
    clear sel ;
    
    % Load testing data
    pos = load(['data/' category '_val_' encoding '.mat']) ;
    neg = load(['data/background_val_' encoding '.mat']) ;
    testNames = {pos.names{:}, neg.names{:}};
    testHistograms_ = [pos.histograms, neg.histograms] ;
    testLabels_ = [ones(1,numel(pos.names)), - ones(1,numel(neg.names))] ;
    clear pos neg ;
    
    % Print number of images of each class
    fprintf('Cat %s :: Number of training images: %d positive, %d negative\n', ...
            category, sum(labels_ > 0), sum(labels_ < 0)) ;
    fprintf('Cat %s :: Number of testing images: %d positive, %d negative\n', ...
            category, sum(testLabels_ > 0), sum(testLabels_ < 0)) ;

    % For Stage E: Vary the image representation
    if til
        histograms_ = removeSpatialInformation(histograms_) ;
        testHistograms_ = removeSpatialInformation(testHistograms_) ;
    end

    % For Stage F: use kernel
    if strcmp(kernel, 'hellinger')
        histograms_ = sign(histograms_).*sqrt(abs(histograms_));
        testHistograms_ = sign(testHistograms_).*sqrt(abs(testHistograms_));
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
    
    [w, bias] = trainLinearSVM(histograms_, labels_, C) ;
    
    %  %%% EVALUATE ON TRAINING DATA
    scores = w' * histograms_ + bias ;
    [drop,drop,infoTraining] = vl_pr(labels_, scores);
    AP_tr = infoTraining.auc;
    %  %%% EVALUATE ON TEST DATA
    
    % Test the linear SVM
    testScores = w' * testHistograms_ + bias ;

    % Visualize the results of the classifier:
    if pr_curve
        % precison recall curve
        vl_pr(testLabels_, testScores) ;
        title(sprintf('Precision-recall on test data for cat %s', category))
    end
    
    if rk_plot
        figure; clf;
        % top ranked images
        displayRankedImageList(testNames, testScores)  ;
        title('Ranked test images (subset)')
    end
    
    % Print AP results
    [drop,drop,info] = vl_pr(testLabels_, testScores) ;
    [drop,perm] = sort(testScores,'descend') ;
    fprintf('Cat %s :: Test AP: %.2f\n', category, info.auc) ;
    fprintf('Cat %s :: Correctly retrieved in the top 36: %d\n', category, sum(testLabels_(perm(1:36)) > 0)) ;
    AP_test = info.auc;