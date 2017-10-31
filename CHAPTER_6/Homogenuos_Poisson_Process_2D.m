%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Bidimensional Homogenous Poisson process                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp(' ')
disp('-------------------------------------------------------------------')
disp('Bidimensional Homogenous Poisson process ')
disp(' ')
disp('Homogenous: Lambda(x)=Lambda (Constant) ')
disp(' ')
disp('-------------------------------------------------------------------')
disp(' ')
%%%%%%%
disp('In this example,we consider the set D=[0,1]x[0,1] ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Lambda=20;
disp(['We set Lambda = ',num2str(Lambda)])
disp(' ')
disp('-------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = poissrnd(Lambda);  %%%% number of points in this realization from a Poisson pmf
disp(' ')
disp('(a) Draw the Number of points M from Poisson(Lambda)   ')
disp(['Number of points in this realization = ', num2str(M)])
disp(' ')
x = rand(M,2);
disp(['(b) Draw M = ',num2str(M), ' within the set D=[0,1]x[0,1]'])
disp('-------------------------------------------------------------------')
%%%%%
disp(' ')
disp('Output of this realization of the Poisson Process:')
disp(x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plotting
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
hold on
plot(x(:,1),x(:,2),'r.','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',22)
axis([-0.2 1.2 -0.2 1.2]) 
set(gca,'FontSize',30)
 set(gca,'FontWeight','Bold')
 box on 
plot([0 0],[0 1],'k-','LineWidth',2)
plot([1 1],[0 1],'k-','LineWidth',2)
plot([0 1],[1 1],'k-','LineWidth',2)
plot([0 1],[0 0],'k-','LineWidth',2)
%%%%
Text_Number_of_points=cat(2,'m=',num2str(M));
text(0.4,1.1,Text_Number_of_points,'FontWeight','Bold','FontSize',30)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



 
