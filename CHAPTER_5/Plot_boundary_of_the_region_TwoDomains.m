%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%     RATIO OF UNIFORMS        %%%%
%%%%% plot_boundary_of_the_region  %%%%
%%%%%  of a standard Gaussian pdf  %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  T=@(x) exp(-x.^2/2)           %%%%
%%%  Boundary of T(x)              %%%%
%%%%  RECALL   x=v/u               %%%%
%%% considering the area defined as %%%
%%% A=\{0<u<\sqrt(p(v/u))\}         %%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%
disp('-------------------------------------------------------------------')
disp(' ')
disp('Plotting boundary of the region A and the target pdf...')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  EQUATION OF THE CURVE: PARAMETRIC WAY 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 T=@(x) exp(-x.^2/2);
u=@(x) sqrt(T(x));
v=@(x) x.*sqrt(T(x));
%%%% %%%%% %%%%%
 x=-6:0.1:6;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% loop for plotting point by point....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 for i=1:length(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  DOMAIN v-u   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(2,1,1)
    hold on
     text(-1.1,0.8,'A','FontSize',40,'FontWeight','Bold')
    axis([-1.5 1.5 0 1.4])
    plot(v(x(1:i)),u(x(1:i)),'k-','LineWidth',4)
    xlabel('v','FontSize',30,'FontWeight','Bold')
    ylabel('u','FontSize',30,'FontWeight','Bold')
    box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  DOMAIN x-y   (y=T(x)) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(2,1,2) 
    hold on
    text(-4,0.7,'p(x)','FontSize',40,'FontWeight','Bold')
    axis([-6 6 0 1.2])
    plot(x(1:i),T(x(1:i)),'b-','LineWidth',4)
    xlabel('x','FontSize',30,'FontWeight','Bold')
    ylabel('y','FontSize',30,'FontWeight','Bold')
    box on
    pause(0.01)
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ')
Norm_Costant_of_T=1/sqrt(2*pi);
Z=1/Norm_Costant_of_T;
AREA_REGION_A=Z/2;
disp(['Area of the region A = ', num2str(AREA_REGION_A)])
disp(' ')
disp('-------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%