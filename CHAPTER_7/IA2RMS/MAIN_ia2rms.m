clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% IA2RMS main file  %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% TARGET DENSITY %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Tar=@(x) 0.5* 1/(sqrt(2*pi))*exp(-(x-7).^2/2)+0.5*1/(sqrt(2*pi*0.1))*exp(-(x+7).^2/(2*0.1));
Tar = @(x) exp( -x.^2/2).*(1+(sin(3*x)).^2).*(1+(cos(5*x).^2));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% EXAMPLES initial set of support points  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
S=[-8 -2 -1 0 2 10]; 
%S=[-20:0.5:20]; 
%%%%%
M=2000; %%% desired samples (number of iterations; we do not remove burn-in period; you can remove if desired)
type=0; %%% 0 or 1 %%% type of proposal construction
%%%%%% RUN IA2RMS
x=IA2RMS(Tar,S,M,type); %%%
%%%%%%%%%%%%%%%
%%%% PLOT  %%%%
%%%%%%%%%%%%%%%
figure
[e,b]=hist(x,30);
Zbar=sum(e*(b(2)-b(1)));
hold on
set(gca,'FontWeight','Bold','FontSize',20)
box on
bar(b,1/Zbar*e)
step1=0.001;
x1=-7:step1:7;
Z=sum(Tar(x1)*step1);
plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
legend('Hist. of gen. samples','TARGET pdf')
axis([-7 7 0 0.8])