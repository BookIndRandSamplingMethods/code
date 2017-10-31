%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Points Uniformly Distributed in a Ellipse                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp('------------------------------------------------')
disp('    Points Uniformly Distributed in a Ellipse   ')
disp('------------------------------------------------')
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
t=0:0.01:2*pi; %%% parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
hFig=figure;
set(hFig, 'Position', [200 200 1000 1000])
subplot(1,2,1)
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%% parametric form of the curve 
x1=@(z) cos(z);
x2=@(z) 3*sin(z);
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
plot(x1(t),x2(t),'r','LineWidth',10)
axis([-2 2 -4  4])
title('Ellipse  ','FontSize',20,'FontWeight','Bold') 
set(gca,'FontSize',20)
set(gca,'FontWeight','Bold')
 ylabel('x_2')
 xlabel('x_1')
 box on
%%%%%%%%%%%% %%%%%%%%%%%%  %%%%%%%%%%%% %%%%%%%%%%%% %%%%%%%%%%%% %%%%%%%%%
subplot(1,2,2)
%%%%%%%%  Module of the Gradient of the Curve
q=@(z) sqrt(9*cos(z).^2+sin(z).^2); %%%% Module of the Gradient of the Curve
%%%%%%%%
plot(t,q(t),'b','LineWidth',3)
hold on
plot([0 2*pi],[3.4 3.4],'r--','LineWidth',3) %%% rectangle for REJECTION SAMPLING
axis([0 2*pi 0 4])
set(gca,'FontSize',20)
set(gca,'FontWeight','Bold')
 xlabel('t','FontSize',20,'FontWeight','Bold')
 title('Module of the Gradient of the Curve - q(t)    ','FontSize',20,...
        'FontWeight','Bold')
 box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=200; %%%% number of desired samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sampling a rectangle N times 
u=3.4*rand(1,N);
t_pr=2*pi*rand(1,N);
t_acp=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SAMPLING q(t) via REJECTION SAMPLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:N
   if u(n)<=sqrt(9*cos(t_pr(n)).^2+sin(t_pr(n)).^2)
      t_acp(end+1)=t_pr(n);
      subplot(1,2,2)
     hold on
     plot(t_pr(n),u(n),'g.','LineWidth',5)  
   else
       subplot(1,2,2)
     plot(t_pr(n),u(n),'r.','LineWidth',5)
   end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(1,2,1)
    hold on
    plot(x1(t_acp),x2(t_acp),'k.','MarkerSize',7)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   pause(0.01) %%% slowing down the code
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 