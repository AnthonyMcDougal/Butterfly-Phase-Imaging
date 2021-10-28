function [rawData, xyzPxSize] = getImageFromRaw(filepath)
%getImageFromRaw uses a .dat file to import an image (or volume)
%   Each .dat file must correspond to a .raw file in the same firectory 
%   (using the ORS Dragonfly standard).
%   NOTE that matlab flips x and y, so from this functions xyzPxSize(1) is
%   the "Y" vertical resolution in Matlab.
%   Anthony McDougal, Sungsam Kang, Zahid Yaqoob, Peter So, and Mathias Kolle, 2021 


datText = importdata(filepath);

for j = 1:length(datText)
    if contains(datText{j}, 'Spacing')
        formatSpec = '	<Spacing X="%f" Y="%f" Z="%f" />';
        xyzPxSize = sscanf(datText{j},formatSpec);
    elseif contains(datText{j}, 'Resolution')
        formatSpec = '	<Resolution X="%u" Y="%u" Z="%u" T="%u" />';
        xyztImSize = sscanf(datText{j},formatSpec);
    elseif contains(datText{j}, 'Format')
        formatSpec = '	<Format>%s</Format>';
        rawFormat = sscanf(datText{j},formatSpec);

        %hack to remove the end of the line, not sure why it is getting picked up, special char?
        rawFormat = rawFormat(1:end-9);
    end
end

precision = char();
if rawFormat=='UCHAR'
precision  = 'uint8';
elseif rawFormat == 'FLOAT'
    precision = 'float';
end

filepathRaw = [filepath(1:end-3),'raw'];
fid = fopen(filepathRaw,'r');
rawData = fread(fid, [xyztImSize(1),xyztImSize(2)], precision);
fclose(fid);

end

