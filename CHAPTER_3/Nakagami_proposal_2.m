function x=Nakagami_proposal_2(m,K,N_samples)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Sampling NAKAGAMI-m pdf with m integer or  half-integer           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% GENERAL CONSTRAINS OF THE PARAMETERS %%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% m>=0.5
  %%% K>0
  %%%%% specific constrains for this transformation
  %%% m must be integer or half-integer
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %   N_samples %%% number of desired samples 
  %%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% TRANSFORMATION REPEAT N_samples TIMES %%%% 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for i=1:N_samples
     z=randn(1,2*m);
     rho=[K/(2*m)]*sum(z.^2);
     x(i)=sqrt(rho);
  end
  
   
    
    