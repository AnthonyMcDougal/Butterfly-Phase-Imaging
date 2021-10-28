%makeFig4 illustrates the images shown in Fig. 4
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 


%% Pupation time
N14pupationTimeStamp = datetime('2020-08-20 14:13'); %update per sample
pupationTimeStamp = N14pupationTimeStamp;

fullAge = 9.6547; %Full development age for this generation

%% Fig. 4A
filein = ...
"RawData/N-14-08_21_21_10_set_112.mat";
%Specify slices
topSlice = 39;
botSlice = 54;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%% Fig. 4B
filein = ...
"RawData/N-14-08_22_01_55_set_131.mat";
%Specify slices
topSlice = 50;
botSlice = 65;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%% Fig. 4C
filein = ...
"RawData/N-14-08_22_04_10_set_140.mat";
%Specify slices
topSlice = 64;
botSlice = 79;

grab3Dimage(filein,topSlice,botSlice,pupationTimeStamp,fullAge)

%% Fig. 4D
filein = ...
"RawData/N-14-08_22_07_25_set_153.mat";
%Specify slices
topSlice = 86;
botSlice = 101;

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
