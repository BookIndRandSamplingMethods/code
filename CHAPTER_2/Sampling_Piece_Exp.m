%function [sample,fm]=Sampling_Piece_Exp(m,b,x1,x2,N)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% SAMPLING TRUNCATED EXPONENTIAL 
%%%%% po(x)\propto exp(-m*x-b), x\in [x1,x2],  x2>x1
%%%%% by Vertical Density Representation (VDR) 
%%%%% or Inverse-f-Density method  (IoD)
%%%%% (they coincide in this case)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%%%%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('    SAMPLING FROM A TRUNCATED EXPONENTIAL  ')
disp('  po(x)\propto exp(-m*x-b), x\in [x1,x2],  x2>x1 ')
disp('    by Vertical Density Representation (VDR) ')
disp('     or Inverse-f-Density method  (IoD)  ')
disp('     (they coincide in this case)        ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
m=1;
b=1;
x1=1;
x2=3;
disp(' ')
disp(['  m= ',num2str(m)])
disp(['  b= ',num2str(b)])
disp([' x1= ',num2str(x1)])
disp([' x2= ',num2str(x2)])
disp(' ')
N_samples=10000;
disp([' Number of gen. samples = ',num2str(N_samples)])
%%%%
Tar=@(x)  exp(-m*x-b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if m==0 %%%% uniform pdf, special case
%%%
    if x2>=x1 
     x=x1+(x2-x1)*rand(1,N_samples);
     fm=b;
    else
        disp('x2 should be greater x1')
        x1=aux;
        x1=x2;
        x2=aux;
    end
%%%    
else %%%% truncated exponential pdf
%%%    
    MINI=min([exp(-m*x1-b),exp(-m*x2-b)]);
    MAXI=max([exp(-m*x1-b),exp(-m*x2-b)]);
   y=MINI+(MAXI-MINI)*rand(1,N_samples); %%% the Vertical Density in Uniform in [MINI,MAXI]
%%%%%%
x=-(log(y)+b)/m; %%%% inverting y=exp(-m*x-b).
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% END METHOD
%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%
%%%% plots %%%%%
figure
hold on
[e,b]=hist(x,30);
Zbar=sum(e*(b(2)-b(1)));
hold on
set(gca,'FontWeight','Bold','FontSize',20)
box on
bar(b,1/Zbar*e)
step1=0.001;
xaux=x1:step1:x2;
Z=sum(Tar(xaux)*step1);
plot(xaux,(1/Z)*Tar(xaux),'r','LineWidth',4)
legend('Hist. of generated samples','TARGET pdf')
axis([x1-0.5 x2+0.5 0 max((1/Z)*[Tar(x1) Tar(x2)])+0.1 ])
 


