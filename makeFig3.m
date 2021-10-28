%makeFig3 illustrates the images in Fig. 3
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 


%% Pupation time
N14pupationTimeStamp = datetime('2020-08-20 14:13'); %update per sample
pupationTimeStamp = N14pupationTimeStamp;

fullAge = 9.6547; %Full development age for this generation

%% Fig. 3A
filein = ...
"RawData/N-14-08_21_02_17_set_37.mat";
%Specify slices
topSlice = 33;
botSlice = 48;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)


%% Fig. 3B
filein = ...
"RawData/N-14-08_22_01_55_set_131.mat";
%Specify slices
topSlice = 50;
botSlice = 65;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%% Fig. 3C
filein = ...
"RawData/N-14-08_23_20_06_set_299.mat";
%Specify slices
topSlice = 143;
botSlice = 185;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%% Fig. 3D
filein = ...
"RawData/N-14_loc2-08_24_21_04_set_26.mat";
%Specify slices
topSlice = 159;
botSlice = 174;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%% Fig. 3E
filein = ...
"RawData/N-14_loc3-08_26_13_06_set_87.mat";
%Specify slices
topSlice = 161;
botSlice = 176;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%% Fig. 3F
filein = ...
"RawData/N-14_loc3-08_30_04_06_set_433.mat";
%Specify slices
topSlice = 99;
botSlice = 114;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)


%%

function grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%Load data
load(filein)

%age of pupa after pupation
imgTimeStamp = datetime(par.Start_Time);
currentAge = days(imgTimeStamp - pupationTimeStamp);
percentDev = 100*currentAge/fullAge;

%Process interferogram for complex data
Pimgs = ima2full(IMG, par.ref);

% Visualize Volume 

%Define colormap
cmap = flipud(ice2);

%Process stack for color
colorVolume = color3d(abs(Pimgs),topSlice,botSlice,cmap);

%display
figure
imshow(colorVolume)
axis image
title(['Butterfly N14 at ' num2str(percentDev, '%0.2f'), '% of development, slices ' num2str(topSlice), '-', num2str(botSlice)])
end
