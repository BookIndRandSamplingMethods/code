%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DEMO Rejection Sampler %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DEFINE TARGET and PROPOSAL FUNCTIONS
Px=@(x) 0.5*exp(-(x-1.5).^2)+0.5*exp(-(x+1).^2); %%% TARGET 
mu_pi=0.2; %%%% mean - proposal
s2=5/2; %%%% variance - proposal
Pi=@(x) 0.5*exp(-1/(2*s2)*(x-mu_pi).^2); %%%% PROPOSAL 
L=2; %%%% BOUND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% initializing variables %%%
accepted_samples=[];%%% vector of accepted samples
N=100; %%% number of desired samples
count_accSam=0; %%% counting the accepted samples
count_rejSam=0; %%% counting the rejected samples
count_iter=0;   %%% counting the number of iterations 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ')
disp('---------------------------------------------------------------------------------------------')
disp(' ')
disp(' REJECTION SAMPLING (RS)')
disp([' Number of desired samples =',num2str(N)])
disp(' The code is slowed down in order to allow a suitable graphical representation ')
disp(' ')
disp('---------------------------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (Initial) PLOTS TARGET and PROPOSAL FUNCTIONS
figure
subplot(2,1,1)
set(gca,'YTick',[])
x=-5:0.01:5;
hold on
plot(x,Px(x),'linewidth',3)
set(gca,'FontWeight','Bold','FontSize',17)
text(1.5,0.8,'L\pi(x)','FontSize',15,'FontAngle','italic')
text(0,0.6,'\pi(x)','FontSize',15,'FontAngle','italic')
text(0.6,0.2,'p(x)','FontSize',15,'FontAngle','italic')
axis([-5 5 0 1.3])
plot(x,Pi(x),'r--','linewidth',2)
plot(x,L*Pi(x),'r','linewidth',3)
title('The unnormalized target pdf p(x) and the proposal pdf  \pi(x)')
%title('aqui')
xlabel('x')
disp(' press a key ')
pause %%%% press a key to start 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% START - MAIN LOOP       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while  count_accSam<N   
 
  count_iter=count_iter+1; %%%% counting the number of iterations 
     
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%% Drawing a sample from the proposal %%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 proposed_sample=mu_pi+sqrt(s2/2)*randn(1,1); %%%% random abiscissa X for the graphical RS test  
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u=rand(1,1);
Y=L*Pi(proposed_sample)*u; %%% random ordinate Y (vertical value) for RS test 
%%%  RS TEST= we check if (X,Y) is below the graph of \pi(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot settings
subplot(2,1,1)
xlim([-5 5])
hold on
set(gca,'YTick',[])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% RS Test- graphical way %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Y>Px(proposed_sample) 
    disp('rejected (red point)') 
  plot(proposed_sample,Y,'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',7)
  count_rejSam=count_rejSam+1; %%%% counting rejected samples
%%%%  
else
%%%%    
    disp(['accepted (green point); number ',num2str(count_accSam),' over ',num2str(N)])
  plot(proposed_sample,Y,'o','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',7)
  count_accSam=count_accSam+1; %%%% counting accepted samples
  accepted_samples(count_accSam)=proposed_sample;
end %%% end RS test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% below just plotting 
pause(0.005) %%%% slowing down the code
subplot(2,1,2)
cla
hold on 
%set(gca,'YTick',[])
axis([-5 5 0 0.6])
%xlim([-5 5])
set(gca,'YTick',[])
set(gca,'FontWeight','Bold','FontSize',17)
title('Histogram formed by x-coordinates of the green points above')
xlabel('x')
%%%%% plot histogram of the accepted samples
if isempty(accepted_samples)==0 
 [v,c]=hist(accepted_samples,18);
 esto=abs(c(2)-c(1));
 cost=sum(esto*v);
 bar(c,v/cost,'g')
   x=-5:0.001:5;
  cost2=sum(0.001*Px(x));
  plot(x,Px(x)/cost2,'-','linewidth',2.5)
 text(0.6,0.35,'p_o(x)','FontSize',15,'FontAngle','italic') 
end
%%%%%%
end %%%% end  While
%%% accepted_samples= contains the accepted samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
disp(' ')
disp(' ')
disp('---------------------------------------------------------------------------------------------')
disp('FINAL REPORT')
disp('---------------------------------------------------------------------------------------------')
disp(['Total number of iterations T = ',num2str(count_iter)])
disp(['Number of desired (accepted) samples N = ',num2str(N)])
disp(['Final number of rejected samples = ',num2str(count_rejSam)])
disp('---------------------------------------------------------------------------------------------')
disp(['Acceptance Rate obtained at this run = N/T = ',num2str(N/count_iter)])
disp('---------------------------------------------------------------------------------------------')


