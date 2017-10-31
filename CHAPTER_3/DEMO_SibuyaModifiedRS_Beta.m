clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DRAWING N_samples SAMPLES for a Gamma PDF restricted in [0,1],
%%%% via Rejection Sampling  (VADUVA's VERSION)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_samples=200; %%%% number of desired samples 
disp('-------------------------------------------------------------------------------------------')
disp(['DRAWING N_samples = ',num2str(N_samples),' SAMPLES for a BETA PDF, x\in [0,1]'])
disp('by Sibuya modified Rejection Sampling')
disp('-------------------------------------------------------------------------------------------')
disp(' ')
%%%%
a=2;   %%%%  a>0 
b=5;   %%%%  b>0 
%%%%%%
disp('-------------------------------------------------------------------------------------------')
disp(' ')
disp('TARGET PDF x^(a-1)*(1-x)^(b-1) with a=2, b=5 and x \in [0,1]')
%disp(['with a = ',num2str(a)])
%disp(['with b = ',num2str(b)])
disp('-------------------------------------------------------------------------------------------')
disp(' ')
Tar=@(x) x.^(a-1).*(1-x).^(b-1);
mode_pos=(a-1)/(a+b-2);
L_opt=Tar(mode_pos);
%%%%%%%%%%% %%%%%%%%%%% %%%%%%%%%%% %%%%%%%%%%%  %%%%%%%%%%% %%%%%%%%%%% %%  
%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% START             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%
x=[]; %%% vector of accepted samples 
count_acc_samples=0; %%% counting samples iterations 
t=0; %%% counting total iterations 
%%%%%%
while count_acc_samples<N_samples 
   %%% for RS testing
   Y_pr=L_opt*rand(1,1);
   %%%%%%%%%%%%%%%%%%%%
   rejected_before=1;
   %%%% Sibuya's inner loop
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   while rejected_before==1 
    t=t+1;    
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
   %%%% DRAWING A SAMPLE FROM the proposal pdf  U([0,1])
    x_pr=rand(1,1);
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %%%%%%  RS TEST          %%%%%%%%%%%%%
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       if Y_pr<=Tar(x_pr)
           disp(' ')
           disp('accepted')
           disp(' then change green horizontal dashed line ')
           disp(' ')
           x(count_acc_samples+1)=x_pr;
           count_acc_samples=count_acc_samples+1;
           rejected_before=0;
       else
           disp('rejected - then draw other possible candidate x_pr')
           disp(' i.e., change blac vertical dashed line')
       end
       %%%%% JUST FOR PLOTTING
            cla
            x1=0.001:0.01:1;
            plot(x1,Tar(x1),'r','LineWidth',2)
            hold on
            legend('Target pdf')
            plot([0 1],[L_opt L_opt],'b-','LineWidth',2)
            set(gca,'FontWeight','Bold','FontSize',20)
            plot([x_pr x_pr],[0 L_opt],'k--','LineWidth',2)
            plot([0 1],[Y_pr Y_pr],'g--','LineWidth',2)
            if rejected_before==1
              plot([x_pr],[Y_pr],'ro','MarkerEdgeColor','k',...
                       'MarkerFaceColor','r',...
                       'MarkerSize',10)
            else
              plot([x_pr],[Y_pr],'go','MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',10)   
            end
            box on  
            title('Sibuya RS - Demo')
            pause(0.5)
   end%%%% end Sibuya's inner loop
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
end %%%% END MAIN LOOP (WHILE)
%%%%%%%%%
AR=count_acc_samples/t; %%% Acceptance Rate in this run
disp(['Acceptance Rate in this run : ',num2str(AR)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% POSSIBLE PLOT
plotyes=1;
if plotyes==1
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
    x1=0.01:step1:1;
    Z=sum(Tar(x1)*step1);
    plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
    legend('Hist. of generated samples','TARGET pdf')
    axis([0 1 0 max(1/Zbar*e)+2])
    title('Sibuya modified Rejection Sampling')
end


