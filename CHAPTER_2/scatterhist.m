function h = scatterhist(x,y,varargin)
%SCATTERHIST 2D scatter plot with marginal histograms.
%   SCATTERHIST(X,Y) creates a 2D scatterplot of the data in the vectors X
%   and Y, and puts a univariate histogram on the horizontal and vertical
%   axes of the plot.  X and Y must be the same length.
%
%   SCATTERHIST(...,'PARAM1',VAL1,'PARAM2',VAL2,...) specifies additional
%   parameters and their values to control how the plot is made.  Valid
%   parameters are the following:
%
%       Parameter    Value
%        'NBins'     A scalar or a two-element vector specifying the number of
%                    bins for the X and Y histograms.  The default is to compute
%                    the number of bins using Scott's rule based on the sample
%                    standard deviation.
%
%        'Location'  A string controlling the location of the marginal
%                    histograms within the figure.  'SouthWest' (the default)
%                    plots the histograms below and to the left of the
%                    scatterplot, 'SouthEast' plots them below and to the
%                    right, 'NorthEast' above and to the right, and 'NorthWest'
%                    above and to the left.
%
%        'Direction' A string controlling the direction of the marginal
%                    histograms in the figure.  'in' (the default) plots the
%                    histograms with bars directed in towards the scatterplot,
%                    'out' plots the histograms with bars directed out away
%                    from the scatterplot.
%
%   Any NaN values in either X or Y are treated as missing data, and are
%   removed from both X and Y.  Therefore the plots reflect points for
%   which neither X nor Y has a missing value.
%
%   Use the data cursor to read precise values and observation numbers 
%   from the plot.
%
%   H = SCATTERHIST(...) returns a vector of three axes handles for the
%   scatterplot, the histogram along the horizontal axis, and the histogram
%   along the vertical axis, respectively.
%
%   Example:
%      Independent normal and lognormal random samples
%         x = randn(1000,1);
%         y = exp(.5*randn(1000,1));
%         scatterhist(x,y)
%      Marginal uniform samples that are not independent
%         u = copularnd('Gaussian',.8,1000);
%         scatterhist(u(:,1),u(:,2))
%      Mixed discrete and continuous data
%         load('carsmall');
%         scatterhist(Weight,Cylinders,'NBins',[10 3])

%   SCATTERHIST(X,Y,NBINS) is supported for backwards compatibility.

%   Copyright 2006-2011 The MathWorks, Inc.
%   $Revision: 1.1.6.8 $  $Date: 2011/10/15 02:06:59 $

narginchk(2, Inf);

if ~isvector(x) || ~isnumeric(x) || ~isvector(y) || ~isnumeric(y)
    error(message('stats:scatterhist:BadXY'));
end
if numel(x)~=numel(y)
    error(message('stats:scatterhist:BadXY'));
end
x = x(:);
y = y(:);
obsinds = 1:numel(x);
t = isnan(x) | isnan(y);
if any(t)
    x(t) = [];
    y(t) = [];
    obsinds(t) = [];
end

location = 'sw'; % default value
direction = 'in'; % default value
if nargin < 3 || isempty(varargin{1}) % scatterhist(x,y)
    % By default use the bins given by Scott's rule
    [xctrs,yctrs] = defaultBins(x,y);
else
    if nargin == 3 && ~ischar(varargin{1}) % scatterhist(x,y,nbins)
        nbins = varargin{1};
    else % scatterhist(x,y,'name','value',...)
        pnames = {'nbins'   'location'  'direction'};
        dflts =  {    []     location    direction };
        [nbins,location,direction] ...
                           = internal.stats.parseArgs(pnames, dflts, varargin{:});
    end

    if isempty(nbins)
        % By default use the bins given by Scott's rule
        [xctrs,yctrs] = defaultBins(x,y);
    elseif ~isnumeric(nbins) || ~(isscalar(nbins) || numel(nbins)==2) || ...
           any(nbins<=0) || any(nbins~=round(nbins))
        error(message('stats:scatterhist:BadBins'));
    elseif isscalar(nbins)
        xctrs = nbins;  % specified number of bins, same for x and y
        yctrs = nbins;
    else
        xctrs = nbins(1); % specified number of bins, x and y different
        yctrs = nbins(2);
    end
end

% Create the histogram information
[nx,cx] = hist(x,xctrs);
if length(cx)>1
    dx = diff(cx(1:2));
else
    dx = 1;
end
xlim = [cx(1)-dx cx(end)+dx];

[ny,cy] = hist(y,yctrs);
if length(cy)>1
    dy = diff(cy(1:2));
else
    dy = 1;
end
ylim = [cy(1)-dy cy(end)+dy];

% Set up positions for the plots
switch lower(direction)
case 'in'
    inoutSign = 1;
case 'out'
    inoutSign = -1;
otherwise
    error(message('stats:scatterhist:BadDirection'));        
end
switch lower(location)
case {'ne' 'northeast'}
    scatterLoc = 3;
    scatterPosn = [.1 .1 .55 .55];
    scatterXAxisLoc = 'top'; scatterYAxisLoc = 'right';
    histXLoc = 1; histYLoc = 4;
    histXSign = -inoutSign; histYSign = -inoutSign;
case {'se' 'southeast'}
    scatterLoc = 1;
    scatterPosn = [.1 .35 .55 .55];
    scatterXAxisLoc = 'bottom'; scatterYAxisLoc = 'right';
    histXLoc = 3; histYLoc = 2;
    histXSign = inoutSign; histYSign = -inoutSign;
case {'sw' 'southwest'}
    scatterLoc = 2;
    scatterPosn = [.35 .35 .55 .55];
    scatterXAxisLoc = 'bottom'; scatterYAxisLoc = 'left';
    histXLoc = 4; histYLoc = 1;
    histXSign = inoutSign; histYSign = inoutSign;
case {'nw' 'northwest'}
    scatterLoc = 4;
    scatterPosn = [.35 .1 .55 .55];
    scatterXAxisLoc = 'top'; scatterYAxisLoc = 'left';
    histXLoc = 2; histYLoc = 3;
    histXSign = -inoutSign; histYSign = inoutSign;
otherwise
    error(message('stats:scatterhist:BadLocation'));        
end

% Put up the histograms in preliminary positions.
clf
hHistY = subplot(2,2,histYLoc);
barh(cy,histYSign*ny,1);
xmax = max(ny);
if xmax == 0, xmax = 1; end % prevent xlim from being [0 0]
axis([sort(histYSign*[xmax, 0]), ylim]);
axis('off');

hHistX = subplot(2,2,histXLoc);
bar(cx,histXSign*nx,1);
ymax = max(nx);
if ymax == 0, ymax = 1; end % prevent ylim from being [0 0]
axis([xlim, sort(histXSign*[ymax, 0])]);
axis('off');

% Put the scatterplot up last to put it first on the child list
hScatter = subplot(2,2,scatterLoc);
hScatterline = plot(x,y,'o');
axis([xlim ylim]);
xlabel(getString(message('stats:scatterhist:xaxisLabel')));
ylabel(getString(message('stats:scatterhist:yaxisLabel')));

% Create invisible text objects for later use
txt1 = text(0,0,'42','Visible','off','HandleVisibility','off');
txt2 = text(1,1,'42','Visible','off','HandleVisibility','off');

% Make scatter plot bigger, histograms smaller
set(hScatter,'Position',scatterPosn, 'XAxisLocation',scatterXAxisLoc, ...
             'YAxisLocation',scatterYAxisLoc, 'tag','scatter');
set(hHistX,'tag','xhist');
set(hHistY,'tag','yhist');

scatterhistPositionCallback();

colormap([.8 .8 1]); % more pleasing histogram fill color

% Attach custom datatips
if ~isempty(hScatterline) % datatips only if there are data
    hB = hggetbehavior(hScatterline,'datacursor');
    set(hB,'UpdateFcn',@scatterhistDatatipCallback);
    setappdata(hScatterline,'obsinds',obsinds);
end

% Add listeners to resize or relimit histograms when the scatterplot changes
addlistener(hScatter,{'Position' 'OuterPosition'}, 'PostSet',@scatterhistPositionCallback);
addlistener(hScatter,{'XLim' 'YLim'},'PostSet',@scatterhistXYLimCallback);

% Leave scatter plot as current axes
set(get(hScatter,'parent'),'CurrentAxes',hScatter);

if nargout>0
    h = [hScatter hHistX hHistY];
end


% -----------------------------
function [xctrs,yctrs] = defaultBins(x,y)
% By default use the bins given by Scott's rule
xctrs = internal.stats.histbins(x); % returns bin ctrs
yctrs = internal.stats.histbins(y); % returns bin ctrs
if length(xctrs)<2
    xctrs = 1; % for constant data, use one bin
end
if length(yctrs)<2
    yctrs = 1; % for constant data, use one bin
end
end


% -----------------------------
function scatterhistPositionCallback(~,~)
posn = getrealposition(hScatter,txt1,txt2);
if feature('HGUsingMATLABClasses')
    % drawnow ensures that OuterPosition is updated
    drawnow('expose');
end
oposn = get(hScatter,'OuterPosition');

switch lower(location)
case {'sw' 'southwest'}
    % vertically: margin, histogram, margin/4, scatterplot, margin
    vmargin = min(max(1 - oposn(2) - oposn(4), 0), oposn(2));
    posnHistX = [posn(1) vmargin posn(3) oposn(2)-1.25*vmargin];
    % horizontally: margin, histogram, margin/4, scatterplot, margin
    hmargin = min(max(1 - oposn(1) - oposn(3), 0), oposn(1));
    posnHistY = [hmargin posn(2) oposn(1)-1.25*hmargin posn(4)];
case {'ne' 'northeast'}
    % vertically: margin, scatterplot, margin/4, histogram, margin
    vmargin = max(oposn(2), 0);
    posnHistX = [posn(1) oposn(2)+oposn(4)+.25*vmargin posn(3) 1-oposn(2)-oposn(4)-1.25*vmargin];
    % horizontally: margin, scatterplot, margin/4, histogram, margin
    hmargin = max(oposn(1), 0);
    posnHistY = [oposn(1)+oposn(3)+.25*hmargin posn(2) 1-oposn(1)-oposn(3)-1.25*hmargin posn(4)];
case {'se' 'southeast'}
    % vertically: margin, histogram, margin/4, scatterplot, margin
    vmargin = max(1 - oposn(2) - oposn(4), 0);
    posnHistX = [posn(1) vmargin posn(3) oposn(2)-1.25*vmargin];
    % horizontally: margin, scatterplot, margin/4, histogram, margin
    hmargin = max(oposn(1), 0);
    posnHistY = [oposn(1)+oposn(3)+.25*hmargin posn(2) 1-oposn(1)-oposn(3)-1.25*hmargin posn(4)];
case {'nw' 'northwest'}
    % vertically: margin, scatterplot, margin/4, histogram, margin
    vmargin = max(oposn(2), 0);
    posnHistX = [posn(1) oposn(2)+oposn(4)+.25*vmargin posn(3) 1-oposn(2)-oposn(4)-1.25*vmargin];
    % horizontally: margin, histogram, margin/4, scatterplot, margin
    hmargin = max(1 - oposn(1) - oposn(3), 0);
    posnHistY = [hmargin posn(2) oposn(1)-1.25*hmargin posn(4)];
end
posnHistX = max(posnHistX,[0 0 .05 .05]);
posnHistY = max(posnHistY,[0 0 .05 .05]);

set(hHistX,'Position',posnHistX);
set(hHistY,'Position',posnHistY);

scatterhistXYLimCallback();
end

% -----------------------------
function scatterhistXYLimCallback(~,~)
set(hHistX,'Xlim',get(hScatter,'XLim'));
set(hHistY,'Ylim',get(hScatter,'YLim'));
end

% -----------------------------
function datatipTxt = scatterhistDatatipCallback(~,evt)
target = get(evt,'Target');
ind = get(evt,'DataIndex');
pos = get(evt,'Position');

obsinds = getappdata(target,'obsinds');
obsind = obsinds(ind);

% datatipTxt = {...
%     sprintf('x: %s',num2str(pos(1)))...
%     sprintf('y: %s',num2str(pos(2)))...
%     ''...
%     sprintf('Observation: %s',num2str(obsind))...
%     };
datatipTxt = {...
    getString(message('stats:scatterhist:dataTip_x',num2str(pos(1)))), ...
    getString(message('stats:scatterhist:dataTip_y',num2str(pos(2)))), ...
    '', ...
    getString(message('stats:scatterhist:dataTip_Obs',num2str(obsind))), ...
    };
end

end % scatterhist main function

% -----------------------------
function p = getrealposition(a,txt1,txt2)
p = get(a,'position');

% For non-warped axes (as in "axis square"), recalculate another way
if isequal(get(a,'WarpToFill'),'off')
    pctr = p([1 2]) + 0.5 * p([3 4]);
    xl = get(a,'xlim');
    yl = get(a,'ylim');
    
    % Use text to get coordinate (in points) of southwest corner
    set(txt1,'units','data');
    set(txt1,'position',[xl(1) yl(1)]);
    set(txt1,'units','pixels');
    pSW = get(txt1,'position');
    
    % Same for northeast corner
    set(txt2,'units','data');
    set(txt2,'position',[xl(2) yl(2)]);
    set(txt2,'units','pixels');
    pNE = get(txt2,'position');
    
    % Re-create position
    % Use min/max/abs in case one or more directions are reversed
    p = [min(pSW(1),pNE(1)), ...
         max(pSW(2),pNE(2)), ...
         abs(pNE(1)-pSW(1)), ...
         abs(pNE(2)-pSW(2))];
    p = hgconvertunits(ancestor(a,'figure'),p, ...
             'pixels','normalized',ancestor(a,'figure'));
    
    % Position to center
    p = [pctr(1)-p(3)/2, pctr(2)-p(4)/2, p(3), p(4)];
end
end % getrealposition function
