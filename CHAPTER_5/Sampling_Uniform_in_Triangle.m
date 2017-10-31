function gen_samples=Sampling_Uniform_in_Triangle(v1,v2,v3,N,plotyes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DRAW SAMPLES UNIFORMLY WITHIN A TRIANGLE - 2D %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% v1,v2,v3 ===> 2D vertices
%%% N = number of samples
%%%% plotyes = 1 - for plotting the vertices and the generated samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EXAMPLES OF USE:
%%% gen_samples=Sampling_Uniform_in_Triangle([1 5],[0 0],[3 2],1000,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sampling method repeated N times%%%
for i=1:N
   u1=rand(1,1);
   u2=rand(1,1);
   a=min([u1,u2]);
   b=max([u1,u2]);
gen_samples(:,i)=v1*a+v2*(1-b)+v3*(b-a);
end
%%%% for plotting
if plotyes==1
   close all
   plot(gen_samples(1,:),gen_samples(2,:),'ko','MarkerFaceColor','g','MarkerSize',10)
   hold on
   plot([v1(1,1) v2(1,1)],[v1(1,2) v2(1,2)],'k','LineWidth',6)
   plot([v1(1,1) v3(1,1)],[v1(1,2) v3(1,2)],'k','LineWidth',6)
   plot([v2(1,1) v3(1,1)],[v2(1,2) v3(1,2)],'k','LineWidth',6)
   plot(v1(1,1),v1(1,2),'ks','MarkerFaceColor','b','MarkerSize',17)
   plot(v2(1,1),v2(1,2),'ks','MarkerFaceColor','b','MarkerSize',17)
   plot(v3(1,1),v3(1,2),'ks','MarkerFaceColor','b','MarkerSize',17)
end