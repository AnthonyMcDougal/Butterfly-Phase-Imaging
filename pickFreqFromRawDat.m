function [spacing, selectedPeak, doDouble, concern] = pickFreqFromRawDat(dataFilepath,maskFilepath)
%pickFreqFromRawDat assistant to finding dominant spacing in a masked image  
%   input variables dataFilepath and maskFilepath should each be the .dat files that
%   correspond to a .raw file in the same firectory (using the ORS
%   Dragonfly standard).
%
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 


%get image matrices and resolution data from .dat and .raw
[rawDataIn, yxzPxSize] = getImageFromRaw(dataFilepath); %NOTE that matlab flips x and y, so yxzPxSize(1) is the y resolution 
[binMaskIn, ~] = getImageFromRaw(maskFilepath);
%mask the image
mData = rawDataIn.*binMaskIn;

%make fourier transform
fmData = fftshift(fft2(mData));

%dimensional features
[Nyx, centerPx, X, Y] = fourierMap(fmData);

%make filters for Fourier space
%mask1 filters leaves only one of the symmetric sides
fmask1 = Y <= centerPx(1);
fmask1(centerPx(1), 1:(centerPx(2)-1)) = 0;

%mask 2 is a high pass filter
maxFeat = size(fmData)/16;
fThresh = 1./maxFeat;
fmask2 = highPassMask(fmData,fThresh);
fmaskAll = fmask1.*fmask2;

%get list of peaks
fPeaks = getPeakDataV2(abs(fmData).*fmaskAll);

%get the sampling and resolution
fs_um = 1 ./ ([yxzPxSize(1), yxzPxSize(2)]/1e-6); %micron frequency
df_um = fs_um./Nyx;
%determine peak position
fPeaks.RR_um = sqrt(  (fPeaks.XX.*df_um(2)).^2 + (fPeaks.YY.*df_um(1)).^2);

%manually select the relevant peak and confirm that the peak matches the desired feature spacing
activePeakInspector = fourierPeakInspector(mData,yxzPxSize,log10(abs(fmData)),fPeaks);

%record the selected periodicity and other selection notes
waitfor(activePeakInspector,'freeToEnd', true)
selectedPeak = activePeakInspector.peakNow;
doDouble = activePeakInspector.DoubleCheckBox.Value;
concern = activePeakInspector.ConcernsCheckBox.Value;
delete(activePeakInspector)
spacing = 1/fPeaks.RR_um(selectedPeak);

end