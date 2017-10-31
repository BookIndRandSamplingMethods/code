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
disp('-------------------------------------------------------------------')
disp(' ')
disp('Plotting boundary of the region A...')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (1) EQUATION OF THE CURVE: PARAMETRIC WAY 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 T=@(x) exp(-x.^2/2);
u=@(x) sqrt(T(x));
v=@(x) x.*sqrt(T(x));
 x=-10:0.1:10;
plot(v(x),u(x),'k','LineWidth',4)
axis([-1.5 1.5 0 1.4])
text(-1.05,0.8,'A','FontSize',40,'FontWeight','Bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% (2) EQUATION OF THE CURVE: TWO ANALYTIC PIECES  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
 u=0:0.01:1;
v1=u.*2.*(-log(u)).^(1/2); 
v2=-u.*2.*(-log(u)).^(1/2); 
plot(v1,u,'m:','LineWidth',4)
plot(v2,u,'m:','LineWidth',4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
xlabel('v','FontSize',30,'FontWeight','Bold')
ylabel('u','FontSize',30,'FontWeight','Bold')
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