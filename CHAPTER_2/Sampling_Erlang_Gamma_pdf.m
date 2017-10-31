%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     SAMPLING ERLANG PDFS            %%
%%%%   (GAMMA PDFS WITH alpha-INTEGER)   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%   SAMPLING ERLANG PDFS       %%')
disp('%% (special case of Gamma pdfs) %%')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%
a=3; %%% a>0 it MUST BE AN INTEGER
b=1.6; %%% b>0
Tar=@(x) x.^(a-1).*exp(-b*x);
disp(' ')
disp('------------------------------------------------------ ')
disp(' Target pdf \propto x.^(a-1).*exp(-b*x) with x>=0,')
disp(' ')
disp([' a = ',num2str(a),'  (it must be >0 and integer) '])
disp([' b = ',num2str(b),'  (it must be >0 ) '])
disp('------------------------------------------------------ ')
disp(' ')
%%%%
N_samples=10000;
disp([' Number of generated samples = ',num2str(N_samples)])
%%%%%%%%%%%%%%%%%%%
%%%% START %%%%%%%%
%%%%%%%%%%%%%%%%%%%
for i=1:N_samples
  u=rand(1,a);
  x(i)=-(1/b).*sum(log(u));
end
%%% END METHOD
%%%%%%%%%%%%%%%$
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
x1=0.01:step1:max(x)+2;
Z=sum(Tar(x1)*step1);
plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
legend('Hist. of generated samples','TARGET pdf')
axis([0 max(x)+2 0 max(1/Zbar*e)+0.01])
 



