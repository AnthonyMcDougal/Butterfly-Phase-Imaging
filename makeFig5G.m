%makeFig5G plots measurements of actin/ridge spacing shown in Fig. 5 G
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

% Load measured spatial periods
load('Measured/J37-Group1-Spacing.mat')
load('Measured/J37-Group2-Spacing.mat')
load('Measured/J37-Group3-Spacing.mat')
AgeFull = 9.885946043 ; 

%Prepare figure
figure
ax1 = gca;
hold on
box on
ylabel(['actin/ridge spacing (', char(0181),'m)'])
xlabel('Time (% of pupal development)')

%Prepare figure colors
c = [0 1 1];
kVal = [0.50, 0.40, 0.70, 0.30, 0.80, 0.20, 0.60];
newColorOrder = repmat(c,7,1).*repmat(kVal',1,3);
colororder(newColorOrder)

%% Prepare Group 1

%Calculate percentage of age
Group1SpacingTable.PercentAge = 100*Group1SpacingTable.Age/AgeFull;

%Add jitter:
%Scale 81a and 81c have a spacing dominantS_um nearly identical:
%{1.06264371280397} {1.06271631156618}
jitterG1PercentAge = Group1SpacingTable.PercentAge;
jitterG1PercentAge(1) = jitterG1PercentAge(1)+.1;
jitterG1PercentAge(3) = jitterG1PercentAge(3)-.1;

%Plot group 1
scatterGroup1 = scatter(jitterG1PercentAge, Group1SpacingTable.dominantS_um);

%% Prepare Group 2

%Calculate percentage of age
Group2SpacingTable.PercentAge = 100*Group2SpacingTable.Age/AgeFull;

%Organize table
G2AgeCount = 3;
G2ScaleCount = 4;
Group2PercentAge = reshape(Group2SpacingTable.PercentAge, [G2AgeCount, G2ScaleCount]);
Group2Spacing = reshape(Group2SpacingTable.dominantS_um, [G2AgeCount, G2ScaleCount]);

%Plot group 2
plotGroup2 = plot(Group2PercentAge, Group2Spacing);

%% Prepare Group 3

%Calculate percentage of age
Group3SpacingTable.PercentAge = 100*Group3SpacingTable.Age/AgeFull;

%Organize table
G3AgeCount = 3;
G3ScaleCount = 3;
Group3PercentAge = reshape(Group3SpacingTable.PercentAge, [G3AgeCount, G3ScaleCount]);
Group3Spacing = reshape(Group3SpacingTable.dominantS_um, [G3AgeCount, G3ScaleCount]);

%Plot group 3
plotGroup3 = plot(Group3PercentAge, Group3Spacing);

%% Format figure

ypad = 1.15;
xlower = 28;
xupper = 95;
ax1.XLim = [xlower, xupper];
xticks([30 40 50 60 70 80 90])
labels = string(ax1.XAxis.TickLabels); 
labels(2:2:end) = nan; 
ax1.XAxis.TickLabels = labels; 
ax1.YLim = [0.9, 2.1];
ytickformat('%.1f')

set(scatterGroup1,'Marker','x', 'MarkerEdgeColor', [0,0,0]);
set(plotGroup2,'Marker','x', 'Linestyle', '-');
set(plotGroup3,'Marker','x', 'Linestyle', '-');
