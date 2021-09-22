classdef FullyConnected < handle
    properties
        weights;
        gradients;
        weightedSum;
    end
    
    methods
        function self = FullyConnected(inputNodeAmount, outputNodeAmount)
            %normally distributed HE init
            self.weights = randn(outputNodeAmount, inputNodeAmount);
            self.weights = self.weights .* sqrt(2/inputNodeAmount);
        end
        
        function output = forwardPass(self, input)
        self.weightedSum = input * self.weights';
        output = self.weightedSum;
        end
        
        function inputDerivatives = backwardPass(self, input, ...
                    outputDerivatives, learningRate)
        self.gradients = outputDerivatives' * input;
        inputDerivatives = outputDerivatives * self.weights;
        
        self.applyGradients(learningRate);
        end
        
        function applyGradients(self, learningRate)
        self.gradients = self.gradients * learningRate;
        self.weights = self.weights - self.gradients;
        end
    end
end

