%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Points Uniformly Distributed in a (Archimedean) Spiral              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
t=0:0.01:2*pi; %%% parameter
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%%
hFig=figure;
set(hFig, 'Position', [200 200 600 600])
subplot(2,1,1)
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
%%% parametric form of the curve 
x1=@(z) z.*cos(2*pi*z);
x2=@(z) z.*sin(2*pi*z);
%%%% %%%% %%%% %%%% %%%% %%%% %%%% %%%% 
plot(x1(t),x2(t),'r','LineWidth',3)
axis([-6.3 6.3 -10  10])
title('Spiral  ','FontSize',20,'FontWeight','Bold')
set(gca,'FontSize',20)
set(gca,'FontWeight','Bold')
ylabel('x_2')
xlabel('x_1')
box on
%%%%%%%%%%  %%%%%%%%%%% %%%%%%%%%%  %%%%%%%%%%% %%%%%%%%%%  %%%%%%%%%%%%%%% 
subplot(2,1,2)
%%%%%%%  Module of the Gradient of the Curve
q=@(z) (4*pi^2*z.^2 + 1).^(1/2); %%% Module of the Gradient of the Curve
%%%%%%%
plot(t,q(t),'b','LineWidth',3)
hold on
%%% rectangle for REJECTION SAMPLING 
plot([0 2*pi],[(4*pi^2*(2*pi).^2 + 1).^(1/2) (4*pi^2*(2*pi).^2 + 1).^(1/2)],'r--','LineWidth',3) 
axis([0 2*pi 0 43])
set(gca,'FontSize',20)
set(gca,'FontWeight','Bold')
 xlabel('t','FontSize',20,'FontWeight','Bold')
 title('Module of the Gradient of the Curve - q(t)    ','FontSize',20,...
        'FontWeight','Bold')
 box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
N=500; %%%% number of desired samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% sampling a rectangle N times 
u=(4*pi^2*(2*pi).^2 + 1).^(1/2)*rand(1,N);
t_pr=2*pi*rand(1,N);
t_acp=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SAMPLING q(t) via REJECTION SAMPLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for n=1:N
   if u(n)<=(4*pi^2*t_pr(n).^2 + 1).^(1/2)
      t_acp(end+1)=t_pr(n);
     subplot(2,1,2) 
     hold on
     plot(t_pr(n),u(n),'g.','LineWidth',5)    
   else
     subplot(2,1,2)  
     plot(t_pr(n),u(n),'r.','LineWidth',5)   
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
subplot(2,1,1)
hold on
plot(x1(t_acp),x2(t_acp),'k.','MarkerSize',10)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   pause(0.01) %%% slowing down the code   
end 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

