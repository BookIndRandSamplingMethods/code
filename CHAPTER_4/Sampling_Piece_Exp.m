function [sample,fm]=Sampling_Piece_Exp(m,b,x1,x2,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SAMPLING TRUNCATED EXPONENTIAL 
%%%%% po(x)\propto exp(-m*x-b), x\in [x1,x2],  x2>x1
%%%%% by Vertical Density Representation (VDR) 
%%%%% or Inverse-f-Density method  (IoD)
%%%%% (they coincide in this case)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if m==0 %%%% uniform pdf

    if x2>=x1 
     sample=x1+(x2-x1)*rand(1,N);
     fm=b;
    else
        disp('x2 should be greater x1')
    end
    
else %%%% truncated exponential pdf
    
    MINI=min([exp(-m*x1-b),exp(-m*x2-b)]);
    MAXI=max([exp(-m*x1-b),exp(-m*x2-b)]);
y=MINI+(MAXI-MINI)*rand(1,N); %%% the Vertical Density in Uniform in [MINI,MAXI]
%%%%%%
sample=-(log(y)+b)/m; %%%% inverting y=exp(-m*x-b).
%%%%%%
fm=exp(-m*sample-b); %%%% value of p(x) at sample (do not strictly needed)
end

