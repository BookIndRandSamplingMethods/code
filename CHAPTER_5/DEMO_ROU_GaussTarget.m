%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%          DEMO: STANDARD RoU        %%%%%
%%%%%      using Rejection Sampling      %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%      for GAUSSIAN TARGET PDF        %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc
disp(' ')
disp('---------------------------------------------------------------------------------------------')
disp(' ')
disp(' DEMO: STANDARD RoU   ')
disp('  (using Rejection Sampling) ' )
disp('   for GAUSSIAN TARGET PDF ' )
slowingdown=input('Slown down the code (Yes=1, otherwise No) ? ');
disp(' ') 
if slowingdown==1
%%%%%%%%
N=100;% number of desired samples
%%%%%%%%       
disp(' The code is slowed down in order to allow a suitable graphical representation ')
else
%%%%%%%%
N=2000;% number of desired samples
%%%%%%%% 
disp(' The code is not slowed down ')
end
disp(' ')
disp([' Number of desired samples = ',num2str(N)])
disp(' ')
disp('---------------------------------------------------------------------------------------------')
%%%% GAUSSIAN TARGET as an example
T=@(x) exp(-x.^2/2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_boundary_of_the_region %%% plotting boundary of the region A
%%%% note that the script above also provide the variable
%%%% AREA_REGION_A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%  plotting covering rectangle %%%%%%%%%%%
plot([-1.5 -1.5],[0 1.2],'b','LineWidth',4)
plot([1.5 1.5],[0 1.2],'b','LineWidth',4)
plot([-1.5 1.5],[1.2 1.2],'b','LineWidth',4)
plot([-1.5 1.5],[0 0],'b','LineWidth',4)
text(1,1.3,'R','FontSize',40,'FontWeight','Bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ')
disp(' press a key ')
pause
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count_accSam=0; %% counting accepted samples
count_rejSam=0; %% counting rejected samples
count_iter=0;   %% counting iterations 
accepted_samples=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% START - MAIN LOOP       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while count_accSam<N    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    count_iter=count_iter+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   u=1.2*rand(1,1); %%% in standard RoU it must be positive 
   v=-1.5+3*rand(1,1);
  AREA_REGION_R=3*1.2; %%% area rectangle
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% then proposed sample is:
   x_pr=v/u;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   Sqrt_Target_at_xpr=sqrt(T(x_pr));
%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% TEST           %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
   if u<=Sqrt_Target_at_xpr & u>=0
   %%%% 
       disp(['accepted; number ',num2str(count_accSam),' over ',num2str(N)])
       hold on
       plot(v,u,'go','MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',7)
     accepted_samples(end+1)=x_pr; 
     count_accSam=count_accSam+1;
   %%%
   else
   %%%   
      disp(['rejected; number ',num2str(x_pr)])
       hold on
     plot(v,u,'ro','MarkerEdgeColor','k',...
                       'MarkerFaceColor','r',...
                       'MarkerSize',7)
     count_rejSam=count_rejSam+1;
   end
  
 if slowingdown==1  
   pause(0.0000005) %%% slowing down the code
 end
end%%end main while
%%% accepted_samples= contains the accepted samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%
 figure
 title('Histogram of the accepted samples','FontSize',15,'FontWeight','Bold')
 [v,c]=hist(accepted_samples,15);
 aux_diff=abs(c(2)-c(1));
 const=sum(aux_diff*v);
 bar(c,v/const,'g') 
 hold on
 x=-4:0.001:4;   
 plot(x,(1/sqrt(2*pi))*T(x),'b','linewidth',3) 
 xlabel('x','FontSize',30,'FontWeight','Bold')
 ylabel('y','FontSize',30,'FontWeight','Bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
disp(['Theoretical Acceptance Rate (AREA_REGION_A/AREA_RECTANGLE_R) =', num2str(AREA_REGION_A/AREA_REGION_R)])
disp('---------------------------------------------------------------------------------------------')
