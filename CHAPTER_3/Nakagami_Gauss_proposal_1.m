function x=Nakagami_Gauss_proposal_1(m,mode_pos,N_samples)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Gauss proposal pdf for sampling from Nakagam by RS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sig=sqrt(1/(2*m));
x=mode_pos+sig*randn(1,N_samples);
    

  
   
    
    