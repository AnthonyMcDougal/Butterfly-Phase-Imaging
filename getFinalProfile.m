function [clRot,zRot] = getFinalProfile(phaseSliceIn,linePos)
%getFinalProfile extracts a profile from phase data
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

pxSize = 0.0726*1024/size(phaseSliceIn,1); % in um
phaseD = 800/(2*2*pi*1.346); % in nm

[x,y,cPhase] = improfile(phaseSliceIn,linePos(:,1),linePos(:,2));

uwPhase = unwrap(-cPhase);
z = uwPhase*phaseD/1000;
clPX = sqrt((x-x(1)).^2 + (y-y(1)).^2);
cl = clPX*pxSize; % in um
[clRot, zRot] = rotProfile(cl, z); % both in um

end

