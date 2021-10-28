%Example script of approach used to manually measure phrase profiles
% Example file referenced below
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Input data
filepathin = ...
"RawData\A-40-01_10_10_52_set_97.mat";
pupationTimeStamp = datetime('2020-01-06  07:48');

%Load data
load(filepathin)

%Process interferogram for complex data
Pimgs = ima2full(data.IMG, data.ref);

%Calculate the phase gradient
Pimgs_pGrad = phaseGradOr(Pimgs);

% Grab time, age, specimen id from file name
filepathin2 = char(strrep(filepathin,'\','/'));

filenamepos = find(filepathin2=='/', 1, 'last')+1;
filenameINpre = filepathin2(filenamepos:end-4);
setIDpos = find(filenameINpre=='_', 1, 'last')+1;
setID = str2num(filenameINpre(setIDpos:end));

imgTimeStamp = datetime(data.Start_Time);
currentAge = (imgTimeStamp - pupationTimeStamp);
currentAgeStr = ['d' , num2str(days(currentAge), '%0.2f')];

filenamepre = [filenameINpre, '-', currentAgeStr];

bfID = strrep(filenamepre(1:4),'-','')

% Get line data, repeat 
phaseD = 800/(2*2*pi*1.346); %parameter to convert phase to difference via phase shift
dataOut = phaseProfiler2(Pimgs,Pimgs_pGrad,phaseD);

%%
phaseProfileTable = struct2table(phaseProfileSnap)

phaseProfileTable(:,'ButterflyID') = {bfID};
phaseProfileTable(:,'Age') = {hours(currentAge)/24};
phaseProfileTable(:,'phaseD') = {phaseD};
phaseProfileTable(:,'DataVolume') = {filepathin};

%% Save measurements
% save([filenamepre,'phaseProfilesEXAMPLE.mat'],'phaseProfileTable')