function [] = plot_the_bend(X, Y, W, spectral_labels, eigenvalues_sorted)

    %set(figure(), 'units', 'centimeters', 'pos', [0 0 30 10]);

    h(1) = subplot(1,3,1);
    plot_edges_and_points(X,Y,W,'ground truth');

    h(2) = subplot(1,3,2);
    plot_edges_and_points(X,spectral_labels,W,'spectral clustering');
    
    h(3) = subplot(1,3,3);
    plot(1:length(eigenvalues_sorted),eigenvalues_sorted,'xb','LineWidth',2);
    ylim([0, max(eigenvalues_sorted)]);
    axis square;

    %linkaxes(h,'y')

    %ylim([-2,2])
