%makeFig2 illustrates the quantitative phase data shown in Fig. 2
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 


%% Load data
filein = ...
"RawData/F43_4.mat";
pupationTimeStamp = datetime('2019-08-30 12:35'); %manual record

%% Process data

%Load data
load(filein)

%age of pupa after pupation
imgTimeStamp = datetime(data.exp_time);
currentAge = days(imgTimeStamp - pupationTimeStamp);

%Process interferogram for complex data
Pimgs = ima2full(data.IMG, data.ref);

%% Deconvolution

load('RawData\3DPSF.mat')
Pimgs_lr = deconvlucy(abs(Pimgs),abs(dat.psf3D));
Pimgs_lr = (Pimgs_lr)/max(Pimgs_lr(:));

%% Extract amplitude and phase components

%Sample slice
sliceNum = 76;
PimgsLR_sample = Pimgs_lr(:,:,sliceNum);

%Get amplitude component 
amp_Pimgs_sample = abs(PimgsLR_sample);

%Show image components 
figure, imagesc(amp_Pimgs_sample), axis image, title('Amplitude component'), colormap(gray)

%% Visualize phase gradient orientation

%Calculate the phase 
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
colorVolume = color3d(abs(Pimgs_lr),topSlice,botSlice,cmap);

%display
figure
imshow(colorVolume)
axis image
title(['Colored deconvolved volumetric representation, slices ' num2str(topSlice), '-', num2str(botSlice)])

%% plot phase profiles: Down ridge

%end points
endPoints = [458.761909514898,648.063550576532;569.678645009302,703.428526264946];

%extract profile using endpoints
[profileLength, profileHeight] = getFinalProfile(angle(Pimgs(:,:,sliceNum)),endPoints);

%plot trace on data
figure, imagesc(Pimgs_pGrad(:,:,sliceNum)), axis image, title('Traced profile, down ridge'), colormap(twilight)
myLine = drawline('Position',endPoints);

%plot profile
figure
plot(profileLength, 1000*profileHeight)
title('Profile down ridge')
ylabel(['Surface profile (nm)']);
xlabel(['Longitudinal distance (', char(0181),'m, along scale surface)'])

%% plot phase profiles: Across ridges

%end points
endPoints = [431.378265419240,756.422724423360;492.573960405604,648.613218066778];

%extract profile using endpoints
[profileLength, profileHeight] = getFinalProfile(angle(Pimgs(:,:,sliceNum)),endPoints);

%plot trace on data
figure, imagesc(Pimgs_pGrad(:,:,sliceNum)), axis image, title('Traced profile, across ridges'), colormap(twilight)
myLine = drawline('Position',endPoints);

%plot profile
figure
plot(profileLength, 1000*profileHeight)
title('Profile across ridges')
ylabel(['Surface profile (nm)']);
xlabel(['Longitudinal distance (', char(0181),'m, along scale surface)'])
