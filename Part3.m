%PART3 Summary of this function goes here
%   Detailed explanation goes here

[trainVec, trainLabels] = LoadDir('dataset/train/', false, false);
[validVec, validLabels] = LoadDir('dataset/valid/', false, false);


trainSet_s = size(trainVec, 1);
validSet_s = size(validVec, 1);

lambdas = (4:0.1:10);
error_s = size(lambdas, 2);
trainError = zeros(error_s, 1);
validError = zeros(error_s, 1);

iteration = 1;


X_train = [trainVec,ones(trainSet_s,1)];
X_valid = [validVec,ones(validSet_s,1)];

for i = lambdas
   
    lambda = 10^i;
    w = RidgeTrain(trainVec, trainLabels, lambda);
    
    trainEstimatedLabels = sign(X_train*w);
    validEstimatedLabels = sign(X_valid*w);
    
    trainError(iteration) = sum(trainLabels ~= trainEstimatedLabels)/(2*numel(trainLabels));
    validError(iteration) = sum(validLabels ~= validEstimatedLabels)/(2*numel(validLabels));
    
    iteration = iteration + 1;
end
ShowResults( 'dataset/valid/', lambdas, trainError, validError, validationLabels, validEstimatedLabels )

