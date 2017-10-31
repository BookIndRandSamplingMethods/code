%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% WIENER PROCESS      %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% it is a special case of a GP %%%%%%%
clear all
close all
clc
disp('---------------------------------------------')
disp(' WIENER PROCESS  ')
disp(' It is a special case of a Gaussian Process  ')
disp('---------------------------------------------')
%%%%%%
t=0:0.01:1;
%%%% kernel function %%%%%
K=@(z1,z2) min([z1,z2]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% COVARIANCE MATRIX given the inputs %%%%%%%%%% 
 for i=1:length(t)
     for j=1:length(t)
        SIGMA(i,j)=K(t(i),t(j));
     end;
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L=length(t);
B=chol(SIGMA+0.000001*eye(L,L)); %%% 0.000001 only for avoiding numerical issues
%%%%%%%%%%%%%%%%
NUM_CURVES=10;
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DRAW NUM_CURVES TIMES FORM A N(0,SIGMA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:NUM_CURVES
    f(i,:)=B'*randn(1,L)';
end
%%%% plot %%%%%
    plot(t,f,'LineWidth',4)
    axis([0 1 -2.7 2.7])
    box on
    set(gca,'FontSize',30)
    set(gca,'FontWeight','Bold')
    ylabel('W_t')
    xlabel('t')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

