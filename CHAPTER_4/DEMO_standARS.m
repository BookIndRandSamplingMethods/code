%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% STANDARD ADAPTIVE REJECTION SAMPLER %%%%
%%%%%                                     %%%%
%%%----------------------------------------%%%
%%%  Required functions                    %%%
%%% - randsrc.m                            %%%
%%% - Sampling_Piece_Exp.m                 %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%% Graphical setting %%%%%%%%%%%%%%%%%%%%%%%%
h3=figure;
aux = get(0,'ScreenSize');
set(h3,'OuterPosition',[aux(1)+400,aux(2)+200,600,750])
x=-4:0.001:4; %%% for plotting
%%% initializing auxiliary counting variables %%%
count_accSam=0; %%%%  counting the number of accepted samples
count_iter=0;   %%%%  counting the number of iterations 
count_rejSam=0; %%%%  counting the number of rejected samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Target and -logTarget density      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Po=@(x) (1/sqrt(2*pi))*exp(-x.^2/2); %%% target
logP=@(x) x.^2/2; %%% -log Unormalized Target p(x)=exp(-x.^2/2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INITIAL SET OF SUPPORT POINTS %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
so=[-2 0.4]; %%%% initial support points
s=so;
s=sort(s); %%% sorting in ascending order
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=500; %%% total number of desired samples
disp(' ')
disp('---------------------------------------------------------------------------------------------')
disp(' ')
disp(' Stardard ADAPTIVE REJECTION SAMPLER (ARS)')
disp([' Number of desired samples =',num2str(N)])
disp(' The code is slowed down in order to allow a suitable graphical representation ')
disp(' ')
disp('---------------------------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
accepted_samples=[]; %%%% vector of accepted samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% First plot %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   subplot(2,1,1)
     cla
     plot(x,logP(x),'b','linewidth',3)
     axis([-4 4 -1 8])
     subplot(2,1,1)
     hold on
     plot(s,logP(s),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10)
     set(gca,'fontWeight','Bold')
     set(gca,'fontSize',17)
     title('Potential function V(x)','FontWeight','Bold') 
     xlabel('x','FontWeight','Bold') 
     text(-2,5,'V(x)=-log[p(x)]=x^2/2','FontSize',16,'FontWeight','Bold')
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    subplot(2,1,2)
    cla
    plot(x,Po(x),'b','linewidth',3)
    axis([-4 4 0 0.6])
    hold on
    plot(s,(1/sqrt(2*pi))*exp(-logP(s)),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10)
    set(gca,'fontWeight','Bold')
     set(gca,'fontSize',17)
    title('Target (p_o(x)) and proposal (\pi(x)) pdfs','FontWeight','Bold') 
    xlabel('x','FontWeight','Bold')   
     text(-0.3,0.3,'p_o(x)','FontSize',17,'FontWeight','Bold')
     text(1,0.4,'\pi(x)','FontSize',17,'FontWeight','Bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%% First derivative %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
m_der=s;
b_der=logP(s)-m_der.*s;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% compute Line-line intersection in log-domain
 xint=(b_der(1:end-1)-b_der(2:end))./(m_der(2:end)-m_der(1:end-1));      
%%%%%%%%%%%% plot lines and exponential pieces %%%%
for i=1:length(s)
    if i==1
     x1=-4:0.001:xint(i);
    elseif i==length(s)
     x1=xint(i-1):0.001:4;
    else
     x1=xint(i-1):0.001:xint(i);
    end
    subplot(2,1,1)
    plot(x1,m_der(i)*x1+b_der(i),'r','linewidth',1.1)
    subplot(2,1,2)
    plot(x1,(1/sqrt(2*pi))*exp(-(m_der(i)*x1+b_der(i))),'r','linewidth',1.1)
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(' press a key ')
pause %%%%% press a key in order to start
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% START - MAIN LOOP       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while count_accSam<N   %%%% waiting for accepting N samples 
  %%%% count iterations 
  count_iter= count_iter+1;  
   
 %%%%% plot log-function and points %%%%
    subplot(2,1,1)
     cla
     x=-4:0.001:4;
     plot(x,logP(x),'b','linewidth',3)
     axis([-4 4 -1 8])
     subplot(2,1,1)
     hold on
     plot(s,logP(s),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10)
     set(gca,'fontWeight','Bold')
     set(gca,'fontSize',17)
     title('Potential function V(x)','FontWeight','Bold') 
     xlabel('x','FontWeight','Bold') 
      text(-2,5,'V(x)=-log[p(x)]=x^2/2','FontSize',16,'FontWeight','Bold')
    %%%%% plot function and points %%%%
    subplot(2,1,2)
    cla
    x=-4:0.001:4;
    plot(x,Po(x),'b','linewidth',3)
    axis([-4 4 0 0.6])
    hold on
    plot(s,Po(s),'o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',10)
     set(gca,'fontWeight','Bold')
     set(gca,'fontSize',17)
    title('Normalized target (p_o(x)) and proposal (\pi(x)) pdfs','FontWeight','Bold') 
    xlabel('x','FontWeight','Bold') 
      text(-0.3,0.3,'p_o(x)','FontSize',17,'FontWeight','Bold')
     text(1,0.4,'\pi(x)','FontSize',17,'FontWeight','Bold')
%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%%% derivative %%%%%
m_der=s;
b_der=logP(s)-m_der.*s;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% compute Line-line intersection in log-domain
 xint=(b_der(1:end-1)-b_der(2:end))./(m_der(2:end)-m_der(1:end-1));      
%%%%%%%%%%%% plot lines and exponential pieces %%%%
for i=1:length(s)
    if i==1
     x1=-4:0.001:xint(i);
    elseif i==length(s)
     x1=xint(i-1):0.001:4;
    else
     x1=xint(i-1):0.001:xint(i);
    end
    subplot(2,1,1)
    plot(x1,m_der(i)*x1+b_der(i),'r','linewidth',1.1)
    subplot(2,1,2)
    plot(x1,(1/sqrt(2*pi))*exp(-(m_der(i)*x1+b_der(i))),'r','linewidth',1.1)   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% SAMPLING FROM THE PROPOSAL PDF
%%% FORMED BY EXPONENTIAL PIECES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% COMPUTING AREAS BELOW EACH EXPONENTIAL PIECES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Xint_ext=[-Inf xint +Inf];
     for i=1:length(Xint_ext)-1
      AREA(i)=-(1/m_der(i))*exp(-(m_der(i)*Xint_ext(i+1)+b_der(i)))...
          +(1/m_der(i))*exp(-(m_der(i)*Xint_ext(i)+b_der(i)));
     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
%%%%% normalized weights %%%%%%
    wn=AREA/sum(AREA);
%%%%% select an exponential piece     
    pos=randsrc(1,1,[1:length(wn);wn]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% DRAWING A SAMPLE FROM THE SELECTED EXPONENTIAL PIECE  
Proposed_Sample=Sampling_Piece_Exp(m_der(pos),b_der(pos),Xint_ext(pos),Xint_ext(pos+1),1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Evaluate_Target=Po(Proposed_Sample);
    Evaluate_Proposal=(1/sqrt(2*pi))*exp(-m_der(pos)*Proposed_Sample-b_der(pos));
 %%%%% probability of accepting the proposed sample  
    Pr_accept(count_iter)=Evaluate_Target/Evaluate_Proposal;
    U=rand(1,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%% Accept-Reject TEST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    if U<=Pr_accept(count_iter)
        accepted_samples(end+1)=Proposed_Sample; %%% 
        count_accSam=count_accSam+1; 
        disp(['accepted; number ',num2str(count_accSam),' over ',num2str(N)])
       else
       s=[s Proposed_Sample]; %%%% add the rejected sample to the set of support points
       s=sort(s);
       count_rejSam=count_rejSam+1;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% display test result %%%%%%
     pause(0.001)
     if U>Pr_accept(count_iter)     
        disp('sample x = ')
         disp(Proposed_Sample)
        disp(' rejected')
        subplot(2,1,1)
        plot([Proposed_Sample Proposed_Sample],[-1 8],'k--','linewidth',2)
        subplot(2,1,2)
        plot([Proposed_Sample Proposed_Sample],[0 0.6],'k--','linewidth',2)
       if count_rejSam<=4  
          disp('press a key')
           pause
       else
           pause(0.001)
       end
     end
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
  %%%%% plot normalized Histogram of the accepted samples 
  %%%%% for comparing with Po(x)
    if isempty(accepted_samples)==0 
        subplot(2,1,2)
        [v,c]=hist(accepted_samples,15);
           aux_diff=abs(c(2)-c(1));
        const=sum(aux_diff*v);
        bar(c,v/const,'g')
        x=-4:0.001:4;   
         plot(x,Po(x),'b','linewidth',3)
        pause(0.001) %%% slowing down the code
    end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
end %%%end main while
%%% accepted_samples= contains the accepted samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
disp(' ')
disp(' ')
disp('---------------------------------------------------------------------------------------------')
disp('FINAL REPORT')
disp('---------------------------------------------------------------------------------------------')
disp(['Total number of iterations T = ',num2str(count_iter)])
disp(['Number of desired (accepted) samples N = ',num2str(N)])
disp(['Final number of rejected samples = ',num2str(count_rejSam)])
disp(['Initial number of support points = ',num2str(length(so))])
disp(['Final number of support points = ',num2str(length(s))])
disp('---------------------------------------------------------------------------------------------')
disp(['Acceptance Rate obtained at this run = N/T = ',num2str(N/count_iter)])
disp('---------------------------------------------------------------------------------------------')
disp(['Averaged of the acceptance probabilities obtained at this run = ',num2str(mean(Pr_accept))])
disp('---------------------------------------------------------------------------------------------')

