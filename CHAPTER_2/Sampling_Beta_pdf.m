%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Sampling Beta distributions with Uniform Ordered Random variables %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc

%%%%%%%%
%%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%
disp(' ')
disp('-------------------------------------------------------------------------')
disp(' ')
disp('     Sampling Beta distributions with Uniform Ordered Random variables ')
disp(' ')
disp('-------------------------------------------------------------------------')
%%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%%%%%%% %%% 
c=0.1; %%% aux paramater
Number_of_samples=50000; %%% number of desired samples
M=3; %%% number of uniform random variables
disp(' ')
disp([' Number of drawn samples = ',num2str(Number_of_samples)])
disp([' c = ',num2str(c)])
disp(' ')
disp(' 1- pdf: p_o(x)=3(1-x)^2')
disp(' 2- pdf: p_o(x)=6x(1-x)')
disp(' 3- pdf: p_o(x)=3x^2')
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% START - MAIN LOOP       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:Number_of_samples
u=rand(1,M);
u_s(i,:)=sort(u); %%% sorted in ascending order
end
%%%%%%%%% end main loop
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=0:0.01:1;
%%%%%%%%%%%
figure
[a,b]=hist(u_s(:,1),50);
c=b(2)-b(1);
Norm_const=sum(c.*a); %%% normalizing the histogram
bar(b,a*1/Norm_const,'r')
hold on
plot(x,3*(1-x).^2,'k','LineWidth',5)
%set(gca,'YTick',[])
set(gca,'FontWeight','Bold','FontSize',20)
title('p_o(x)=3(1-x)^2')
xlabel('x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
[a,b]=hist(u_s(:,2),50);
c=b(2)-b(1);
Norm_const=sum(c.*a); %%% normalizing the histogram
bar(b,a*1/Norm_const,'r')
hold on
plot(x,6*x.*(1-x),'k','LineWidth',5)
set(gca,'FontWeight','Bold','FontSize',20)
title('p_o(x)=6x(1-x)')
xlabel('x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
[a,b]=hist(u_s(:,3),50);
c=b(2)-b(1);
Norm_const=sum(c.*a); %%% normalizing the histogram
bar(b,a*1/Norm_const,'r')
hold on
plot(x,3*x.^2,'k','LineWidth',5)
set(gca,'FontWeight','Bold','FontSize',20)
title('p_o(x)=3x^2')
xlabel('x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
