%makeFig5H plots mean heights and dominant periods of measured surface profiles, as shown in Fig. 5 H
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Load measured data. For measuring strategy, please see:
summary.measList = [...
"Measured\A-40-01_10_10_52_set_97-d4.12phaseProfiles.mat"
"Measured\A-40-01_10_12_52_set_99-d4.21phaseProfiles.mat"
"Measured\A-40-01_10_17_34_set_104-d4.40phaseProfiles.mat"
"Measured\A-40-01_10_22_34_set_109-d4.61phaseProfiles.mat"
"Measured\A-40-01_10_23_34_set_110-d4.65phaseProfiles.mat"
"Measured\A-40-01_11_00_34_set_111-d4.70phaseProfiles.mat"
"Measured\A-40-01_11_01_34_set_112-d4.74phaseProfiles.mat"
"Measured\A-40-01_11_02_34_set_113-d4.78phaseProfiles.mat"
"Measured\A-40-01_11_03_34_set_114-d4.82phaseProfiles.mat"
"Measured\A-40-01_11_04_34_set_115-d4.86phaseProfiles.mat"
];

%%

%Loop over all ages
for fileID = 1:length(summary.measList)
    
    load(summary.measList(fileID))
    
    %make uniform names across files
    if any(strcmp(phaseProfileTable.Properties.VariableNames, 'w'))
        phaseProfileTable.Properties.VariableNames{'w'} = 'period';
    end
    if any(strcmp(phaseProfileTable.Properties.VariableNames, 'meanH'))
        phaseProfileTable.Properties.VariableNames{'meanH'} = 'meanHeights';
    end
    if any(strcmp(phaseProfileTable.Properties.VariableNames, 'stdH'))
        phaseProfileTable.Properties.VariableNames{'stdH'} = 'stdHeights'
    end
    if any(strcmp(phaseProfileTable.Properties.VariableNames, 'nH'))
        phaseProfileTable.Properties.VariableNames{'nH'} = 'nHeights'
    end
    
    %Calculate mean and standard deviation of dominant peak spacing for this age
    summary.periodList(fileID) =  mean(phaseProfileTable.period);
    summary.periodSTDList(fileID) =  std(phaseProfileTable.period);
    
    %Calculate the pooled mean and pooled standard deviation of peak heights for this age
    [summary.meanHList(fileID),summary.meanHvarList(fileID)] = pooledMeanVar(phaseProfileTable.nHeights, phaseProfileTable.meanHeights, phaseProfileTable.stdHeights.^2);
    summary.meanHSTDList(fileID) = sqrt(summary.meanHvarList(fileID));
    
    %Record age
    summary.age(fileID) = phaseProfileTable.Age(1);
    
end

%List percent development
AgeFull = 11.848;
summary.groupAgeP = summary.age*100/AgeFull;


%% Plot figures
% Figure sizing parameters
Lsize = 0.75;
fsize = 5;
axisWidth = 4.2;
axisHeight = 3.15;

%Plot peak height over time
figure
ax1 = gca;
errorbar(summary.groupAgeP,1000*summary.meanHList,1000*summary.meanHSTDList)
ylabel(['Ridge height (nm)'])
xlabel('Time (% of pupal development)')
ax1.YLim = [0, ax1.YLim(2)*1.1];
set(findobj(gcf,'type','ErrorBar'), 'Linestyle', 'none', 'Linewidth', Lsize, 'Color', [0, 0, 0])
set(findobj(gcf,'type','axes'),'Linewidth', .5,'Box', 'on', 'XColor', [0, 0, 0],'YColor', [0, 0, 0], 'FontSize', fsize)
ax1.Units = 'centimeters';
ax1.Position(3:4) = [axisWidth, axisHeight];

%Plot peak spacing over time
figure
ax2 = gca;
errorbar(summary.groupAgeP,summary.periodList,summary.periodSTDList)
ylabel(['Ridge spacing (', char(0181),'m)'])
ax2.YLim = [0, ax2.YLim(2)*1.1];
xlabel('Time (% of pupal development)')
set(findobj(gcf,'type','ErrorBar'), 'Linestyle', 'none', 'Linewidth', Lsize, 'Color', [0, 0.68, 0.68])
set(findobj(gcf,'type','axes'),'Linewidth', .5,'Box', 'on', 'XColor', [0, 0, 0],'YColor', [0, 0, 0], 'FontSize', fsize)
ax2.Units = 'centimeters';
axisWidth2 = 4.2;
axisHeight2 = 0.9;
ax2.Position(3:4) = [axisWidth2, axisHeight2];
xlower = 34;
xupper = 42;
ax2.XLim = [xlower, xupper];

%align axes and labels
ax1.XLim = ax2.XLim;
ax1.XTick = ax2.XTick;
ax2.YLabel.Position(1) = ax1.YLabel.Position(1);
