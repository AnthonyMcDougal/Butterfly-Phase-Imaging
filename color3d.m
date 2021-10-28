function [dataout] = color3d(data,startslice,stopslice,cmap)
%color3d creates a 2D image with color-coded height.
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 
%   Code for getting the color representation of 3D amplitude data. 
%   based on the Temporal-Color Code plugin by Kota Miura for Fiji / ImageJ

%% color each slice
datamax = max(data(:));
ncmap = size(cmap,1);
nslices = stopslice-startslice+1;
newdata = zeros([size(data,1), size(data,2), nslices, 3]);

for i = 1:nslices

    % get color scale
    depthPos = ceil((ncmap/nslices) * i);
    depthColor = cmap(depthPos,:);    
    
    % apply colorscale
    newdata(:,:,i,1) = depthColor(1) * data(:,:,i+startslice-1) /(datamax);
    newdata(:,:,i,2) = depthColor(2) * data(:,:,i+startslice-1) /(datamax);
    newdata(:,:,i,3) = depthColor(3) * data(:,:,i+startslice-1) /(datamax);

end

%% project stack to one slice
colordata2d = squeeze(max(newdata,[],3));
colordata2d = colordata2d/(max(colordata2d(:)));

%% adjust color
dataout = imadjust(colordata2d,[0,0,0; .5 .5 .5],[]);


end

