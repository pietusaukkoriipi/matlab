file = readmatrix("aapl.us.txt");
file(:, 7) = [];
file(:, 1) = [];

labels = [];
inputs = [];

for index = 6:5:length(file(:, 1))
    labels(end+1) = file(index, 1);
end

for index = 1:5:length(file(:, 1))-5
    temp = [];
    for subIndex = 0:4
        temp = [temp, file(index+subIndex, :)];
    end
    inputs(end+1, :) = temp;
end
writematrix(inputs, "stockValueInputs.csv");
writematrix(labels', "stockvalueLabels.csv")

file = [inputs labels'];
writematrix(file, "stockValue.csv");
