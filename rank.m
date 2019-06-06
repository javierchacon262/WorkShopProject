function [vecfab, OG] = rank(matGP)
s2 = size(matGP, 2);
s3 = size(matGP, 3);
f.orden = [];
OG.orden = [];
vecfab = [];
for i = 1:s3
    vecfab = [vecfab; f];
end
for i = 1:s2
    vecsum = zeros(1, s3);
    for j = 1:s3
        vecsum(j) = sum(matGP(:, i, j));
    end
    [t, idx] = min(vecsum);
    vecfab(idx).orden = [vecfab(idx).orden, [i; t]];
    OG.orden = [OG.orden, [i; t]];
end
vecfab = vecfab';
end