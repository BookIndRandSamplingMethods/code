%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DRAWING N_samples SAMPLES for a Gamma PDF restricted in [0,1],
%%%% via Rejection Sampling  (BUTCHER's VERSION)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%%%%
N_samples=20000; %%%% number of desired samples 
disp('-------------------------------------------------------------------------------------------')
disp(['DRAWING N_samples = ',num2str(N_samples),' SAMPLES for a Gamma PDF restricted in [0,1]'])
disp('via BUTCHER Rejection Sampling')
disp('-------------------------------------------------------------------------------------------')
disp(' ')
%%%%
a=0.6; %%%% a>0 
%%%%%%
disp('-------------------------------------------------------------------------------------------')
disp(' ')
disp('TARGET PDF x^(a-1)*exp(-x) with x \in [0,1]')
disp(['with a = ',num2str(a)])
disp('-------------------------------------------------------------------------------------------')
disp(' ')
Tar=@(x) x.^(a-1).*exp(-x);
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% START             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
x=[]; %%% vector of accepted samples 
count_acc_samples=0; %%% counting samples iterations 
t=0; %%% counting total iterations 
%%%%%%
while count_acc_samples<N_samples 
   t=t+1; 
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   %%%% DRAWING A SAMPLE FROM a*x^(a-1) 
   u1=rand(1,1);
   x_pr=u1^(1/a);
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%% BUTCHER's RS TEST %%%%%%%%%%%%%
   u2=rand(1,1);
   if u2<=exp(-x_pr)
       x(count_acc_samples+1)=x_pr;
       count_acc_samples=count_acc_samples+1;
   end
end %%%% END MAIN LOOP (WHILE)
%%%%%%%%%
AR=count_acc_samples/t; %%% Acceptance Rate in this run
disp(['Acceptance Rate in this run : ',num2str(AR)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% POSSIBLE PLOT
plotyes=1;
if plotyes==1
    close all
    hold on
    [e,b]=hist(x,30);
    Zbar=sum(e*(b(2)-b(1)));
    hold on
    set(gca,'FontWeight','Bold','FontSize',20)
    box on
    bar(b,1/Zbar*e)
    step1=0.001;
    x1=0.01:step1:1;
    Z=sum(Tar(x1)*step1);
    plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
    legend('Hist. of generated samples','TARGET pdf')
    axis([0 1 0 max(1/Zbar*e)+2])
    title('BUTCHER Rejection Sampling')
end


