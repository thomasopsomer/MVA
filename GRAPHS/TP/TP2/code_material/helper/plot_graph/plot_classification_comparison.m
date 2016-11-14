function [] = plot_classification_comparison(X, Y, graph_param, hard_labels, soft_labels)

    figure()

    W = build_similarity_graph(X, graph_param);

    h(1) = subplot(1,3,1);
    plot_edges_and_points(X, Y, W, 'ground truth');

    h(2) = subplot(1,3,2);
    plot_edges_and_points(X, hard_labels, W, 'Hard-HFS');

    h(3) = subplot(1,3,3);
    plot_edges_and_points(X, soft_labels, W, 'Soft-HFS');
