function [ w ] = RidgeTrain(X, y, lambda)
% Inputs
% • X: m-by-d real matrix where each row holds a training vector.
% • y: m-element real column vector where entry i holds the label of row i in X.
% • lambda: Positive scalar – regularization parameter ? .
% Outputs
% • w: d+1-element column vector representing the trained regressor.

[m,d] = size(X);
X1 = [X,ones(m,1)];
w = (X1'*X1 + 2 * lambda * eye(d+1))\(X1'*y);

end