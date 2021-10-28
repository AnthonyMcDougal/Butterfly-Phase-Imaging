function [meanNew,varNew] = pooledMeanVar(nX, meanX, varX)
%pooledMeanVar calculates the pooled mean and pooled variance of nX data
%points

meanNew = sum(nX.*meanX) / sum(nX);

varNew = ( sum((nX - 1).*varX + nX.*(meanX.^2)) - sum(nX)*meanNew^2 ) / (sum(nX) - 1);

end

