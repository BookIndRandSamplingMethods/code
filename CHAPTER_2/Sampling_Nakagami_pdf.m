%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  Sampling NAKAGAMI-m pdf with m integer or  half-integer           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
clear all
close all
clc
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% GENERAL CONSTRAINS OF THE PARAMETERS %%%%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% M>=0.5
  %%% K>0
  %%%%% specific constrains for this transformation
  %%% m must be integer or half-integer
  m=1.5; %%%%%% m: must be integer or half-integer and m>=0.5
  K=10; %% K>0
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
  disp('%% Sampling NAKAGAMI-m pdf with m integer or half-integer  %%')
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
  disp(' ')
  disp(['m = ',num2str(m)])
  disp(['K = ',num2str(K)])
  disp(' ')
  %%% 
  N_samples=20000; %%% number of desired samples 
  disp(['Generated Samples = ',num2str(N_samples)])
  %%%%
  Tar=@(x) x.^(2*m-1).*exp(-(m/K)*x.^2); %%%% Nakagami pdf
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%% TRANSFORMATION REPEAT N_samples TIMES %%%% 
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for i=1:N_samples
     z=randn(1,2*m);
     rho=[K/(2*m)]*sum(z.^2);
     x(i)=sqrt(rho);
  end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%% plot 
    close all
    figure
    hold on
    [e,b]=hist(x,30);
    Zbar=sum(e*(b(2)-b(1)));
    hold on
    set(gca,'FontWeight','Bold','FontSize',20)
    box on
    bar(b,1/Zbar*e)
    step1=0.001;
    x1=0.01:step1:10;
    Z=sum(Tar(x1)*step1);
    plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
    legend('Hist. of generated samples','TARGET pdf')
    axis([0 max(x1) 0 max(1/Zbar*e)+0.3])
    title('Nak. generator with m integer or half-integer')
   
    
    