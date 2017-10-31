%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DEMO Generalized ARS (GARS) method %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% graphical settings %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
h3=figure;
scrsz = get(0,'ScreenSize');
x=-4:0.001:4;  
set(h3,'OuterPosition',[scrsz(1)+400,scrsz(2)+200,600,750])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Target function and its decomposition
g1=@(x) 4-x.^2;  %%% nonlinearity
V=@(x) g1(x).^2; %%% potential V(x;g)
Target=@(x) exp(-V(x)); %%% target
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% initial support points 
s0=[-3 -2 1 2 3];
s=s0;
s=sort(s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(3,1,1)
 title('Nonlinearity','FontSize',15,'FontWeight','Bold')
 hold on
 axis([-4 4 -12 5])
 r=BuildandPlot_LinFun_gars(s);
%%% 
subplot(3,1,2)
 title('Potential function','FontSize',15,'FontWeight','Bold')
 hold on
 text(-3.7,100,'V(x;g)=V_1(g_1(x))=(4-x^2)^2','FontSize',15,'fontweight','bold')
 text(0.5,115,'V_1(\vartheta)=\vartheta^2','FontSize',15,'fontweight','bold')
 text(0.5,75,'g_1(x)=4-x^2','FontSize',15,'fontweight','bold')
 x=-4:0.001:4;
 plot(x,V(x),'b')
 plot(s,V(s),'ko','MarkerFaceColor','r','Markersize',5)
 hold on
 axis([-4 4 -30 150])
%%%
subplot(3,1,3)
  axis([-4 4 0 1.5])
  hold on
  plot(x,Target(x),'b','linewidth',1)
  plot(s,Target(s),'ko','MarkerFaceColor','r','Markersize',5)
  text(-1,0.7,'p(x)=exp\{-(4-x^2)^2\}','FontSize',15,'fontweight','bold')
  xlabel('x','FontSize',18,'FontWeight','Bold')
  title('Target pdf','FontSize',15,'FontWeight','Bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('---------------------------------------------------------------------------------')
disp(' DEMO Generalized ARS (GARS) method  ')
disp(' The code is slowed down in order to allow a suitable graphical representation')
disp('---------------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% initializing variables
N=200; %%% number of desired samples
disp(' ')
disp(['desired number of samples =',num2str(N)])
accepted_samples=[];
count_accSam=0; %%%%  counting the number of accepted samples
count_iter=0;   %%%%  counting the number of iterations 
count_rejSam=0; %%%%  counting the number of rejected samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ')
disp('press a key')
disp(' ')
pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% START - MAIN LOOP       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while count_accSam<N
%%%%%
count_iter=count_iter+1; %%% counting the iterations
%%%%%%% %%% %%%%%%%%%% %%%%%% %%%%%% %%%%%% %%%%%%
%%%% plot target and its composition
 subplot(3,1,1)
 axis([-4 4 -12 5])
 r=BuildandPlot_LinFun_gars(s);
 %%%%%%
 subplot(3,1,3)
 cla
 axis([-4 4 0 1.5])
 hold on
 plot(x,Target(x),'b','linewidth',1)
 text(-1,0.7,'p(x)=exp\{-(4-x^2)^2\}','FontSize',15,'fontweight','bold')
 xlabel('x','FontSize',18,'FontWeight','Bold')
 title('Target pdf','FontSize',11,'FontWeight','Bold')
 %%%%%%
 subplot(3,1,2) 
 cla
 x=-4:0.001:4;
 plot(x,V(x),'b')
 axis([-4 4 -30 150])
 %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%%
 %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%% %%%%%%
for i=1:length(r)  %%% plot tangent lines to the modified potential
%%%
    if i==1 %%% first interval
       x1=-4:0.001:s(i);
        x_star=(-4+s(i))/2; %%%%  point where computing the tangent line
    elseif i==length(r) %%% last interval
        x1=s(i-1):0.001:4;
        x_star=(4+s(i-1))/2; %%%%  point where computing the tangent line
    else %%% standard nterval
        x1=s(i-1):0.001:s(i); 
         x_star=(s(i)+s(i-1))/2; %%%%  point where computing the tangent line
    end 
%%%        
 subplot(3,1,2) 
  text(-3.7,100,'V(x;g)=V_1(g_1(x))=(4-x^2)^2','FontSize',15,'fontweight','bold')
  hold on
  text(0.5,115,'V_1(\vartheta)=\vartheta^2','FontSize',15,'fontweight','bold')
  text(0.5,75,'g_1(x)=4-x^2','FontSize',15,'fontweight','bold')
  plot(s,V(s),'ko','MarkerFaceColor','r','Markersize',5)
  hold on  
  plot(x1,(r(i,1)*x1+r(i,2)).^2,'r--','LineWidth',1)
  m(i)=2*r(i,1)*(r(i,1)*x_star+r(i,2));
  b(i)=(r(i,1)*x_star+r(i,2)).^2-m(i)*x_star;
  plot(x1,m(i)*x1+b(i),'k','LineWidth',1)
%%% 
  subplot(3,1,3)
   hold on
   axis([-4 4 0 1.5])
   plot(x1,exp(-(r(i,1)*x1+r(i,2)).^2),'r--','LineWidth',1)
   plot(x1,exp(-m(i)*x1-b(i)),'k','LineWidth',1)
end %%%  end of for i=1:length(r)  
%%%
   s_ext=[-Inf s +Inf]; %%% extended set of support points
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%% computing areas below each exponential pieces   %%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     for i=1:length(s_ext)-1
        areas(i)=-(1/m(i))*exp(-(m(i)*s_ext(i+1)+b(i)))+(1/m(i))*exp(-(m(i)*s_ext(i)+b(i))); %%% areas below each pieces
     end 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
     wn=areas/sum(areas);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   %%%% choose a piece according to wn
     chosen_piece=randsrc(1,1,[1:length(wn);wn]);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   %%% sampling and evaluating the chosen truncated exponential piece     
  [proposed_sample,Proposal_Eval]=Sampling_Piece_Exp(m(chosen_piece),b(chosen_piece),s_ext(chosen_piece),s_ext(chosen_piece+1),1);
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%% evaluating target in proposed_sample %%%%%
   Target_Eval=Target(proposed_sample);
 %%% acceptance probability  %%%%%%%%%%%%%%%%%%%%%%%%  
   Pr_accept(count_iter)=Target_Eval/Proposal_Eval; 
 %%%   
   U=rand(1,1);     
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%% ACCEPT-REJECT TEST    %%% 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if U<Pr_accept(count_iter)
        disp(['accepted; number ',num2str(count_accSam),' over ',num2str(N)])
        accepted_samples(end+1)=proposed_sample;
        count_accSam=count_accSam+1; 
     else
       disp(['rejected ',num2str(proposed_sample)]) 
       s=[s proposed_sample];
        s=sort(s); 
       count_rejSam=count_rejSam+1;  %%% number of rejected samples
    end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     pause(0.001) %%% slowing down the code
end %%%end main while
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
disp(['Initial number of support points = ',num2str(length(s0))])
disp(['Final number of support points = ',num2str(length(s))])
disp('---------------------------------------------------------------------------------------------')
disp(['Acceptance Rate obtained at this run = N/T = ',num2str(N/count_iter)])
disp('---------------------------------------------------------------------------------------------')
disp(['Averaged of the acceptance probabilities obtained at this run = ',num2str(mean(Pr_accept))])
disp('---------------------------------------------------------------------------------------------')






