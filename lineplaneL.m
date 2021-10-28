function scaleL = lineplaneL(memPts,linePts)
%lineplaneL finds the length from one point, through another point, to a plane
%   Length is measured to linePts(1) at the tip
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

P0 = memPts(:,1);
P1 = memPts(:,2);
P2 = memPts(:,3);

L1 = linePts(:,1);
L2 = linePts(:,2);


P01 = P1 - P0;
P02 = P2 - P0;

L12 = L2-L1;

para = [-L12 P01 P02] \ [L1-P0];
a = P0 + P01*para(2) + P02*para(3);
b = L1 + L12*para(1);
L3 = L1 + L12*para(1);

dL = L3-L1; 
scaleL = sqrt(dL(1)^2 + dL(2)^2 + dL(3)^2);

end

