cell_x = 10;
cell_y = 10;
B = 9;

[trainCell, trainLabels, height, width] = LoadDir('dataset/train/', true, true, cell_x, cell_y, B);
[validCell , validationLabels] = LoadDir('dataset/valid/', true, true, cell_x, cell_y, B);

k = floor(height/cell_y)-1;
l = floor(width/cell_x)-1;

trainVec = zeros(size(trainLabels, 1), l * k);
validationVec = zeros(size(validationLabels, 1), l * k);

for i=1:k
    for j=1:l
         % Get HOGblock (i,j)
        trainBlock = cell2mat(trainCell(:, i, j));
        validBlock = cell2mat(validCell(:, i, j));
        
        % Train classifier
        SVMStruct = svmtrain(trainBlock, trainLabels);
        W = RidgeTrain(trainBlock, trainLabels, 10^(-2));
        
        % Classify train block
        trainVec(:, i*j) = [trainBlock, ones(size(trainLabels))] * W;

        % Classify valid block
        validationVec(:, i*j) = [validBlock, ones(size(validationLabels))] * W;
    end
end

T = (1 : 20);
trainError = zeros(20, 1);
validError = zeros(20, 1);

validEstimatedLabels = zeros(size(validationLabels, 1), size(T, 2));

for t = T
    %training
    [~,h]=adaboost('train',trainVec,trainLabels,t);
    %applying
    [trainEstimatedLabels]=adaboost('apply',trainVec,h);
    validEstimatedLabels(:,t)=adaboost('apply',validationVec,h);
    %calc error
    trainError(t) = sum(trainLabels ~= trainEstimatedLabels)/numel(trainLabels);
    validError(t) = sum(validationLabels ~= validEstimatedLabels(:,t))/numel(validationLabels);
    
end
ShowResults( 'dataset/valid/', T, trainError, validError, validationLabels, validEstimatedLabels )
