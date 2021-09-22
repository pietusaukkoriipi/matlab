file = readmatrix("quarterlyfinancials.csv");
nanValueAmounts = sum(isnan(file));

for nanValueIndex = length(file(1,:)):-1:1
    if nanValueAmounts(nanValueIndex) > 50000
        file(:, nanValueIndex) = [];
    end
end


file(any(isnan(file),2),:) = []; 




