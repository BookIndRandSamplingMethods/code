%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%           Example of an                       %%
%%%% Ensemble MCMC with an independent proposal    %%
%%%%                                               %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(['%% Ensemble MCMC with an independent proposal pdf  %%'])
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Bimodal Target function %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Tar=@(x) exp(-(x.^2-4).^2/(8));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Proposal functio function %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu_p=0;  %%% parameter of the proposal
sig_p=3; %%% parameter of the proposal 
Prop=@(x) exp(-(x-mu_p).^2/(2*sig_p^2));  %%% proposal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Ask for the number of tries
N_tries=input('Select the number of tries (N>0) : ');
if N_tries<=0
    disp('Number of tries = 1')
    N_tries=1;
end
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=input('Number of MCMC iterations (T>=100) : ');
if T<=100
    disp('T = 100')
    T=100;%%% number of iterations of the MCMC chains
end
disp(' ')
%%%%%
cont_accepted_jumps=0; %%% aux variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%  starting point of the chain          %%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=0;
%%%%%%%%%%%%%%%%%
%%%% MAIN LOOP %%
%%%%%%%%%%%%%%%%%
for t=2:T+1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Generate N_tries candidates %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_c=mu_p+sig_p*randn(1,N_tries); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Add the previous state                %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_compl=[x_c x(t-1)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Compute IS weights                   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
w_compl=Tar(x_compl)./Prop(x_compl);
w_compl=w_compl+10^(-323); %%% avoiding computational issues
wn=w_compl/sum(w_compl);
%%%%%%%%%%%%%%%%%%%%%%%
%%% Pick one sample %%%
%%%%%%%%%%%%%%%%%%%%%%%
pos=randsrc(1,1,[1:N_tries+1; wn]);
x(t)=x_compl(:,pos);
%%%%%%%%%%%%%%%%%%%%%%%%%%
        if x(t)~=x(t-1)
            cont_accepted_jumps=cont_accepted_jumps+1;
        end
end %%%% END MAIN LOOP
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SHOWING some performance measures
aux=x-mean(x);
for i=1:20
  AutoCorr_lag(i)=sum(aux(1:end-i).*aux(i+1:end))/sum(aux(1:end).*aux(1:end));
end
RateJumps=cont_accepted_jumps./T;
disp('------------------------------------------------------ ')
disp(['Rate of jumps (acceptance rate) at this run : ',num2str(RateJumps)])
disp(' ')
disp(['AutoCorr at lag-1 at this run : ',num2str(AutoCorr_lag(1))])
disp(['AutoCorr at lag-2 at this run : ',num2str(AutoCorr_lag(2))])
disp(['AutoCorr at lag-10 at this run : ',num2str(AutoCorr_lag(10))])
disp('------------------------------------------------------ ')
%%%%%%%%%%%%%%%%
%%%%% plots %%%%
%%%%%%%%%%%%%%%%
   figure
    subplot(2,1,1)
    plot(x,'LineWidth',2)
    set(gca,'FontWeight','Bold','FontSize',20)
    axis([1 T+1 min(x)-0.5 max(x)+0.5])
    xlabel('t')
    title('Chain x(t)') 
    subplot(2,1,2)
    hold on
    [e,b]=hist(x,30);
    Zbar=sum(e*(b(2)-b(1)));
    hold on
    set(gca,'FontWeight','Bold','FontSize',20)
    box on
    bar(b,1/Zbar*e)
    step1=0.001;
    x1=-10:step1:10;
    Z=sum(Tar(x1)*step1);
    plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
    axis([-5 5 0 max(1/Zbar*e)+0.5])
    legend('Hist. chain','TARGET pdf')
    xlabel('x')  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%
   figure
   plot([0:20],[1 AutoCorr_lag],'b-','LineWidth',2)
   set(gca,'FontWeight','Bold','FontSize',20)
   title('Auto-correlation')
    xlabel('lag')  
    axis([0 20 min(AutoCorr_lag)-0.1 1])
