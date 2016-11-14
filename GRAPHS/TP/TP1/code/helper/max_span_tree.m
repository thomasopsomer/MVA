% Prim's maximal spanning tree algorithm
% Prim's alg idea:
%  start at any node, find closest neighbor and mark edges
%  for all remaining nodes, find closest to previous cluster, mark edge
%  continue until no nodes remain
%
% INPUTS: graph defined by adjacency matrix, nxn
% OUTPUTS: matrix specifying maximum spanning tree (subgraph), nxn
%
% Other routines used: isConnected.m
% GB: Oct 7, 2012


%Copyright (c) 2013, Massachusetts Institute of Technology. All rights
%reserved. Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions are met:

%- Redistributions of source code must retain the above copyright notice, this
%list of conditions and the following disclaimer.
%- Redistributions in binary
%form must reproduce the above copyright notice, this list of conditions and
%the following disclaimer in the documentation and/or other materials provided
%with the distribution.
%- Neither the name of the Massachusetts Institute of
%Technology nor the names of its contributors may be used to endorse or promote
%products derived from this software without specific prior written permission.

%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
%FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
%DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
%SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
%OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
%OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function tr = max_span_tree(adj)

% check if graph is connected:
if not(is_connected(adj)); printf('This graph is not connected. No spanning tree exists.\n'); return; end

n = length(adj); % number of nodes
tr = zeros(n);   % initialize tree

adj(find(adj==0))=-inf; % set all zeros in the matrix to -inf

conn_nodes = 1;        % nodes part of the max-span-tree
rem_nodes = [2:n];     % remaining nodes

while length(rem_nodes)>0

  [maxlink]=max(max(adj(conn_nodes,rem_nodes)));
  ind=find(adj(conn_nodes,rem_nodes)==maxlink);

  [ind_i,ind_j] = ind2sub([length(conn_nodes),length(rem_nodes)],ind(1));

  i=conn_nodes(ind_i); j=rem_nodes(ind_j); % gets back to adj indices
  tr(i,j)=1; tr(j,i)=1;
  conn_nodes = [conn_nodes j];
  rem_nodes = setdiff(rem_nodes,j);

end
