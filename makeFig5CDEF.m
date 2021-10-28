%makeFig5CDEF script to sort, extrapolate, and plot measurements of butterfly
%scales dimensions shown in Fig. 5 C-F
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Read in scale measurements
%make matlab table from data
T = readtable('.\Measured\A40ScaleMeasurements.xlsx','Range','A1:G88');
FullAge = 11.84766782; %Full development age for this generation

%% Organize and unstack table

%Convert data types for table entries
T.ButterflyID = categorical(T.ButterflyID);
T.Type = categorical(T.Type);
T.Measurement = categorical(T.Measurement);
T.Value = cellfun(@str2num,T.Value,'UniformOutput',false); %Must convert to matrix (not cell) later

%List fraction of development
T.Dev = T.Age ./ FullAge;

%unstack (restructure) table
U = unstack(T,'Value','Measurement'); % if there are duplicates they will @sum

%% Extrapolate length from membrane surface and points laying along scale

%Group data by age
[G, idAge] = findgroups(U.Age);

%Loop over all ages 
for k = 1:length(idAge)
    
    %create temporary table for this age only 
    subU = U(U.Age == idAge(k),:);
    
    %identify membrane for this age
    mRow = find(ismember(subU.Type,'Membrane'));
    membranePoints = [subU.MembranePt1(mRow); subU.MembranePt2(mRow); subU.MembranePt3(mRow)];
    membranePoints = cell2mat(membranePoints);
    membranePoints = membranePoints';
    
    %loop over all scales for this age
    for m = [find(U.Age == idAge(k))]'
        if U.Type(m) == 'Membrane'
        else
            %get points marking a line from tip of scale to position further back on the scale
            linePoints = [U.Point1(m); U.Point2(m)];
            linePoints = cell2mat(linePoints);
            linePoints = linePoints';
            
            %extrapolate length from points and membrane
            U.Length(m) = lineplaneL(membranePoints,linePoints);
        end
    end 
    
end

%Remove membrane measurements, leave only scale measurements
U = U(~(ismember(U.Type,'Membrane')),:);

%% Estimate surface area and length of each scale
U.Width = cell2mat(U.Width);
U.Thickness = cell2mat(U.Thickness);
U.SA = 2.* (U.Length.*U.Width + U.Length.*U.Thickness + U.Width.*U.Thickness);
U.Vol = U.Length.*U.Width.*U.Thickness;

%% Find mean per time point
%group by age
[G, idAge, idType] = findgroups(U.Age, U.Type);

%calculate means
myMeanNan = @(x)(mean(x,'omitnan'));
LengthMean = splitapply(myMeanNan,U.Length,G);
ThicknessMean = splitapply(myMeanNan,U.Thickness,G);
WidthMean = splitapply(myMeanNan,U.Width,G);
VolMean = splitapply(myMeanNan,U.Vol,G);
SAMean = splitapply(myMeanNan,U.SA,G);

%Age as percentages
AgeP = U.Age*100/FullAge;
groupAgeP = idAge*100/FullAge;
%% Plot and format
mult = 1;
axisWidth = 0.4*mult;
axisHeight = 0.15*mult;
ypad = 1.15;
xlower = 28;
xupper = 55;

figure

lengthAx = subplot(4,1,1);
hold on
lengthScat = scatter(AgeP , U.Length);
lengthMean = plot(groupAgeP, LengthMean);
ylabel(['Length (', char(0181),'m)'])
lengthAx.YLim = [0, lengthAx.YLim(2)*ypad];
lengthAx.XLim = [xlower, xupper];
lengthAx.Units = 'normalized';
lengthAx.Position(3:4) = [axisWidth, axisHeight];

widthAx = subplot(4,1,2);
hold on
widthScat = scatter(AgeP , U.Width);
widthMean = plot(groupAgeP, WidthMean);
ylabel(['Width (', char(0181),'m)'])
widthAx.YLim = [0, widthAx.YLim(2)*ypad];
widthAx.XLim = [xlower, xupper];
widthAx.Units = 'normalized';
widthAx.Position(3:4) = [axisWidth, axisHeight];

thickAx = subplot(4,1,3);
hold on
thickScat = scatter(AgeP , U.Thickness);
thickMean = plot(groupAgeP, ThicknessMean);
ylabel(['Thickness (', char(0181),'m)'])
thickAx.YLim = [0, thickAx.YLim(2)*ypad];
thickAx.XLim = [xlower, xupper];
thickAx.Units = 'normalized';
thickAx.Position(3:4) = [axisWidth, axisHeight];

volSaAx = subplot(4,1,4);
hold on
volMean = plot(groupAgeP, VolMean*100/max(VolMean));
saMean = plot(groupAgeP, SAMean*100/max(SAMean));
volScat = scatter(AgeP , U.Vol*100/max(VolMean));
saScat = scatter(AgeP , U.SA*100/max(SAMean));
ylabel(['Scale volume and' newline 'surface area (% of maximum)'])
volSaAx.YLim = [0, 140];
volSaAx.XLim = [xlower, xupper];
volSaAx.Units = 'normalized';
volSaAx.Position(3:4) = [axisWidth, axisHeight];
legend('Est. Volume','Est. Surface Area','Location','southeast')

MsizeLine = 5;
MsizeSca = pi*(MsizeLine/2)^2;
Lsize = 0.75;

set(findobj(gcf,'type','Line'), 'Linestyle', ':', 'Linewidth', Lsize, 'Color', [0, 0, 0])
set(findobj(gcf,'type','Scatter'),'Marker','x','SizeData', MsizeSca, 'MarkerEdgeColor', [0,0,0]);
set(findobj(gcf,'type','axes'),'Linewidth', .5, 'XColor', [0, 0, 0],'YColor', [0, 0, 0], 'Box', 'on')
set(volScat,'Marker','x','SizeData', MsizeSca, 'MarkerEdgeColor', [.9,.4,.4]);
set(volMean,'Color', [.9,.4,.4]);

xlabel('Time (% of pupal development)')

bestYLabelPos = min([lengthAx.YLabel.Position(1), widthAx.YLabel.Position(1), thickAx.YLabel.Position(1)]);
lengthAx.YLabel.Position(1) = bestYLabelPos;
widthAx.YLabel.Position(1) = bestYLabelPos;
thickAx.YLabel.Position(1) = bestYLabelPos;

f1 = gcf;

f1.Units = 'normalized';
f1.Position = [0.1 0.1 .3 .6];
