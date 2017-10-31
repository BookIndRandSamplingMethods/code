function [x_samples,time,AR,NP]=ARS(N_initial,N_desired_samples)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% STANDARD ARS                    %%%
%%% FOR A GAUSSIAN PDF              %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Gaussian Target pdf %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=1;
r=2;
V=@(x) -x.^r/a;
D_v=@(x) -r*x.^(r-1)/a;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% NODES %%%%%%%%%%%%%%%%%%%%%%%%
S=[-1,-2+4*rand(1,N_initial-2),1];
S=sort(S);
%%% initializing variables
x_samples=[];
count_acc_samples=0;
t=0; %%% count total iterations of the algorithm
%%%%%%%%%%%%%%%%%%%
%%%%% START %%%%%%%
%%%%%%%%%%%%%%%%%%%
tic

 while count_acc_samples<=N_desired_samples   
    %%%% 
     t=t+1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    %%% building proposal and computing area below 
    [Area_tot(t),areas_each_piece,xint,yint,m,b,S2]=Build_Prop(S,V,D_v);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%CHOOSING A PIECE
    wn=areas_each_piece/sum(areas_each_piece);
    pos=randsrc(1,1,[1:length(wn);wn]);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% DRAWING A SAMPLES X_PR from the proposal
    N_nodes=length(S);
    if pos==1
          y=exp(m(1)*S2(2)+b(1))*rand(1,1);
            xpr=(log(y)-b(1))/m(1);              
    elseif pos==N_nodes+1
             y=exp(m(N_nodes+1)*S2(N_nodes+1)+b(N_nodes+1))-exp(m(N_nodes+1)*S2(N_nodes+1)+b(N_nodes+1))*rand(1,1);
            xpr=(log(y)-b(N_nodes+1))/m(N_nodes+1);
    else
         y=exp(m(pos)*S2(pos)+b(pos))+(exp(m(pos)*S2(pos+1)+b(pos))-exp(m(pos)*S2(pos)+b(pos)))*rand(1,1);
                xpr=-(b(pos) - log(y))/m(pos);
    end
%%%% evaluating the target at xpr
eval_TAR=exp(V(xpr));
%%%% evaluating the proposal at xpr
eval_PROP=exp(m(pos)*xpr+b(pos));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% RS TEST                               %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 U=rand(1,1);
     if U<eval_TAR/eval_PROP %%%% accept!!
        x_samples(end+1)=xpr;
        count_acc_samples=count_acc_samples+1;
     else %%% reject and update the set of nodes
        S=[S xpr];   
        S=sort(S); 
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
     end  %%%% end RS test 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
 end %%% end main loop (while)
%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%
time=toc; %%%% spent time 
%%%%
AR=count_acc_samples/t; %%% Acceptance Rate in this run
NP=length(S);           %%% Final number of point in this run
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
    x1=-6:step1:6;
    Z=sum(exp(V(x1))*step1);
    plot(x1,(1/Z)*exp(V(x1)),'r','LineWidth',4)
    legend('Hist. of generated samples','Target pdf')
end



