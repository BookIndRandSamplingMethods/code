%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Points Uniformly Distributed within a Circle                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% x1^2+x2^2=4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
hFig=figure;
set(hFig, 'Position', [100 200 600 600])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (TRIVIAL) WRONG PROCEDURE %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=1000;%%%% number of samples
r=2*rand(1,N);
theta=2*pi*rand(1,N); 
x1=r.*cos(theta);
x2=r.*sin(theta);
plot(x1,x2,'k.','MarkerSize',10)
%%%%%%%%%%
%%% plot circle
x=-2:0.01:2;
hold on
plot(x,sqrt(4-x.^2),'r','LineWidth',4)
plot(x,-sqrt(4-x.^2),'r','LineWidth',4)
%%%%
axis([-4 4 -4 4])
text(-2.3,3,'Non-Uniform distributed','FontWeight','Bold','FontSize',25)
title('Using a wrong procedure','FontWeight','Bold','FontSize',30)
box on
set(gca,'FontSize',25)
set(gca,'FontWeight','Bold')
ylabel('x_2')
xlabel('x_1')
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% with a CORRECT PROCEDURE       %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% ACCEPT-REJECT METHOD 
%%% SAMPLING WITH-IN A RECTANGLE 
Nr=3000; %%% Samples from the RECTANGLE [-3,3]x[-3,3]  
x11=-3+6*rand(1,Nr);
x22=-3+6*rand(1,Nr);
%%%%%%  ACCEPT-REJECT METHOD 
pos=find(x11.^2+x22.^2<=4); %%%% ACCEPTED ONLY SOME SAMPLES with radio<=4
N_acc=length(pos); %%% number of accepted samples 
%%%%%%%%%%
%%% plot accepted samples
hFig=figure;
set(hFig, 'Position', [750 200 600 600])
plot(x11(pos),x22(pos),'k.','MarkerSize',10)
hold on
%%%%%%%%%%
%%% plot circle
plot(x,sqrt(4-x.^2),'r','LineWidth',4)
plot(x,-sqrt(4-x.^2),'r','LineWidth',4)
axis([-4 4 -4 4])
%%%%%%%%%%
%%% plot rectangle
plot([-3 -3],[-3 3],'b--','LineWidth',4)
plot([3 3],[-3 3],'b--','LineWidth',4)
plot([-3 3],[-3 -3],'b--','LineWidth',4)
plot([-3 3],[3 3],'b--','LineWidth',4)
%%%%%%%%%%
title('Using a correct procedure','FontWeight','Bold','FontSize',30)
set(gca,'FontSize',25)
set(gca,'FontWeight','Bold')
ylabel('x_2')
xlabel('x_1')
box on
text(-2.2,3.5,'Uniform distributed','FontWeight','Bold','FontSize',25)
text(-3,-3.2,'Obtained using an Accept-Reject (AR) procedure:',...
    'FontWeight','Bold','FontSize',15)
text(-3,-3.5,'(a) draw different points uniformly in this rectangle',...
    'FontWeight','Bold','FontSize',15)
text(-3,-3.8,'(b) accept all the points inside the circle',...
    'FontWeight','Bold','FontSize',15)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
