classdef RectifiedLinearUnit < handle
    methods(Static)
        function output = forwardPass(input)
        output = max(0,input);
        end
        
        function inputDerivatives = backwardPass(outputDerivatives)
        inputDerivatives = outputDerivatives .* double(outputDerivatives > 0);
        end
    end
end

