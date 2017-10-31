function [m,b]=St_Line_Between_2P(x1,y1,x2,y2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% straight line         %%%
%%% passing for 2 points  %%%
%%% y=m*x+b               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if x1==x2
   m=+Inf;
   b=x1;
elseif y1==y2
    m=0;
    b=y1;
else
    m=(y1-y2)/(x1-x2);
    b=y1-m*x1;
end





