function [peak] = getPeakDataV2(Af_abs)
%getPeakData returns a table of all peaks in a 2D array
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 
 
centerPx = floor(size(Af_abs)/2) +1;

maxMask = imregionalmax(Af_abs);

peak=table();

[peak.Y peak.X peak.Val] = find(maxMask.*Af_abs);
peak = movevars(peak, 'X', 'Before', 'Y');
peak.XX = peak.X - centerPx(2);
peak.YY = peak.Y - centerPx(1);

peak = sortrows(peak,'Val','descend');
peak.rank = [1:size(peak,1)]';

end

