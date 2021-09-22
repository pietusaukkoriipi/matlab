function [meanCost, rightHypothesisPercentage] = train(input, labelMatrix, layers, ...
        hiddenLayerAmount, learningRate, minibatchSize)

startingInput = input;
%forwardpass
for layerIndex = 1:hiddenLayerAmount + 1
    %weightedSum
    input = layers{1, layerIndex}.forwardPass(input);
%     %batchnorm
    input = layers{2, layerIndex}.forwardPass(input);
    %relu
    input = RectifiedLinearUnit.forwardPass(input);
end
hypothesis = input;


%backprop
    %errors
errorDerivatives = hypothesis - labelMatrix;

%quess
biggestHypothesis = max(hypothesis, [], 2);
quess = hypothesis == biggestHypothesis;
quessRightness = sum(quess == labelMatrix, 2) == 10;
rightHypothesisPercentage = mean(quessRightness, "all");


    %cost
squaredCost = errorDerivatives .^ 2;
meanCost = mean(squaredCost, "all");
%backwardPass
for layerIndex = hiddenLayerAmount+1:-1:2
    %relu
    errorDerivatives = RectifiedLinearUnit.backwardPass(errorDerivatives);
%     %batchnorm
    errorDerivatives = layers{2, layerIndex}.backwardPass( ...
            errorDerivatives, minibatchSize, learningRate);
    %dense
    errorDerivatives = layers{1, layerIndex}.backwardPass( ... 
            layers{1, layerIndex - 1}.weightedSum, errorDerivatives, learningRate);
end
    %relu
errorDerivatives = RectifiedLinearUnit.backwardPass(errorDerivatives);
%     %batchnorm
errorDerivatives = layers{2, 1}.backwardPass( ...
        errorDerivatives, minibatchSize, learningRate);
    %dense
errorDerivatives = layers{1, 1}.backwardPass( ... 
        startingInput, errorDerivatives, learningRate);
    
    
    
end