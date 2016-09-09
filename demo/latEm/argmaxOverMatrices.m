function [best_score,best_idx] = argmaxOverMatrices(x, y, W)
%
% Code for training latEm(algorithm 1 in the paper) described in  
% Y. Xian, Z. Akata, G. Sharma, Q. Nguyen, M. Hein, B. Schiele. 
% Latent Embeddings for Zero-shot Classification. IEEE CVPR 2016.
% Cite the above paper if you are using this code.
%
% Usage: [best_score,best_idx] = argmaxOverMatrices(x, y, W)
%
% Inputs:
%   x:                  an image embedding instance
%   y:                  a class embedding
%   W:                  a cell array of embeddings
%
%
% Outputs:
%   best_score:         best bilinear score among all the embeddings
%   best_idx:           index of the embedding with the best score
%
% Yongqin Xian
% e-mail: yxian@mpi-inf.mpg.de
% Computer Vision and Multimodal Computing, Max Planck Institute Informatics
% Saarbruecken, Germany
% http://d2.mpi-inf.mpg.de
%
K = length(W);
best_score = -1e12;
best_idx = -1;
score = zeros(K,1);

for i=1:K
	projected_x = x * W{i};
	score(i) = projected_x * y;
	if(score(i) > best_score)
		best_score = score(i);
		best_idx = i;
	end
end