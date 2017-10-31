%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Chinese Restaurant Process - Finite approximation of a Dirichelet Process %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
disp(' ')
disp('---------------------------------------------------------------------------------------------')
disp(' Chinese Restaurant Process - Finite approximation of a Dirichelet Process ')
disp('---------------------------------------------------------------------------------------------')
disp(' ')
%%%%%%%%% %%%%%%%%%  %%%%%%%%%  %%%%%%%%%  %%%%%%%%%  %%%%%%%%%  %%%%%%%%%
T=1000; %%%% total number of samples 
disp(['Total number of generated samples = ', num2str(T)])
alpha=100; %%% concentration parameter 
disp(['Concentration parameter (alpha)   = ', num2str(alpha)])
disp(['Base density q0(x) = N(x|0,1)'])
disp(' ')
disp('---------------------------------------------------------------------------------------------')
disp(' ')
disp('Observe that the concentration parameter (alpha) defines how strong is the discretization:')
disp(' ')
disp('- If alpha=0, all the generated samples are concentrated in the first generated value.')
disp(' ')
disp('- Whereas, when alpha grows, we have more "atoms", i.e.,') 
disp('  the generated set of samples looks coming from a "continous" distribution,') 
disp('  getting closer and closer to the base pdf q0(x) (for alpha==> Infinite).')
disp(' ')
disp('---------------------------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Chinese Restaurant Procedure   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for t=1:T
   xpr=randn(1,1);  %%% base density q0(x)
%%%%%%%%%   
   if t==1
        xd(t)=xpr;
   else
       x_aux_vec=[xd xpr];
       %%%% build the weights
       w=1/(t-1+alpha)*ones(1,length(x_aux_vec)-1);
       w(end+1)=alpha/(t-1+alpha);
       %%%%
       xd(t)=randsrc(1,1,[x_aux_vec; w]); %%% pick one in x_aux_vec according to the weights w 
   end
%%%%%%%%%%  
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot
figure  
[r1,r2]=hist(xd,T);
hold on
bar(r2,r1/T,'EdgeColor','b','Linewidth',2)
plot([-3 3],[0 0],'k-','Linewidth',2)
box on
axis([-4 4 0 0.04])
set(gca,'FontSize',30)
set(gca,'FontWeight','Bold')
ylabel('q(x)')
xlabel('x')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 