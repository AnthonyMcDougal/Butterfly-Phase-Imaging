function [out, varargout]=ima2full(IMG, varargin)

sz=size(IMG);
cr=1;


if length(varargin)>0
    ref=varargin{1};
else
    tmp=IMG-circshift(IMG, [2,2,0]);
    conttmp=squeeze(mean(mean(tmp, 1), 2));
    [~, ind]=max(conttmp);
    ref=data.IMG(:,:, ind);
end

[Pref, mi, mj, cmask]=HT2D(ref, 'p');

IMGk=fftshift(fftshift(fft(fft(double(IMG), [], 1), [], 2), 1), 2);
IMGk=circshift(IMGk, [-mi -mj, 0]);
IMGk=IMGk.*repmat(cmask, [1 1 sz(3)]);

oszy=round(sz(1)*cr);
oszx=round(sz(2)*cr);

% % hh=(1:oszy)+round(sz(1)/4);
% % ww=(1:oszx)+round(sz(2)/4);
% 
hh=(-round(oszy/2):round(oszy/2)-1)+round(sz(1)/2)+1;
ww=(-round(oszx/2):round(oszx/2)-1)+round(sz(2)/2)+1;
% 

IMGk=IMGk(hh, ww, :);

out=ifft(ifft(ifftshift(ifftshift(IMGk, 1), 2), [], 1), [], 2)*cr^2;

if nargout>1
    par.ref=Pref;
    par.inten=squeeze(mean(mean(abs(out).^2, 1), 2));
    par.mi=mi;
    par.mj=mj;
    par.cmask=cmask;
    varargout{1}=par;
end
end