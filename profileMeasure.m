function [meanHeights,stdHeights,nHeights,w] = profileMeasure(aProfile,clUmRot,maxPeriod,minFreqRatioAllow,minPeak)
%profileMeasure gets stats about the profile measurement
%   maxPeriod should be adjusted to filter out low frequency features
%
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% identify dominant frequency (according to thresholds)
[frqs1,pks1,fsampleP,fs, df] = getProfileFreq(aProfile,clUmRot,maxPeriod);
w = 1/frqs1;

%% measure peaks

%Identify peaks (according to thresholds)
%The expected spacing is the calculated period, 
%with some tolerance for variability in spacing (e.g. 0.5 but adjustable), which is recorded in each data set
%and some minimum height requirement for a "peak"
minspacing = w*fs*minFreqRatioAllow; 
[peakInd,troughInd] = peakMinFinder(aProfile,minspacing,minPeak);

% Calculate peak height mean and standard deviation
[meanHeights,stdHeights,nHeights] = getHeights(clUmRot,aProfile,peakInd,troughInd);


end

