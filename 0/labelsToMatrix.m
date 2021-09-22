function labelMatrix = labelsToMatrix(labels)
labels = double(labels);

%labels 0 indexed, matlab 1 indexed
labelMatrix = zeros(size(labels, 1), max(labels) + 1);

for row = 1:size(labels)
    labelMatrix(row, labels(row) + 1) = 1;
end
end