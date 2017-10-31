%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DRAW SAMPLES UNIFORMLY WITHIN A TRIANGLE - 2D %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% v1,v2,v3 ===> 2D vertices
%%% N = number of samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%
N=1000; %%% number of desired samples
%%%% vertices
v1=[1 5];
v2=[2 0];
v3=[3 2];
%%%%%%%%
for i=1:N
   u1=rand(1,1);
   u2=rand(1,1);
   a=min([u1,u2]);
   b=max([u1,u2]);
gen_samples(:,i)=v1*a+v2*(1-b)+v3*(b-a);
end
%%%% plot
   plot(gen_samples(1,:),gen_samples(2,:),'k.','MarkerSize',10)
   hold on
   plot([v1(1,1) v2(1,1)],[v1(1,2) v2(1,2)],'r','LineWidth',6)
   plot([v1(1,1) v3(1,1)],[v1(1,2) v3(1,2)],'r','LineWidth',6)
   plot([v2(1,1) v3(1,1)],[v2(1,2) v3(1,2)],'r','LineWidth',6)
   plot(v1(1,1),v1(1,2),'ks','MarkerFaceColor','b','MarkerSize',17)
   plot(v2(1,1),v2(1,2),'ks','MarkerFaceColor','b','MarkerSize',17)
   plot(v3(1,1),v3(1,2),'ks','MarkerFaceColor','b','MarkerSize',17)
   aux1=min([v1(1) v2(1) v3(1)]);
   aux2=max([v1(1) v2(1) v3(1)]);
   aux3=min([v1(2) v2(2) v3(2)]);
   aux4=max([v1(2) v2(2) v3(2)]);
   axis([aux1-0.3 aux2+0.3 aux3-0.3 aux4+0.3])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
