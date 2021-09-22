disp("es")
oness = ones(1000,1000);
twoss = 1 + ones(1000,1000);
zeross = zeros(1000,1000);

tic
oness * twoss;
toc
tic
oness * zeross;
toc
tic
zeros * twoss;
toc
tic
twoss * oness;
toc

disp("ess")
tic
oness * twoss;
toc
tic
oness * zeross;
toc
tic
zeros * twoss;
toc
tic
twoss * oness;
toc