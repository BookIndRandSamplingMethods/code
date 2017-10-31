%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Sampling Triangular and Linear Densities %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%
%%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%
disp(' ')
disp('-------------------------------------------------')
disp(' ')
disp('     Sampling Triangular and Linear Densities ')
disp('   (using two independent samples from U([0,1]))')
disp(' ')
disp('-------------------------------------------------')
%%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%% 
c=0.1; %%% aux paramater
Number_of_samples=300000; %%% number of desired samples
disp(' ')
disp([' Number of drawn samples = ',num2str(Number_of_samples)])
disp([' c = ',num2str(c)])
disp(' ')
disp(' 1- pdf obtained by: min([u v])')
disp(' 2- pdf obtained by: max([u v])')
disp(' 3- pdf obtained by: (1-c)*min([u v])+c*max([u v])')
disp(' 4- pdf obtained by: 0.5*min([u v])+0.5*max([u v])')
disp(' ')
disp(' where u,v~ U([0,1])')
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% START - MAIN LOOP       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:Number_of_samples
u=rand(1,1);
v=rand(1,1);
%%%
MIN_u_v(i)=min([u v]);
%%%
MAX_u_v(i)=max([u v]);
%%%
combination_MIN_MAX(i)=(1-c)*min([u v])+c*max([u v]);
%%%
combination_MIN_MAX_other(i)=0.5*min([u v])+0.5*max([u v]);
%%%
end
%%%%%%%%% end main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hist(MIN_u_v,60) 
set(gca,'YTick',[])
set(gca,'FontWeight','Bold','FontSize',17)
title('min([u,v])')
xlabel('x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hist(MAX_u_v,60) 
set(gca,'YTick',[])
set(gca,'FontWeight','Bold','FontSize',17)
title('max([u,v])')
xlabel('x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(2,1,1)
hist(combination_MIN_MAX,60)
set(gca,'YTick',[])
set(gca,'FontWeight','Bold','FontSize',17)
title('Combination Min-Max')
xlabel('x')
%%%
subplot(2,1,2)
hist(combination_MIN_MAX_other,60)
set(gca,'YTick',[])
set(gca,'FontWeight','Bold','FontSize',17)
title('Combination Min-Max with c=0.5')
xlabel('x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
