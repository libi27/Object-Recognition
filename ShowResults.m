function ShowResults( path, range, trainError, validError, validationLabels, validEstimatedLabels )
pos = dir(strcat(path, 'VldP*.pgm'));
neg = dir(strcat(path, 'VldN*.pgm'));
files = vertcat(neg, pos);



if validError == 0
    bestEstim = validEstimatedLabels;
else
    figure; plot(range, trainError, 'b');
    hold on; plot(range, validError, 'r'); 
    title('Error Plot');
    xlabel('range');
    ylabel('error');
    legend('Training', 'Validation');
    min(validError)
    index = find(validError == min(validError));
    if size(validEstimatedLabels,2) > 1
        bestEstim = validEstimatedLabels(:, index(1));
    else
        bestEstim = validEstimatedLabels;
    end
end

pickVec = validationLabels ~= bestEstim;
indVec = find(pickVec);

falsePositive = indVec(validationLabels(pickVec) == -1, 1);
falseNegative = indVec(validationLabels(pickVec) == 1, 1);



display('False Positive')
files(falsePositive).name
display('False Negative')
files(falseNegative).name

display(sprintf('Validation error: %f', (numel(falsePositive) + ....
    numel(falseNegative)) / numel(files)));


img= imread(strcat(path,files(falsePositive(1)).name));
figure,
imshow(img)
title(files(falsePositive(1)).name);

if length(falsePositive) > 1
    img= imread(strcat(path,files(falsePositive(2)).name));
    figure,
    imshow(img)
    title(files(falsePositive(2)).name);
end
img= imread(strcat(path,files(falseNegative(1)).name));
figure,
imshow(img)
title(files(falseNegative(1)).name);

if length(falseNegative) > 1
    img= imread(strcat(path,files(falseNegative(2)).name));
    figure,
    imshow(img)
    title(files(falseNegative(2)).name);
end

end

