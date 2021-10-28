%makeFig1 illustrates the images in Fig. 1, adult scale
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Import and process data

filepathin = ...
'RawData\M08_scale2_zscan2.mat';
filepathin = char(filepathin);

load(filepathin)
load('RawData\speckleRef.mat')
Pimgs = ima2(data.IMG, refref);

%% Deconvolution

load('RawData\3DPSF.mat')
Pimgs_lr = deconvlucy(abs(Pimgs),abs(dat.psf3D));
Pimgs_lr = (Pimgs_lr)/max(Pimgs_lr(:));

%% Visualize Volume 

%Define colormap
cmap = flipud(ice2);

%Crop volume
topSlice = 18;
botSlice = 18+16;

%Process stack for color
colorVolume = color3d(Pimgs_lr,topSlice,botSlice,cmap);

%display
figure
imshow(colorVolume)
axis image
title(['Colored volumetric representation, slices ' num2str(topSlice), '-', num2str(botSlice)])

%% masked phase
slice = 23;

%make mask from amplitude data
premask = mat2gray(abs(Pimgs(:,:,slice)));
maskupper = .25;
masklower = .01;
premask(premask > maskupper) = maskupper;
premask(premask < masklower) = masklower;
mask = mat2gray(premask);

%create
RGBphase = ind2rgb(im2uint8(mat2gray(angle(Pimgs(:,:,slice)))),twilight);
RGBphase(:,:,1,:) = mask.* RGBphase(:,:,1,:);
RGBphase(:,:,2,:) = mask.* RGBphase(:,:,2,:);
RGBphase(:,:,3,:) = mask.* RGBphase(:,:,3,:);

%make figure
figure, imshow(RGBphase)
title(['Masked phase data, slices ' num2str(topSlice), '-', num2str(botSlice)])
