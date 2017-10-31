%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Realization of a Markov jump process (MJP)  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp('------------------------------------------------------')
disp(' Realization of a Markov jump process (MJP) ')
disp('      of five states, Xt={1,2,3,4,5} ')
disp('------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% MARKOV PROCESS WITH FIVE STATES 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
par1= 1;  %%%% 0<= par1 <= Inf 
par2= 1;  %%%% 0<= par2 <= Inf 
par3= 1;  %%%% 0<= par3 <= Inf 
par4= 1;  %%%% 0<= par4 <= Inf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% A timehomogenous MJP is usually defined
%%% using the so-called Q-matrix
disp(' Q-matrix = ')
Q = [-(par1 + par2), par1, par2, 0, 0;
par3, -(par3+ par2), 0, par2, 0;
par4, 0, -(par4 + par1), 0, par1;
0, 0, par3, -par3, 0 ;
0, par4, 0, 0, -par4];
%%%%%%%
disp(Q)
disp('The sum of the coefficients in a row of Q must zero,')
disp('as shown below ')
sum(Q')
disp('------------------------------------------------------')
%%%%%%%%% %%%%%%%%% %%%%%%%%% %%%%%%%%% %%%%%%%%% %%%%%%%%%
q = -diag(Q);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The transition matrix K induced by the Q-matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' The transition matrix K induced by the Q-matrix, ')
K = diag(1./q)*Q+eye(5)
disp('------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 20; %%%% total time window
number_jumps=1; %%% aux variable for counting the number of jumps
t = 0; 
Zn_currentState = 1; %%%% starting state = 1 
jumps_instants = [t];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% STARTING MAIN LOOP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while t < T
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% sampling a exponential pdf via inversion method with parameter q(y)
    u1=rand(1,1);
    delta_time_In_A_State = - log(u1)/q(Zn_currentState(number_jumps));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% sampling a new state according to K
    Zn_currentState(number_jumps+1)=randsrc(1,1,[1 2 3 4 5; K(Zn_currentState(number_jumps),:)]);
    %%% alternative way below (in order to avoid the use of randsrc)
    %u2=rand(1,1);
    %Zn_currentState(number_jumps+1) = min(find(cumsum(K(Zn_currentState(number_jumps),:))>u2));
    %%%
    number_jumps= number_jumps+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    t = t + delta_time_In_A_State;
    jumps_instants = [jumps_instants,t];   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' press a key ')
pause 
disp('   ')
disp(['TOTAL NUMBER OF JUMPS IN THIS REALIZATION = ',num2str(number_jumps-1)])
disp('   ')
disp(['Sequence of states = ',num2str(Zn_currentState)])
disp('   ')
disp(['Jump Instants = ',num2str(jumps_instants(2:end))])
%disp(jumps_instants(2:end))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot realization
figure
hold on
%%%%%%
for i=1:number_jumps-1
 plot([jumps_instants(i),jumps_instants(i+1)], [Zn_currentState(i),Zn_currentState(i)],'r','Linewidth',2);
 plot([jumps_instants(i+1),jumps_instants(i+1)],[Zn_currentState(i),Zn_currentState(i+1)],'r','Linewidth',2);
end
%%%%%%
axis([0 T 0.5 5.5])
set(gca,'FontSize',25)
 set(gca,'FontWeight','Bold')
 box on 
 ylabel('X_t')
 xlabel('t')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 