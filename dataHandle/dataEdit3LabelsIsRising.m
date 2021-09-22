file = readmatrix("stockValue.csv");

labels = file(:, end) > file(:, 1);

writematrix(labels, "stockValueLabelsIsRising.csv")