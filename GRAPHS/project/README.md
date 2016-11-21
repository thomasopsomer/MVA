# Learning graph embedding

How to efficiently learn low-dimensional representation of graph preserving structural and similarity information, to reduce the graph dimension and improve statistical learning task such as node labelling, clustering, missing link prediction... ?

## Description

Supervised machine learning algorithm requires a set of features. For graph, people have to build feature vector representation for the nodes and edges. Typical solutions involves hand-engineering domain-specific features but can be tedious, requires domain specific expertize and do not generalize well across taks.

An alternative approach is to learn feature representations [1] by solving an optimization problem in an unsupervised way using an objective function independent of the downstream task. Classic approaches for dimensionality reduction (PCA, Multi-Dimensional Scaling ...) uses the graph representeded by a matrix (such as the Laplacian) and consequently become very expensive when the network gets very big.

Recent scalable and successful approaches in Natural Language Modeling to learn word embedding [2] can be extended to graphs structures in order to learn those node and edges embedding [3] and brings performance improvement in supervised tasks.

The goal of this project is to understand those technics for graph embedding mainly introduced in the DeepWalk paper. Experiment on real graph dataset. Look for limits or improvement on the node sampling part (Different strategy to preserve information / structure from the graph, for instance recent papers [4], [5]) or in the neural network part for embedding.


## Paper Resources:

- [[1] Y. Bengio, A. Courville, and P. Vincent. Representation learning: A review and new perspectives](http://www.cl.uni-heidelberg.de/courses/ws14/deepl/BengioETAL12.pdf)

- [[2] T. Mikolov, K. Chen, G. Corrado, and J. Dean. Efficient estimation of word representations in vector space](https://arxiv.org/pdf/1301.3781v3.pdf)

- [[3] B. Perozzi, R. Al-Rfou, and S. Skiena. DeepWalk: Online learning of social representations](https://arxiv.org/pdf/1403.6652v2.pdf)

- [[4] A. Grover , and J. Leskovec. node2vec: Scalable feature learning for networks](https://cs.stanford.edu/people/jure/pubs/node2vec-kdd16.pdf)

- [[5] J. Tang, M. Qu, M. Wang, M. Zhang, J. Yan, Q. Mei,  Line: Large-scale information network embedding](http://www.www2015.it/documents/proceedings/proceedings/p1067.pdf)


### DeepWalk:
DeepWalk uses local information obtained from trun- cated random walks to learn latent representations by treat- ing walks as the equivalent of sentences.
DeepWall learns social representations of a graph’s vertices, by mod- eling a stream of short random walks.
DeepWalk learns structural reg- ularities present within short random walks.

Sec- ondly, relying on information obtained from short random walks make it possible to accommodate small changes in the graph structure without the need for global recomputation.


### Node2Vec
In node2vec, we learn a mapping of nodes to a low-dimensional space of features that maximizes the likelihood of preserving network neighborhoods of nodes.

task-independent representations in complex networks.

2nd order random walk approach to generate (sample) network neighborhoods for nodes.

difference / improvement compare to DeepWalk:
Our key contribution is in defining a flexible notion of a node’s network neighborhood. By choosing an appropriate notion of a neighborhood, node2vec can learn representations that organize nodes based on their network roles and/or communities they be- long to. We achieve this by developing a family of biased random walks, which efficiently explore diverse neighborhoods of a given node.


Experiment: multi-label classification and link prediction in several real-world networks from diverse domains. 


Scalable, Online


### SkipGram Model
T. Mikolov, K. Chen, G. Corrado, and J. Dean. Efficient estimation of word representations in vector space. In ICLR, 2013.



## Data Resources:

[snap](https://snap.stanford.edu/data/index.html)