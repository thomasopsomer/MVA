function [] = plot_clustering_result(X,Y,W,spectral_labels,kmeans_labels,normalized_switch)

    %set(figure(), 'units', 'centimeters', 'pos', [0 0 30 10]);
    figure()

    if nargin < 6
        normalized_switch = 0;
    end

    h(1) = subplot(1,3,1);
    plot_edges_and_points(X,Y,W,'ground truth');

    h(2) = subplot(1,3,2);
    if normalized_switch
        plot_edges_and_points(X,spectral_labels,W,'unnormalized laplacian');
    else
        plot_edges_and_points(X,spectral_labels,W,'spectral clustering');
    end
    
    h(3) = subplot(1,3,3);
    if normalized_switch
        plot_edges_and_points(X,kmeans_labels,W,'normalized laplacian');
    else
        plot_edges_and_points(X,kmeans_labels,W,'k-means');
    end

    %linkaxes(h,'y')

    %ylim([-2,2])
