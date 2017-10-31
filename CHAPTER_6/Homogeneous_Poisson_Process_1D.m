%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Homogenous Poisson process - 1D                                    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all 
close all
clc
disp(' ')
disp('------------------------------------------------------------------------------------')
disp(' ')
disp('Homogenous Poisson process - 1D - (Lambda(x)=Lambda)')
disp(' ')
disp('------------------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 40; %%%% Poisson Process within [0,T]
disp(' ')
disp(['In this example, we consider a Poisson Process within [0,T]=[0,',num2str(T),']'])
Lambda=0.4; %% intensity (or rate) parameter of the Poisson Process
disp(['Intensity parameter  Lambda = ',num2str(Lambda)])
disp(' ')
disp('------------------------------------------------------------------------------------')
Number_of_points=0;%%% conuting the number of points in this realization
t = 0; 
n = 1; 
check_variable=0; %%% aux variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% STARTING %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while check_variable < 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% Holding times DELTA are exponentially-distributed with parameter Lambda 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 u=rand(1,1); %%%% one realization of a uniform random variable
 DELTA(n) = - (1/Lambda)*log(u);% generating DELTA \sim Lambda*exp(Lambda*tau)
%%%%%%%
    t_aux = t(n) +DELTA(n);
%%%%%%%    
    if   t_aux<= T
       t(n+1)= t_aux;
       n = n+1;
       Number_of_points(n)=n-1;
    else %%% t_aux> T
        check_variable=1;
    end
end  %%% end while
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Show Results
disp(' ')
disp(['Number of points in this realization = ',num2str(Number_of_points(end))])
disp(' ')
disp('Output of this realization of the Poisson Process:')
disp(' ')
disp(t(2:end))
disp(' ')
disp('Corresponding Holding Times:')
disp(' ')
disp(DELTA(1:end-1))
%%%%%%%%
%%% plot
figure
 for i =1:Number_of_points(end)
     hold on
     plot([t(i),t(i+1)],[Number_of_points(i) ,Number_of_points(i)],'Linewidth',2);
 end
axis([0 T 0 Number_of_points(end)+1])
set(gca,'FontSize',30)
set(gca,'FontWeight','Bold')
ylabel('N_t')
xlabel('t')
box on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
