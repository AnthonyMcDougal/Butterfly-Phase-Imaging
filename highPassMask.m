function maskout = highPassMask(fData, maxFreqYX)
%highPassMask makes a binary mask for shifted Fourier image
%   
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

[Nyx, centerPx, X, Y] = fourierMap(fData);

fs = 1; %pixel fequency, convert px to microns later
df = fs./Nyx;

n_f = maxFreqYX ./ df;

maskout = ((X-centerPx(2))/n_f(2)).^2 + ((Y-centerPx(1))/n_f(1)).^2  >  1;

end

