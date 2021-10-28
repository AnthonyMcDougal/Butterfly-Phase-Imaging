function [Nyx, centerPx, X, Y] = fourierMap(shiftedFmat)
%fourierMap gets the size, center, X mesh, and Y mesh for a shifted Fourier matrix
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 


Nyx = size(shiftedFmat);
centerPx = floor(Nyx/2) +1;
[X,Y] = meshgrid(1:Nyx(2) , 1:Nyx(1));

end

