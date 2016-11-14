function [] = plot_classification(X,Y,graph_param,labels)

    figure()

    W = build_similarity_graph(X, graph_param);

    h(1) = subplot(1, 2, 1);
    plot_edges_and_points(X, Y, W, 'ground truth');

    h(2) = subplot(1, 2, 2);
    plot_edges_and_points(X, labels, W, 'HFS');
