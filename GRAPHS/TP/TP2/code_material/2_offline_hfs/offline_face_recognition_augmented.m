function [accuracy] = offline_face_recognition()
% [accuracy] = offline_face_recognition()
%     a skeleton function to test offline face recognition, needs to be completed

cc = cv.CascadeClassifier('haarcascade_frontalface_default.xml');

EXTR_FRAME_SIZE = 96;

X = zeros(100,EXTR_FRAME_SIZE^2);
Y = zeros(100,1);

for i = 0:9
    for j = 1:10
        im = imread(sprintf('data/10faces_augmented/%d/%02d.jpg',i,j));
        box = cc.detect(im);
        top_face.area = 0;
        frame.width = size(im,2);
        frame.height = size(im,1);
        for z = 1:length(box)
            rect.x = box{z}(1);
            rect.y = box{z}(2);
            rect.width = box{z}(3);
            rect.height = box{z}(4);
            face_area = rect.width*rect.height;
            if (face_area > top_face.area)
                top_face.area = face_area;
                top_face.x = box{z}(1);
                top_face.y = box{z}(2);
                top_face.width = box{z}(3);
                top_face.height = box{z}(4);
            end
        end

        gray_im = cv.cvtColor(im, 'BGR2GRAY');
        gray_face = gray_im( top_face.y:top_face.y + top_face.height, top_face.x:top_face.x + top_face.width);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Apply preprocessing to balance the image (color/lightning), such    %
        % as filtering (cv.boxFilter, cv.GaussianBlur, cv.bilinearFilter) and %
        % equalization (cv.equalizeHist).                                     %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        gray_face = ;

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %resize the face and reshape it to a row vector
        gray_face = cv.resize(gray_face, [EXTR_FRAME_SIZE, EXTR_FRAME_SIZE]);
        X(sub2ind([10,10],i+1,j),:) = gray_face(:)';
        Y(sub2ind([10,10],i+1,j),1) = i+1;
    end
end


% if you want to plot the dataset, set the following variable to 1

plot_the_dataset = 0;

if plot_the_dataset

    figure(1)
    for i=1:20
        subplot(2,10,i);
        h = imshow(reshape(X(i,:),EXTR_FRAME_SIZE,EXTR_FRAME_SIZE));
        title(num2str(i))
    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% select 4 random labels PER PERSON and reveal them             %
% Y_masked: (n x 1) masked label vector, where entries Y_i      %
%       takes a value in [1..num_classes] if the node is        %
%       labeled, or 0 if the node is unlabeled (masked)         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y_masked = ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% choose the experiment parameter                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

graph_param.graph_type = ; %'knn' or 'eps'
graph_param.graph_thresh = ; % the number of neighbours for the graph or the epsilon threshold
graph_param.sigma2 = ; % exponential_euclidean's sigma^2

laplacian_param.normalization = ; %either 'unn'normalized, 'sym'metric normalization or 'rw' random-walk normalization
laplacian_param.regularization = ; %regularization to add to the laplacian (\gamma_g)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% compute hfs solution using either soft_hfs.m or hard_hfs.m    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

labels = ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(figure(), 'units', 'centimeters', 'pos', [0 0 20 10]);

subplot(1,2,1);
imagesc(reshape(Y,10,10));
title('True labels')

subplot(1,2,2);
imagesc(reshape(labels,10,10));
title('HFS classification')

accuracy = mean(Y == labels);

end
