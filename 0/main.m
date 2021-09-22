%todo:
%   grafiikka


clear
dir

%inits
    %parameters
hiddenNodeAmount = 22;
hiddenLayerAmount = 2;

learningRate = 0.00001;
minibatchSize = 16;

    %dataset load 
load("mnist.mat")
data = trainX;
labels = trainY';

input = normalize(double(data));
labelMatrix = labelsToMatrix(labels);

inputNodeAmount = size(input, 2);
outputNodeAmount = size(labelMatrix, 2);

    %layers
layers{1, 1} = FullyConnected(inputNodeAmount, hiddenNodeAmount);
layers{2, 1} = BatchNormalization(hiddenNodeAmount);
layers{3, 1} = RectifiedLinearUnit();
for layerIndex = 2:hiddenLayerAmount
    layers{1, layerIndex} = FullyConnected(hiddenNodeAmount, hiddenNodeAmount);
    layers{2, layerIndex} = BatchNormalization(hiddenNodeAmount);
    layers{3, layerIndex} = RectifiedLinearUnit();
end
layers{1, hiddenLayerAmount + 1} = FullyConnected(hiddenNodeAmount, outputNodeAmount);
layers{2, hiddenLayerAmount + 1} = BatchNormalization(outputNodeAmount);
layers{3, hiddenLayerAmount + 1} = RectifiedLinearUnit();

meanCosts = [];
rightHypothesisPercentages = [];

%train
minibatchAmount = size(labels,1) / minibatchSize;

for trainingEpoch = 1:5
    disp("training epoch " + trainingEpoch)
    minibatchStartIndex = 1;
    for minibatchIndex = 1:minibatchAmount
        % disp("minibatch index " + minibatchIndex)
        minibatchEndIndex = minibatchStartIndex + minibatchSize - 1;
        
        [meanCost, rightHypothesisPercentage] = train( ...
                input(minibatchStartIndex:minibatchEndIndex, :), ...
                labelMatrix(minibatchStartIndex:minibatchEndIndex, :), ...
                layers, hiddenLayerAmount, learningRate, minibatchSize);
                
        meanCosts = [meanCosts, meanCost];
        rightHypothesisPercentages = [rightHypothesisPercentages, rightHypothesisPercentage];
        minibatchStartIndex = minibatchEndIndex + 1;
    end
    disp("meanCosts = " + mean(meanCosts, "all"))
    disp("right hypothesis % = " + mean(rightHypothesisPercentages, "all"))
    meanCosts = [];
    rightHypothesisPercentages = [];
end
%graph
meanCosts;