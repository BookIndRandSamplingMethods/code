clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MAIN script for ARS and CARS
%%% for drawing from a GAUSSIAN pdf   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_initial=10; %%%% number of intial support point
N_desired_samples=50000; %%% desired number of samples
%%%%%%%%%%
type_alg=2; %%%% 1 - CARS ; 2- Classical ARS
%%%%%%%%%%
switch type_alg
    case 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Cheap ARS (CARS)                %%%
%%% ARS with fixed number of nodes  %%%
%%% here N_nodes=N_initial+2        %%%
%%%% with GAUSSIAN TARGET           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% In this code, N_nodes-2 support points are chosen randomly at the beginning  
%%%% but they can chosen by the user
help CARS_Gaussian 
[x,time,AR,NP]=CARS_Gaussian(N_initial,N_desired_samples);
    case 2
 %%%%%%%%%%%%%%%%%%%%%%%%%       
 %%% STANDARD ARS  %%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%
 help ARS_Gaussian 
[x,time,AR,NP]=ARS_Gaussian(N_initial,N_desired_samples);   
end 
%%%%%%%%%%%%%%
disp(' ')
disp(['Spent Time (sec) in this run : ',num2str(time)])
disp(['Acceptance Rate in this run : ',num2str(AR)])
disp(['Final number of nodes in this run : ',num2str(NP)])
disp(' ')
    