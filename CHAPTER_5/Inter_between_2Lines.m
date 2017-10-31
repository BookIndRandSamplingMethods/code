function [xint,yint]=Inter_between_2Lines(m1,b1,m2,b2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% intersection between two straight lines %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if m1~=m2
      xint=(b1-b2)/(m2-m1);
      yint=(b1*m2-b2*m1)/(m2-m1); 
  else
    disp('parallel lines')
end
