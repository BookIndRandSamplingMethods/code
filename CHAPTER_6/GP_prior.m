%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% GP PRIOR    %%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Random Functions from the GP prior  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp('---------------------------------------------')
disp(' Random Functions from a GP prior  ')
disp('---------------------------------------------')
disp('------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% KERNEL FUNCTIONS %%%%
disp(' ')
disp(' KERNEL FUNCTIONS ')
disp(' ')
disp('1. Linear Function')
disp('2. Squared Exponential Function - RBF')
disp('3. Laplace-Double Exponential Function ')
disp('4. Rational Quadratic Function ')
disp('5. Kernel Function for generating a Wiener process ')
disp('6. Dot Product Function - Polynomial ')
disp('7. Periodic Function ')
disp('8. Kernel Function for generating a Standard Brownian Bridge')
disp('------------------------------------------------------------------------')
disp(' ')
typeKernel=input(' Choose a kernel function (1-8) ? ' );
disp(' ')
switch typeKernel
    case 1
         %%%% linear 
         t=-5:0.2:5; %%%% inputs
         k=@(z1,z2) z1*z2;
    case 2
         %%%% Squared Exponential - RBF 
         t=-5:0.2:5; %%%% inputs
         sig=1;
         k=@(z1,z2) exp(-(z1-z2).^2/(2*sig^2));
      case 3
        %%%% Laplace-Double Exponential (Ornstein-Uhlenbeck Process)
        t=-5:0.2:5; %%%% inputs 
        Lambda=1;
        k=@(z1,z2) exp(-Lambda*abs(z1-z2));
      case 4
        %%%%  Rational Quadratic Function
        t=-5:0.2:5; %%%% inputs
        sig=1;
        a=input('Choose the parameter a >0 ? (for a==> Infinity, it approximates the Squared Exponential Function) ');
        k=@(z1,z2) (1+(abs(z1-z2).^2)/(2*a*sig^2)).^(-a);
      case 5
        %%%% for Wiener process
        t=0:0.2:5; %%%% inputs  
        k=@(z1,z2) min([z1,z2]); 
       case 6
         %%%% Dot Product Function
        t=-5:0.2:5; %%%% inputs  
        sigma0=4;
        disp(['The parameter sigma0 is set to ',num2str(sigma0)])
        n=input('Choose the other positive integer n>0 (e.g., n=1,2,3,4,..) ? ');
        k=@(z1,z2) min(sigma0+ z1*z2').^n;
       case 7
         %%%% 
         t=-5:0.2:5; %%%% inputs
         sig=5;
         k=@(z1,z2) exp(-[2*sin(1*(z1-z2))].^2/(sig^2));
       case 8
         %%%% 
         t=0:0.01:1; %%%% inputs
         sig=5;
         k=@(z1,z2) min([z1,z2])-z1*z2;          
      end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%% COVARIANCE MATRIX given the inputs %%%%%%%%%%
 for i=1:length(t)
     for j=1:length(t)
        SIGMA(i,j)=k(t(i),t(j));
     end
 end
%%%%%%%%%%%%%%%%%%%
NUM_CURVES=20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DRAW NUM_CURVES TIMES FORM A N(0,SIGMA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L=length(t);
small_constant=0.000001;%%%  only for avoiding numerical issues
B=chol(SIGMA+small_constant*eye(L,L)); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:NUM_CURVES
f(i,:)=B'*randn(1,L)';
end
%%%%%% plot %%%%%%%%
figure
hold on
plot(t,f,'LineWidth',4)
if typeKernel==5
   axis([0 5 -4 4])
elseif typeKernel==6
    axis([0 5 -6 6])
elseif typeKernel==8
    axis([0 1 -2 2])
else
   axis([-5 5 -3.5 3.5]) 
end
box on
set(gca,'FontSize',30)
set(gca,'FontWeight','Bold')
ylabel('f(t)')
xlabel('t')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

