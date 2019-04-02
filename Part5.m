[trainVec, trainLabels] = LoadDir('dataset/train/', true, false, 10, 10,9);

SVMStruct = svmtrain(trainVec, trainLabels);

%classify the training and validation vectors
%The training
trainGroup = svmclassify(SVMStruct, trainVec);

%The validation group
[validVec , validationLabels] = LoadDir('dataset/valid/', true, false, 10, 10,9);

validationGroup = svmclassify(SVMStruct, validVec);

%Evaluate the errors:
trainingError =  sum(trainGroup ~= trainLabels) / (2*numel(trainLabels))
validationError =  sum(validationGroup ~= validationLabels) / (2*numel(validationLabels))

ShowResults( 'dataset/valid/', 0, trainingError, 0, validationLabels, validationGroup )
