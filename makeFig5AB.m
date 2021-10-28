%makeFig5AB illustrates the images and data shown in Fig. 5A-B
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Pupation time
A40pupationTimeStamp = datetime('2020-01-06  07:48');
pupationTimeStamp = A40pupationTimeStamp; 

fullAge = 11.848; %Full development age for this generation


%%
% Load data
filein = ...
"RawData/A-40-01_10_10_52_set_97.mat";

% Process data

%Load data
load(filein)

%age of pupa after pupation
imgTimeStamp = datetime(data.Start_Time);
currentAge = days(imgTimeStamp - pupationTimeStamp);
percentDev = 100*currentAge/fullAge;

%Process interferogram for complex data
Pimgs = ima2full(data.IMG, data.ref);

% Visualize Volume 

%Define colormap
cmap = flipud(ice2);

%Crop volume
topSlice = 87;
botSlice = 102;
pSlice = 98;

%Process stack for color
colorVolume = color3d(abs(Pimgs),topSlice,botSlice,cmap);

%display
figure
imshow(colorVolume)
axis image
title(['Butterfly A40 at ' num2str(percentDev, '%0.2f'), '% of development, slices ' num2str(topSlice), '-', num2str(botSlice)])

% plot phase profiles

%end points
endPoints = [378.362094117161,212.789462206768;453.940403127021,150.962901919349];

%extract profile using endpoints
[profileLength, profileHeight] = getFinalProfile(angle(Pimgs(:,:,pSlice)),endPoints);

%Calculate the phase gradient
Pimgs_pGrad = phaseGradOr(Pimgs);

%plot trace on data
figure, imagesc(Pimgs_pGrad(:,:,pSlice)), axis image, colormap(twilight)
title(['Traced profile, on Butterfly A40 at ' num2str(percentDev, '%0.2f'), '% of development, slice' num2str(pSlice)])
myLine = drawline('Position',endPoints);

%plot profile
figure
plot(profileLength, 1000*profileHeight)
title(['Profile of Butterfly A40 at ' num2str(percentDev, '%0.2f'), '% of development'])
ylabel(['Surface profile (nm)']);
xlabel(['Longitudinal distance (', char(0181),'m, along scale surface)'])

ax = gca;
ax.YLim = [-20, 150*1.1];
ax.XLim = [0-.2, 7+.2];

f = gcf;
f.Units = 'normalized';
f.Position(3:4) = [0.3, 0.15];

%%
% Load data
filein = ...
"RawData/A-40-01_11_04_34_set_115.mat";

% Process data

%Load data
load(filein)

%age of pupa after pupation
imgTimeStamp = datetime(data.Start_Time);
currentAge = days(imgTimeStamp - pupationTimeStamp);
percentDev = 100*currentAge/fullAge;

%Process interferogram for complex data
Pimgs = ima2full(data.IMG, data.ref);

% Visualize Volume 

%Define colormap
cmap = flipud(ice2);

%Crop volume
topSlice = 38;
botSlice = 53;
pSlice = 43;

%Process stack for color
colorVolume = color3d(abs(Pimgs),topSlice,botSlice,cmap);

%display
figure
imshow(colorVolume)
axis image
title(['Butterfly A40 at ' num2str(percentDev, '%0.2f'), '% of development, slices ' num2str(topSlice), '-', num2str(botSlice)])

% plot phase profiles

%end points
endPoints = [645.894535791491,810.337204060934;723.609914861227,755.527045213829];

%extract profile using endpoints
[profileLength, profileHeight] = getFinalProfile(angle(Pimgs(:,:,pSlice)),endPoints);

%Calculate the phase gradient
Pimgs_pGrad = phaseGradOr(Pimgs);

%plot trace on data
figure, imagesc(Pimgs_pGrad(:,:,pSlice)), axis image, colormap(twilight)
title(['Traced profile, on Butterfly A40 at ' num2str(percentDev, '%0.2f'), '% of development, slice' num2str(pSlice)])
myLine = drawline('Position',endPoints);

%plot profile
figure
plot(profileLength, 1000*profileHeight)
title(['Profile of Butterfly A40 at ' num2str(percentDev, '%0.2f'), '% of development'])
ylabel(['Surface profile (nm)']);
xlabel(['Longitudinal distance (', char(0181),'m, along scale surface)'])

ax = gca;
ax.YLim = [-20, 150*1.1];
ax.XLim = [0-.2, 7+.2];

f = gcf;
f.Units = 'normalized';
f.Position(3:4) = [0.3, 0.15];
