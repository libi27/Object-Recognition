[trainVec, trainLabels] = LoadDir('dataset/train/', true, false, 10, 10, 9);
[validVec , validationLabels] = LoadDir('dataset/valid/', true, false, 10, 10,9);

trainSet_s = size(trainVec, 1);
validSet_s = size(validVec, 1);

lambdas = (-3:0.1:3);
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






