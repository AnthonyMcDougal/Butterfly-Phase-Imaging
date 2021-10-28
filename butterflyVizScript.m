%butterflyVizScript Script to demonstrate techniques used to visualize buttefly phase data.
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Load data
filein = ...
"RawData/F43_4.mat";

%% Process data

%Load data
load(filein)

%Process interferogram for complex data
Pimgs = ima2full(data.IMG, data.ref);

%% Extract amplitude and phase components

%Sample slice
sliceNum = 76;
Pimgs_sample = Pimgs(:,:,sliceNum);

%Get amplitude component 
amp_Pimgs_sample = abs(Pimgs_sample);

%Get phase component
phase_Pimgs_sample = angle(Pimgs_sample);

%Show image components 
figure, imagesc(amp_Pimgs_sample), axis image, title('Amplitude component')
figure, imagesc(phase_Pimgs_sample), axis image, title('Phase component'), colormap(twilight)

%% Visualize phase gradient orientation

%Calculate the phase gradient
Pimgs_pGrad = phaseGradOr(Pimgs);

%Display sample slice
figure, imagesc(Pimgs_pGrad(:,:,sliceNum)), axis image, title('Orientation of the phase gradient'), colormap(twilight)


%% Visualize Volume 

%Define colormap
cmap = flipud(ice2);

%Crop volume
topSlice = 73;
botSlice = 88;

%Process stack for color
colorVolume = color3d(abs(Pimgs),topSlice,botSlice,cmap);

%display
figure
imshow(colorVolume)
axis image
title(['Colored volumetric representation, slices ' num2str(topSlice), '-', num2str(botSlice)])

%% plot phase profiles

%end points
endPoints = [458.761909514898,648.063550576532;569.678645009302,703.428526264946];

%extract profile using endpoints
[profileLength, profileHeight] = getFinalProfile(phase_Pimgs_sample,endPoints);

%plot trace on data
figure, imagesc(Pimgs_pGrad(:,:,sliceNum)), axis image, title('Traced profile'), colormap(twilight)
myLine = drawline('Position',endPoints);

%plot profile
figure
plot(profileLength, 1000*profileHeight)
title('Profile')
ylabel(['Surface profile (nm)']);
xlabel(['Longitudinal distance (', char(0181),'m, along scale surface)'])

