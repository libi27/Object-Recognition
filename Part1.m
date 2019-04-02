%get the training set and the training specifier
[trainVec, trainLabels] = LoadDir('dataset/train/', false, false);

%Train a linear SVM
SVMStruct = svmtrain(trainVec, trainLabels);

%classify the training and validation vectors
%The training
trainGroup = svmclassify(SVMStruct, trainVec);

%The validation group
[validVec , validationLabels] = LoadDir('dataset/valid/', false, false);

validationGroup = svmclassify(SVMStruct, validVec);

%Evaluate the errors:
trainingError =  sum(trainGroup ~= trainLabels) / numel(trainLabels)
validationError =  sum(validationGroup ~= validationLabels) / numel(validationLabels)

ShowResults( 'dataset/valid/', 0, trainingError, 0, validationLabels, validationGroup )
