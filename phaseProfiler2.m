function [figs] = phaseProfiler2(Pimgs, refImgs, phaseD)
%phaseProfiler is a tool to examine a slice of phase data from a 3D volume of phase data
%   Workflow:
%   Call function; adjust slice of data on Figure 1 slider; grab and adjust end points of the trace line for profile.
%   Checking the output figures, tweak the tolerance and ceiling of periodicity, as well as the minimum threashold for peak height detection.
%   Data is sent to the main workspace by using the snap button
%   
%   Visible regions of the axes of some windows are constrained to 20um according to our normal workflow. This may be adjusted based on use case.
%   Note of caution: this function uses global variables. Future improvements should consider best practices for variable handling.
%
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 

%% Image parameters
% phaseD = 800/(2*2*pi*1.346); %parameter to convert phase to difference via phase shift, included as function variable
maxAmp = max(abs(Pimgs(:)));
imgsize = size(Pimgs(:,:,1));

pxSize = 0.0726*1024/size(Pimgs,1); % in um
xdata = [(1-0.5) (size(Pimgs,2)-0.5)]*pxSize;
ydata = [(1-0.5) (size(Pimgs,1)-0.5)]*pxSize;

%% setup figures, views
% stack information
sliceMin = 1;
sliceMax = size(Pimgs,3);
sliceCurr = 1;

% UI control
figs.UI = figure;

% % Phase figure
% figure
% figs.phase = imagesc(angle(Pimgs(:,:,sliceCurr)));
% figs.phase.Parent.Parent.Color = [1 1 1];
% axis image
% % set(gca,'color',bgColor)
% colormap(twilight)

% Amplitude figure
figure
figs.amp = imagesc(abs(Pimgs(:,:,sliceCurr)));
figs.amp.Parent.Parent.Color = [1 1 1];
axis image
% set(gca,'color',bgColor)
colormap(gray)
title('Amplitude component')

% MagDPimgs
figure
figs.refImgs = imagesc(refImgs(:,:,sliceCurr));
axis image
colormap(twilight)
title('Orientation of the phase gradient')

% Profile figures
figs.profile = figure;
figs.profile.Color = [1 1 1];

figs.profileUW = figure;
figs.profileUW.Color = [1 1 1];

figs.profileUWrot = figure;
figs.profileUWrot.Color = [1 1 1];  

figs.profileFourier = figure;   
figs.profileFourier.Color = [1 1 1];  


%% Layout figures
figs.UI.Units = 'normalized';
figs.UI.Position(1:2) = [0.01 0.5];
% figs.phase.Parent.Parent.Units = 'normalized';
% figs.phase.Parent.Parent.Position(1:2) = [0.7 0.5];
figs.amp.Parent.Parent.Units = 'normalized';
figs.amp.Parent.Parent.Position(1:2) = [0.7 0.5];
figs.refImgs.Parent.Parent.Units = 'normalized';
figs.refImgs.Parent.Parent.Position(1:2) = [0.35 0.5];
figs.profile.Units = 'normalized';
figs.profile.Position(1:2) = [0.01 0.02];
figs.profileUW.Units = 'normalized';
figs.profileUW.Position(1:2) = [0.35 0.02];
figs.profileUWrot.Units = 'normalized';
figs.profileUWrot.Position(1:2) = [0.01 0.02];

figs.profileFourier.Units = 'normalized';
figs.profileFourier.Position(1:2) = [0.7 0.02];

%% line of interest
cornerX1 = figs.amp.XData(1);
cornerX2 = figs.amp.XData(2);
cornerY1 = figs.amp.YData(1);
cornerY2 = figs.amp.YData(2);
myLine = drawline(figs.refImgs.Parent,'Position',[cornerX1 cornerY1; cornerX2 cornerY2]);
addlistener(myLine,'ROIMoved',@myLineMoved);
myLineStart = drawcircle(figs.refImgs.Parent, 'Center', myLine.Position(1,:),...
    'Radius',10,...
    'Color', [1 0 0],...
    'InteractionsAllowed','none',...
    'FaceSelectable',false);
mirrorLine = drawline(figs.amp.Parent,'Position',myLine.Position);
addlistener(mirrorLine,'ROIMoved',@myMirrorLineMoved);

%% Intialize tolerance parameters for profile analysis
minFreqRatioAllow = .7;
minPeak = 0.01;
maxPeriod = 4;

%% Initialize output of this function
meas = struct;

figSnap = struct;
figSnapMat = uint8.empty;
% meas(1).points = struct('points',{},'profile',{});

c = double.empty;

%% UI controls
sliceSlider = uicontrol('Parent',figs.UI,'Style','slider',...
    'Position',[50,60,30,150],...
    'value',sliceCurr,'min',sliceMin,'max',sliceMax,...
    'SliderStep',[1/sliceMax 10/sliceMax],...
    'Callback',{@sliceCallback,figs});
sliceEdit = uicontrol('Parent',figs.UI,...
    'Style','edit',...
    'Position',[50,30,50,20],...
    'string',num2str(sliceSlider.Value),...
    'Callback',{@sliceEditCallback,figs});
sliceLabel = uicontrol('Parent',figs.UI,'Style','text',...
    'Position',[50,60+150,30,20],...
    'String','slice');
buttonNewROI = uicontrol('Parent',figs.UI,...
    'Style','pushbutton',...
    'Position',[300,300,150,30],...
    'string','make new profile',...
    'fontsize', 9,...
    'Callback',{@buttonNewLineCallback,figs});
buttonSnap = uicontrol('Parent',figs.UI,...
    'Style','pushbutton',...
    'Position',[300,360,150,30],...
    'string','SNAP',...
    'fontsize', 9,...
    'Callback',{@buttonSnapCallback,figs});

maxPeriodEdit = uicontrol('Parent',figs.UI,...
    'Style','edit',...
    'Position',[300,30,50,20],...
    'string',maxPeriod,...
    'Callback',{@maxPeriodEditCallback,figs});
maxPeriodLabel = uicontrol('Parent',figs.UI,'Style','text',...
    'Position',[195,30,100,20],...
    'String','Period ceiling');
minPeakEdit = uicontrol('Parent',figs.UI,...
    'Style','edit',...
    'Position',[300,60,50,20],...
    'string', minPeak,...
    'Callback',{@minPeakEditCallback,figs});
minPeakLabel = uicontrol('Parent',figs.UI,'Style','text',...
    'Position',[195,60,100,20],...
    'String','min peak height');
minFreqRatioEdit = uicontrol('Parent',figs.UI,...
    'Style','edit',...
    'Position',[300,90,50,20],...
    'string',minFreqRatioAllow,...
    'Callback',{@minFreqRatioCallback,figs});
minFreqRatioLabel = uicontrol('Parent',figs.UI,'Style','text',...
    'Position',[195,90,100,20],...
    'String','min ratio (tolerance)');

loadPtsEdit = uicontrol('Parent',figs.UI,...
    'Style','edit',...
    'Position',[300,150,200,20]);
buttonLoad = uicontrol('Parent',figs.UI,...
    'Style','pushbutton',...
    'Position',[195,150,100,20],...
    'string','load profile',...
    'fontsize', 9,...
    'Callback',{@buttonLoadCallback,figs});

snapCommentEdit = uicontrol('Parent',figs.UI,...
    'Style','edit',...
    'Position',[90,365,200,20]);


%% UI callbacks
    function sliceCallback(thisSlider, ~, handles)
        %second argument in this function is EventData
        sliceCurr = round(thisSlider.Value);
        updateAll();
    end
    function sliceEditCallback(thisSlider, ~, handles)
        sliceCurr = str2double(sliceEdit.String);
        if sliceCurr > sliceMax
            sliceCurr = sliceMax;
        elseif sliceCurr < sliceMin
            sliceCurr = sliceMin;
        end
        updateAll();
    end
    function myLineMoved(~,~,~)
        %Uncomment the following three lines to force a particular line of
        %interest
        % temppoints = ...
        % [784.806921748568,447.003827709986;826.388679891842,418.416368986485];
        % myLine.Position = temppoints;
        
        lp = myLine.Position;
        
        theta = atan((lp(2,2)-lp(1,2))/(lp(2,1)-lp(1,1)));
        
        mirrorLine.Position = myLine.Position;
        updateProfile();
    end
    function myMirrorLineMoved(~,~,~)
        myLine.Position = mirrorLine.Position;
        myLineMoved
    end
    function buttonNewLineCallback(thisSlider, ~, handles)
        delete(myLine)
        myLine = drawpolygon(figs.refImgs.Parent,'FaceAlpha',0);
        addlistener(myLine,'ROIMoved',@myLineMoved);
        
        mirrorLine.Position = myLine.Position;
        updateAll();
    end
    function buttonSnapCallback(thisButton,~,handles)
        snapCurrent;
    end

    function maxPeriodEditCallback(thisBox, ~, handles)
            maxPeriod = str2double(maxPeriodEdit.String);
            updateAll();
    end
    function minPeakEditCallback(thisBox, ~, handles)
            minPeak = str2double(minPeakEdit.String);
            updateAll();
    end
    function minFreqRatioCallback(thisBox, ~, handles)
            minFreqRatioAllow = str2double(minFreqRatioEdit.String);
            updateAll();
    end
    function buttonLoadCallback(thisButton,~,handles)
        expFilt = '[\[\],;\{\}]';

        entries = regexp(loadPtsEdit.String,expFilt,'split');
        entrynums = str2mat(entries);
        entrynums = str2num(entrynums);
        entrynums = reshape(entrynums,[2,2]);
        entrynums = entrynums';
        myLine.Position = entrynums;
        mirrorLine.Position = myLine.Position;
        updateProfile();
    end

%% update callbacks
    function updateAll()
        updateUI();
        
        updateFigs()
        
        updateProfile()
        
    end
    function updateFigs()
%         figs.phase.CData = angle(Pimgs(:,:,sliceCurr));
        
        figs.amp.CData = abs(Pimgs(:,:,sliceCurr));
        figs.refImgs.CData = refImgs(:,:,sliceCurr);
    end
    function updateUI()
        sliceSlider.Value = sliceCurr;
        sliceEdit.String = num2str(sliceCurr);
    end
%% Processing of selected profile (callback)
    function updateProfile()
        lp = myLine.Position;
        myLineStart.Center = myLine.Position(1,:);

        %the first point clicked is the first point in the data
        [cx,cy,c] = improfile(angle(Pimgs(:,:,sliceCurr)),lp(:,1),lp(:,2));
        
        %Unwrap phase data (and flip phase to relate to distance)
        cUnwrap = unwrap(-c);
        cUWum = cUnwrap*phaseD/1000;
        %get line length, convert to um
        cl = sqrt((cx-cx(1)).^2 + (cy-cy(1)).^2);
        clUm = cl*pxSize;
        %Rotate profile to that scale surface lies flat
        [clUmRot, cUWumRot] = rotProfile(clUm, cUWum);
        %The following is more concise than above but does not expose certain aspects of profile for GUI
        %Unwrap and rotate phase data.
%         [clUmRot, cUWumRot] = unwrapRotate(cx,cy,c);        
        
        %Determine the dominant period
        [frqs1,pks1,fsampleP,fs, df] = getProfileFreq(cUWumRot,clUmRot,maxPeriod);
        period = 1/frqs1;
        %Determine peak heights corresponding to this period (within specified tolerances)
        minspacing = period*fs*minFreqRatioAllow; 
        [peakInd,troughInd] = peakMinFinder(cUWumRot,minspacing,minPeak);
        [meanHeights,stdHeights,nHeights] = getHeights(clUmRot,cUWumRot,peakInd,troughInd);
        %The following is more concise than above but does not expose certain aspects of profile for GUI
        %Determine the dominant period and peak heights corresponding to this period (within specified tolerances)
%         [meanHeights,stdHeights,nHeights,period] = profileMeasure(cUWumRot,clUmRot,maxPeriod,minFreqRatioAllow,minPeak)
        
        %UPDATE ALL FIGURES
        figure(figs.profileFourier)   
        plot(df,abs(fsampleP))
        title(['Fourier transform of profile. f = ', num2str(frqs1), ' , w = ', num2str(period)])
        hold on
        scatter(frqs1,pks1)
        hold off

        
                figure(figs.profile)
        plot(clUmRot,cUWumRot)
        xlabel('µm')
        ylabel('µm')
        h1 = figs.profile.CurrentAxes;
        h1.YLim  = h1.YLim + (h1.YLim(2)-h1.YLim(1))*[-.3, .3];
        
        figure(figs.profileUW)
        yyaxis left
        plot(clUm,cUnwrap)
        xlabel('in plane (µm)')
        ylabel('phase depth (rad)')
        title('Unwrapped, not-rotated phase (blue) compared to amplitude (orange)')
        h2 = figs.profileUW.CurrentAxes;
%         h2.YLim = [-0.35, 0.35];
        h2.XLim = [0, 20.5];
        
        yyaxis right
        cAmp = improfile(figs.amp.CData,lp(:,1),lp(:,2));
        cAmp = cAmp./maxAmp;
        plot(clUm,cAmp)
        ylabel('Amplitude (fraction of vol. max)')
        legend('phase', 'amplitude')
        
        
        figure(figs.profileUWrot)
        plot(clUmRot,cUWumRot)
        xlabel('µm lateral')
        ylabel('µm vertical')
        title(['Rotated, unwrapped profile, meanH = ',num2str(meanHeights)])
        h2 = figs.profileUWrot.CurrentAxes;
        h2.YLim = [-0.05, 0.95];
        h2.XLim = [0, 20.5];
        
        hold on;
        scatter(clUmRot(peakInd),cUWumRot(peakInd));
        scatter(clUmRot(troughInd),cUWumRot(troughInd));
        hold off;


    end

%% Send data to workspace on UI demand (callback)
    function snapCurrent()

        j = size(meas,2) +1
        if ~isfield(meas,'endpoints')
            j = 1;
        end
        
        %Log positional information
        meas(j).slice = sliceCurr;
        meas(j).endpoints = myLine.Position;
        meas(j).comment = snapCommentEdit.String;
        
        %Regrab profile info from phase and amplitude
        lp = myLine.Position;
        [thiscx,thiscy,thisc] = improfile(angle(Pimgs(:,:,sliceCurr)),lp(:,1),lp(:,2));
        [~,~,thisAmp] = improfile(abs(Pimgs(:,:,sliceCurr)),lp(:,1),lp(:,2));

        %Log profile info 
        meas(j).cx = thiscx;
        meas(j).cy = thiscy;
        meas(j).phaseProfile = thisc;
        meas(j).ampProfile = thisAmp;
        meas(j).imsize = imgsize;
                
        %Regrab profile info from phase and amplitude
        [meas(j).clUmRot, meas(j).cUWumRot] = unwrapRotate(thiscx,thiscy,thisc);        
        [meas(j).meanHeights,meas(j).stdHeights,meas(j).nHeights,meas(j).period] = profileMeasure(meas(j).cUWumRot,meas(j).clUmRot,maxPeriod,minFreqRatioAllow,minPeak);
        
        %Log tolerance parameters for profile analysis
        meas(j).maxPeriod = maxPeriod;
        meas(j).minFreqRatioAllow = minFreqRatioAllow;
        meas(j).minPeak = minPeak;
        
        %send to base workspace in matlab
        assignin('base','phaseProfileSnap',meas)
    end

%% Supporting functions
    function [clRot, cUWumRot] = unwrapRotate(cx,cy,thisc)
        %Unwrap phase data (and flip phase to relate to distance)
        cUnwrap = unwrap(-thisc);
        
        %convert to um
        cUWum = cUnwrap*phaseD/1000;
        
        %get line length, convert to um
        cl = sqrt((cx-cx(1)).^2 + (cy-cy(1)).^2);
        clUm = cl*pxSize;
        
        %Rotate profile to that scale surface lies flat
        [clRot, cUWumRot] = rotProfile(clUm, cUWum);
    end
end