function x=IA2RMS(f,S,M,type)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Independent Adaptive^2 Rejection Metropolis Sampling (IA2RMS)
% f = target density (known up to the normalisation constant)
% for example, f = @(x) exp( -x.^2/2).*(1+(sin(3*x)).^2).*(1+(cos(5*x).^2));
% S=	initial support points (at least 2, use more to avoid numerical problems) 
% M=	number of samples we required
% type= 0/1 construction proposal 
% (for heavy tailed target pdf, it is better to change the construction of the tails)
% Example with one tail:
%%>> f = @(x) exp(-x).* (x > 0); 
%%>> S=[-1 0 1]; 
%%>> x=A2RMS(f,S,1000,0); 
% For showing results (autocorrelation etc.): showRes=1;
% For showing some interesting plot: showPlot=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot results and plot (1) or not (0)
showRes=0;
showPlot=0;

%a Make sure at least one point s' gives the target f(s')>0
% ( just to avoid numerical problems )
% we need at least one support point that is not in the tails
f=@(x)10^7*f(x);
S = checkInitPoints(f,S);
if isempty(S)==1
    disp('There is a problem with your initial support points, please choose others.')
    x = [];
    return
end


% Always sort support points
S = sort(S);

% Variables
x = zeros(1,M);
if isempty(find(S==0))==0  
x(1)=0.1;
end

   

alpha_before=1;
count=0;
k=2;
NewP_Yes=1;

while k<=M 
    
    if NewP_Yes==1
	% BUILD PROPOSAL from a set of support points S
    [m,b,w] = build_proposal(f,S,k-1,type);
    end
    NewP_Yes=0;
    
	% SAMPLING AND EVALUATE POPOSAL: draw x'from and evaluate the proposal
    [x_prop,fp_now]=Sample_Eval_Proposal(f,m,b,S,type,w);
    
	
     if count==0
         % EVALUATE x' first time
        fp_prev=eval_proposal(x(k-1),m,b,S,type);
        ft_prev= f(x(k-1));
     end
    %fp_now=eval_proposal(x_prop,m,b,S,type);
     % EVALUATE x'
    ft_now= f(x_prop);
    
    u=rand(1,1);
    
    alpha1=ft_now/fp_now;
    
	if u > alpha1  %%%% RS test
		% reject step 1
		S=[S x_prop];
        S=sort(S);
        count=count+1;
        NewP_Yes=1;
	else
		% accept
		q_prev=min([ft_prev, fp_prev]);
		q_now=min([ft_now, fp_now]);
		rho=(ft_now*q_prev)/(ft_prev*q_now);
		alpha2=min([1,rho]);
		u2=rand(1,1);
        
		if u2<=alpha2 %%%% MH test
            % accept
			x(k) = x_prop;
            y_aux=x(k-1);
            %%%%%%%%
            %%%%%%%%
              alpha3=1/alpha_before;
            %%%%%%%%
            %%%%%%%%
            fp_prev=fp_now;
            ft_prev=ft_now;
            
        else
            % reject MH test
			x(k) = x(k-1);
            y_aux=x_prop;
            %%%%%%%%
            %%%%%%%%
            alpha3=1/alpha1;
            %%%%%%%%
            %%%%%%%%          
        end
        
   %%%% second control of IA2RMS
    alpha_before=alpha1;	
    u3=rand(1,1);
	if u3> alpha3 & k~=M %%%% second condition just for plotting
			S=[S y_aux];
			S=sort(S);
            NewP_Yes=1;
	end

		k=k+1;
		count=count+1;
    end
end


%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
% RESULTS
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
if showRes==1
	% Output stats
	fprintf ('total number of iterations: %i\n', count)
	fprintf ('number of final support points: %i\n', length(S))
	fprintf ('linear correlation x(t),x(t+1): %f\n', sum((x(1:end-1)-mean(x)).*(x(2:end)-mean(x)))/sum((x-mean(x)).^2))
    fprintf ('linear correlation x(t),x(t+10): %f\n', sum((x(1:end-10)-mean(x)).*(x(11:end)-mean(x)))/sum((x-mean(x)).^2))
    fprintf ('linear correlation x(t),x(t+50): %f\n', sum((x(1:end-50)-mean(x)).*(x(51:end)-mean(x)))/sum((x-mean(x)).^2))
end

if showPlot==1
	% Show plots
	figure

	[bb,c]=hist(x,30);

	D=sum(bb.*(c(2)-c(1)));
	bar(c,bb*(1/D),'r')
	hold on

	%x1=-5:0.01:5;
     x1=min(x)-7:0.01:max(x)+7;
    
	fx1 = f(x1);
	fx2 = zeros(length(x1),1);
	for j=1:length(x1)
		fx2(j)=eval_proposal(x1(j),m,b,S,type);
	end
	D2=sum(0.01*fx1);

	plot(x1,(1/D2)*fx1,'b','LineWidth',3)
	D3=sum(0.01*fx2);
	plot(x1,(1/D3)*fx2,'g','LineWidth',3)
end