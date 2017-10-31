function [Area_tot,areas_pieces,xint,yint,m,b,S2]=Build_Prop(S,V,D_v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Build Proposal pdf for ARS schemes  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 m=D_v(S);
 b=V(S)-m.*S;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Finding intersection points between 2 tangent lines
for i=1:length(S)-1
[xint(i),yint(i)]=Inter_between_2Lines(m(i),b(i),m(i+1),b(i+1));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% AREAS below each pieces
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S2=[-inf xint +inf];
for i=1:length(S2)-1
      areas_pieces(i)=(1/m(i))*exp(m(i)*S2(i+1)+b(i))-(1/m(i))*exp(m(i)*S2(i)+b(i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
Area_tot=sum(areas_pieces);