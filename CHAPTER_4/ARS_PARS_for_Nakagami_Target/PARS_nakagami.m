function [x_samples,time,AR,NP]=PARS_nakagami(N_samples,Delta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PARSIMONIOUS ARS  (PARS)                           %%%
%%% sampling from a Nakagami pdf                       %%%
%%% SEE
%%% L. Martino, Parsimonious Adaptive Rejection Sampling, 
%%% Technical Repport vixra:1705.0093, 2017.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Constrains Nakagami parameters 
%a>=0.5
%r>0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=1.2;
r=2;

%%% log-Nakagami and its Derivative
V=@(x)(-(r/a)*x.^2+(2*r-1)*log(abs(x)))+log(double(x>=0));
D_v=@(x) ((2*r - 1)./x - (2*r.*x)/a)+log(double(x>=0));
%%%% Initial Set of Support Points
S=[0.5,1,2];
S=sort(S);
%%% initializing variables
x_samples=[];
count_acc_samples=0;
t=0; %%% count total iterations of the algorithm
%%%%%%%%%%%%%%%%%%%
%%%%% START %%%%%%%
%%%%%%%%%%%%%%%%%%%
tic
%%%% MAIN LOOP %%%%
 while count_acc_samples<=N_samples   
  %%%%%  
     t=t+1;
  %%% Find intersections between two lines    
   m=D_v(S);
   b=V(S)-m.*S; 
   for i=1:length(S)-1
      [xint(i),yint(i)]=Inter_between_2Lines(m(i),b(i),m(i+1),b(i+1));
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%%%%%% COMPUTE AREAS BELOW EXPONENTIAL PIECES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
S2=[0 xint +inf];
for i=1:length(S2)-1  
      AREA(i)=(1/m(i))*exp(m(i)*S2(i+1)+b(i))-(1/m(i))*exp(m(i)*S2(i)+b(i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%CHOOSING A PIECE
wn=AREA/sum(AREA);
chosen_piece=randsrc(1,1,[1:length(wn);wn]);
%%%% DRAWING A SAMPLES X_PR   
Ntot_pieces=length(S);       
if chosen_piece==Ntot_pieces+1
         y=exp(m(Ntot_pieces+1)*S2(Ntot_pieces+1)+b(Ntot_pieces+1))-exp(m(Ntot_pieces+1)*S2(Ntot_pieces+1)+b(Ntot_pieces+1))*rand(1,1);
        xpr=(log(y)-b(Ntot_pieces+1))/m(Ntot_pieces+1);
else
     y=exp(m(chosen_piece)*S2(chosen_piece)+b(chosen_piece))+(exp(m(chosen_piece)*S2(chosen_piece+1)+b(chosen_piece))-exp(m(chosen_piece)*S2(chosen_piece)+b(chosen_piece)))*rand(1,1);
     xpr=-(b(chosen_piece) - log(y))/m(chosen_piece);      
end
%%%% evaluating the target-Nakagami at xpr
eval_TAR=exp(V(xpr));
%%%% evaluating the proposal at xpr
eval_PROP=exp(m(chosen_piece)*xpr+b(chosen_piece));
%%%%%%%%%%%%%%%%%
%%%% RS TEST %%%%
%%%%%%%%%%%%%%%%%
 U=rand(1,1);
     if U<eval_TAR/eval_PROP %%% THEN ACCEPT xpr
        x_samples(end+1)=xpr;
        count_acc_samples=count_acc_samples+1;
     end
  %%%%% end acceptance test   
     
  %%%%% TEST for updating the proposal pdf
      if eval_TAR/eval_PROP<=Delta
         S=[S xpr];   
         S=sort(S);
      end
%%%%%%%%%%%%%%%%%%%%%     
 end %%%% end main loop
%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%% 
 time=toc; %%%% spent time 
%%%%%%
AR=count_acc_samples/t; %%% Acceptance Rate in this run
NP=length(S);  %%% Final number of point in this run
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% POSSIBLE PLOT
plotyes=1;
if plotyes==1
    close all
    hold on
    [e,b]=hist(x_samples);
    Zbar=sum(e*(b(2)-b(1)));
    hold on
    set(gca,'FontWeight','Bold','FontSize',20)
    box on
    bar(b,1/Zbar*e)
    step1=0.01;
    x1=0.01:step1:10;
    Z=sum(exp(V(x1))*step1);
    plot(x1,(1/Z)*exp(V(x1)),'r','LineWidth',4)
    legend('Hist. of generated samples','Nakagami pdf')
end


