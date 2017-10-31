%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% GP INTERPOLATOR    %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Random Functions from the GP posterior - noise free observations  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp('---------------------------------------------------------------------')
disp(' Random Functions from a GP posterior with noise-free observations ')
disp('                        (GP INTERPOLATOR) ')
disp('---------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_obs=[-10 -2 4 10 ];
Y_obs=[3 1 -7 5];
N=length(T_obs); %%%% number of observed data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% KERNEL FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%
sig=2;
K=@(z1,z2) exp(-(z1-z2).^2/(2*sig^2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t=-20:0.1:20; %%%% test inputs 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% SIGMA_PRIOR 
 for i=1:length(t)  
   for j=1:length(t)  
     SIGMA_PRIOR(i,j)=K(t(i),t(j));
   end  
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% SIGMA_TRAINING 
 for i=1:N  
   for j=1:N  
     SIGMA_TRAINING(i,j)=K(T_obs(i),T_obs(j));
   end  
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
L=length(t); %%% number of test inputs 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for i=1:L
     for j=1:N
        Sigma_training_test(i,j)=K(t(i),T_obs(j));
     end
 end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%  POSTERIOR PARAMETERS %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 mu_post=Sigma_training_test*(SIGMA_TRAINING)^(-1)*Y_obs'; %%% MEAN
 %%% COVARIANCE 
 SIGMA_POST=SIGMA_PRIOR-Sigma_training_test*(SIGMA_TRAINING)^(-1)*Sigma_training_test';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NUMCURVES=20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B_post=chol(SIGMA_POST+0.000001*eye(L,L));%%% 0.000001 only for avoiding numerical problems
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DRAW NUM_CURVES TIMES FORM A N(mu_post,SIGMA_post)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:NUMCURVES
f_post(i,:)=mu_post+B_post'*randn(1,L)';
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% plot 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
plot(t,f_post,'LineWidth',4)
box on
set(gca,'FontSize',30)
set(gca,'FontWeight','Bold')
ylabel('f(t)')
xlabel('t')
axis([-20 20 -10 7])
for i=1:N
plot([T_obs(i) T_obs(i)],[-10 Y_obs(i)],'k--','LineWidth',2)    
end 
plot(T_obs, Y_obs,'ro','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',15)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

  
