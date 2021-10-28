% Approach used to analyze longitudinal structures as used to make Fig5G.
% Example case included below
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Identify reoriented files

% Images were manually reoriented using the software Dragonfly by ORS
% Example case below
ROIdataPairs = [
".\Processed\ROI scaleG Slice (J-37_pos2-07_22_16_13_set_290-d6.06).dat"
".\Processed\scaleG Slice (J-37_pos2-07_22_16_13_set_290-d6.06).dat"
];

U = struct();

for n = 1:length(ROIdataPairs)/2
    U.roidat(n,1) = ROIdataPairs(2*n-1);
    U.datadat(n,1) = ROIdataPairs(2*n);
end

%% Use algorithm-assistant to pick dominant period from this data
for n=1:length(U.datadat)
char(U.datadat(n));
char(U.roidat(n));
[U.dominantS_um(n,1), U.peakNum(n,1), U.double(n,1), U.concern(n,1)] = pickFreqFromRawDat(char(U.datadat(n)), char(U.roidat(n)));
end

%% convert to table
T= struct2table(U); 