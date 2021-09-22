classdef BatchNormalization < handle
    properties
        beta;
        gamma;
        mean;
        variance;
        invertedSquaredVariance;
        normalizedInput;
        meanSubtractedInput;
        squaredVariance;
        
        betaGradient;
        gammaGradient;
    end
    
    methods
        function self = BatchNormalization(nodeAmount)
            self.beta = zeros(1, nodeAmount);
            self.gamma = ones(1, nodeAmount);            
        end
        
        function output = forwardPass(self, input)
        self.mean = mean(input, 1);
        self.variance = var(input, 0, 1);
        self.meanSubtractedInput = input - self.mean;
        self.squaredVariance = sqrt(self.variance + eps);
        self.invertedSquaredVariance = 1 ./ self.squaredVariance;    
        self.normalizedInput = self.meanSubtractedInput .* self.invertedSquaredVariance;

        output = self.normalizedInput .* self.gamma + self.beta;
        end
        

        
        
        function inputDerivatives = backwardPass(self, outputDerivatives, trainingSetSize, learningRate) 
            
        normalizedInputDerivates = outputDerivatives .* self.gamma;
        
%         firstPart = (1/trainingSetSize) * self.invertedSquaredVariance
%         secondPart = (trainingSetSize*normalizedInputDerivates) - sum(normalizedInputDerivates)
%         thirdPart = self.normalizedInput .* sum((normalizedInputDerivates .* self.normalizedInput))

        inputDerivatives = (1/trainingSetSize) * self.invertedSquaredVariance .* ...
                (trainingSetSize*normalizedInputDerivates - sum(normalizedInputDerivates) - ...
                self.normalizedInput .* sum((normalizedInputDerivates .* self.normalizedInput)));

        self.betaGradient = sum(outputDerivatives);
        self.gammaGradient = sum(self.normalizedInput .* outputDerivatives);
        
        self.applyGradients(learningRate)
        end
        
        function applyGradients(self, learningRate)
        self.betaGradient = self.betaGradient * learningRate;
        self.gammaGradient = self.gammaGradient * learningRate;
        self.beta = self.beta - self.betaGradient;
        self.gamma = self.gamma - self.gammaGradient;
        end
        
    end

end

