%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Non-Homogenous Poisson process - 1D                                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp(' ')
disp('------------------------------------------------------------------------------------')
disp(' ')
disp('Non-Homogenous Poisson process - 1D ')
disp(' ')
disp('------------------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 40; %%%% Poisson Process within [0,T]
disp(' ')
disp(['- We consider a Poisson Process within [0,T]=[0,',num2str(T),']'])
Lambda=@(t) sin(t).^2;
disp(['- Intensity parameter Lambda(t) = sin(t)^2'])
UpperBound_Lambda=1;
disp('- UpperBound_Lambda >= Lambda(t) ')
disp(' ')
disp(' (the code is slowing down) ')
disp('------------------------------------------------------------------------------------')
t_aux = 0; 
n = 1;
t(1) =0;
count_iter=0; %%% counting iterations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% preparing plot window
hFig=figure;
set(hFig, 'Position', [200 200 1000 1000])
%%%%%
subplot(2,1,2)
z=0:0.01:T;
plot(z,Lambda(z),'Linewidth',2)
hold on
axis([0 T 0 1.2])
plot([0 T],[UpperBound_Lambda UpperBound_Lambda],'r--','Linewidth',2)
set(gca,'FontSize',30)
set(gca,'FontWeight','Bold')
ylabel('Lambda(t)')
xlabel('t')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% STARTING %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while t_aux < T
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
% Holding times DELTA are exponentially-distributed with parameter Lambda 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
count_iter=count_iter+1;
u1=rand(1,1); %%%% one realization of a uniform random variable
DELTA_possibly_or_more(count_iter)=- 1/(UpperBound_Lambda)*log(u1);
%%%%
t_aux = t_aux+DELTA_possibly_or_more(count_iter); 
%%%% accept-reject using the UpperBound_Lambda
u2=UpperBound_Lambda*rand(1,1);
    if u2 < Lambda(t_aux) %%% RS test
        t(n+1)=t_aux;
        n = n+1; 
    %%%%%%%%%%%%%%%%%%%%%%%%
    %%% plots
    subplot(2,1,2)
    plot(t_aux,u2,'go','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10)
    %%%%%%%%%%%%%%%%%%%%%%%% 
        Number_of_points = 0:n;
        %%%%
        for i =1:n-1
            subplot(2,1,1)
            hold on
            plot([t(i),t(i+1)],[Number_of_points(i) ,Number_of_points(i)],'Linewidth',2);
        end
            axis([0 T 0 max([25,Number_of_points(end)])])
            set(gca,'FontSize',30)
            set(gca,'FontWeight','Bold')
            ylabel('N_t')
            xlabel('t')
            box on 
            pause(0.1) %%%% slowing down
    else %%% just for plotting
        subplot(2,1,2)
        plot(t_aux,u2,'ro','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10)
         pause(0.1)    %%%% slowing down
    end %% end RS test
   %%%%
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Show Results
disp(' ')
disp(['Number of points in this realization = ',num2str(Number_of_points(end))])
disp(' ')
disp(['Total number of iterations = ',num2str(count_iter)])

disp(' ')
disp('Output of this realization of the Poisson Process:')
disp(' ')
disp(t(2:end))
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 





