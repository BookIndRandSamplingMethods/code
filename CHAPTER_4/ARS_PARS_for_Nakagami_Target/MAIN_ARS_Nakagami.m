clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MAIN script for Standard ARS and PARSIMONIOUS ARS (PARS)
%%% for drawing from Nakagami pdf   
%%% SEE
%%% L. Martino, Parsimonious Adaptive Rejection Sampling, 
%%% Technical Repport vixra:1705.0093, 2017.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_samples=50000; %%% desired number of samples
%%%%%%%%%%
type_alg=1; %%%% 1 - PARS ; 2- Classical ARS
%%%%%%%%%%
switch type_alg
    case 1
      help PARS_nakagami 
      Delta=0.8;
      [x_samples,time,AR,NP]=PARS_nakagami(N_samples,Delta);
    case 2
      help ARS_nakagami 
      [x_samples,time,AR,NP]=ARS_nakagami(N_samples);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' ')
disp(['Spent Time (sec) in this run : ',num2str(time)])
disp(['Acceptance Rate in this run : ',num2str(AR)])
disp(['Final number of nodes in this run : ',num2str(NP)])
disp(' ')

