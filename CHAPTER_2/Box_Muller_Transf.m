%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%   BOX-MULLER TRANSFORMATION         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%  BOX-MULLER TRANSFORMATION  %% ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%%%% uniform variables
N_samples=5000;
u1=rand(1,N_samples);
u2=rand(1,N_samples);
%%%%%%%%%
%%%%%% transforming in Gaussian variables
Z1=sqrt(-log(u1)).*sin(2*pi*u2);
Z2=sqrt(-log(u1)).*cos(2*pi*u2);
%%%%%%%%%
figure
scatterhist(u1,u2)
set(gca,'FontWeight','Bold','FontSize',20)
box on
axis([-1 2 -1 2])
xlabel('u1')
ylabel('u2')
%%%%%%%%%%%%%%%%%%%%
figure
scatterhist(Z1,Z2)
set(gca,'FontWeight','Bold','FontSize',20)
box on
axis([-3 3 -3.5 3.5])
xlabel('Z1')
ylabel('Z2')