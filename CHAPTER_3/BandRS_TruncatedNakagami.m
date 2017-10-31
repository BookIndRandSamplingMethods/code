%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%     BAND REJECTION                  %%
%%%%   FOR TRUNCATED NAKAGAMI PDF        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('%%%       BAND REJECTION                %%%')
disp('%%%  FOR TRUNCATED NAKAGAMI PDF         %%%' )
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% graphical settings
hfig=figure;
scrsz = get(0,'ScreenSize');
set(hfig,'OuterPosition',[scrsz(1)+400,scrsz(2)+200,1200,800])
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%%% TARGET PDFS
m=0.8;
K=1;
a=2;
Tar=@(x) x.^(2*m-1).*exp(-(m/K)*x.^2);
Tar_band=@(x) Tar(a-x);
step=0.001;
x=0:step:a;
disp('  ')
disp('--------------------------------------------------------------------------  ')
disp('  TARGET PDF  ')
disp('  ')
disp('p_o(x) \propto p(x)=x.^(2*m-1).*exp(-(m/K)*x.^2)) with x\in[0,a] ')
disp('  ')
disp(['m = ',num2str(m)])
disp(['K = ',num2str(K)])
disp(['a = ',num2str(a)])
disp('--------------------------------------------------------------------------  ')
disp('  ')
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%%% maximum values
M=max(Tar(x));
M2=max(Tar(x)+Tar_band(x));
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
N_proposed_samples=1000;
disp(['TOTAL NUMBER OF PROPOSED SAMPLES = ', num2str(N_proposed_samples)])
%%%%%%% GENERATE PROPOSED SAMPLES  %%%%%%%%%%%%%%%%%%%
x_pr=a*rand(1,N_proposed_samples);
y=2*M*rand(1,N_proposed_samples); %%%% FOR RS TESTING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% TRIVIAL BAND REJECTION - 1   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_B=2*M;
acc_samples_1=find(y<=Tar(x_pr));
acc_samples_2=find(y>L_B-Tar(x_pr));
rej_samples=find(y<=L_B-Tar(x_pr) & y>Tar(x_pr));
x_acc1=[x_pr(acc_samples_1) x_pr(acc_samples_2)];
%%%%
Num_acc1=length(x_acc1);
AR1=Num_acc1/N_proposed_samples;
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
subplot(2,2,1)
plot(x_pr(acc_samples_1),y(acc_samples_1),'go')
hold on
plot(x_pr(acc_samples_2),y(acc_samples_2),'go')
plot(x_pr(rej_samples),y(rej_samples),'ro')
h(1)=plot(x,Tar(x),'LineWidth',3);
L_B=2*M;
h(2)=plot(x,L_B-Tar(x),'m','LineWidth',3);
plot([0 a],[M M],'k--','LineWidth',3)
plot([0 a],[2*M 2*M],'k-','LineWidth',3)
set(gca,'FontWeight','Bold','FontSize',20)
legend(h,'p(x)','L_B-p(x)')
axis([0 2 0 1.8])
text(0.05,1.5,['AR at this run = ',num2str(AR1)],'FontWeight','Bold','FontSize',20)
title(['Trivial Band-RS; L_B = ',num2str(L_B)])
disp(' ')
disp([' Trivial Band-RS-1; NUMBER OF ACCEPTED SAMPLES in this run = ', num2str(Num_acc1)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% TRIVIAL BAND REJECTION - 2   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_B=2*M;
acc_samples_1=find(y<=Tar(x_pr));
acc_samples_2=find(y>L_B-Tar_band(x_pr));
rej_samples=find(y<=L_B-Tar_band(x_pr) & y>Tar(x_pr));
x_acc2=[x_pr(acc_samples_1) a-x_pr(acc_samples_2)];
%%%%
Num_acc2=length(x_acc2);
AR2=Num_acc2/N_proposed_samples;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2)
plot(x_pr(acc_samples_1),y(acc_samples_1),'go')
hold on
plot(x_pr(acc_samples_2),y(acc_samples_2),'go')
plot(x_pr(rej_samples),y(rej_samples),'ro')
h(1)=plot(x,Tar(x),'LineWidth',3);
L_B=2*M;
h(2)=plot(x,L_B-Tar_band(x),'m','LineWidth',3);
plot([0 a],[M M],'k--','LineWidth',3)
plot([0 a],[2*M 2*M],'k-','LineWidth',3)
set(gca,'FontWeight','Bold','FontSize',20)
legend(h,'p(x)','L_B-p(2-x)')
axis([0 2 0 1.8])
text(0.05,1.5,['AR at this run = ',num2str(AR2)],'FontWeight','Bold','FontSize',20)
title(['Trivial Band-RS; L_B = ',num2str(L_B)])
disp([' Trivial Band-RS-2; NUMBER OF ACCEPTED SAMPLES in this run = ', num2str(Num_acc2)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%      BAND REJECTION - 3      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L_B=M2+0.1;
acc_samples_1=find(y<=Tar(x_pr));
acc_samples_2=find(y>L_B-Tar_band(x_pr));
rej_samples=find(y<=L_B-Tar_band(x_pr) & y>Tar(x_pr));
x_acc3=[x_pr(acc_samples_1) a-x_pr(acc_samples_2)];
%%%%
Num_acc3=length(x_acc3);
AR3=Num_acc3/N_proposed_samples;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,3)
plot(x_pr(acc_samples_1),y(acc_samples_1),'go')
hold on
plot(x_pr(acc_samples_2),y(acc_samples_2),'go')
plot(x_pr(rej_samples),y(rej_samples),'ro')
h(1)=plot(x,Tar(x),'LineWidth',3);
hold on
L_B=M2+0.1;
h(2)=plot(x,L_B-Tar_band(x),'m','LineWidth',3);
plot([0 a],[M M],'k--','LineWidth',3)
plot([0 a],[2*M 2*M],'k-','LineWidth',3)
set(gca,'FontWeight','Bold','FontSize',20)
legend(h,'p(x)','L_B-p(2-x)')
axis([0 2 0 1.8])
text(0.04,1.5,['AR at this run = ',num2str(AR3)],'FontWeight','Bold','FontSize',20)
title(['Band-RS; L_B = ',num2str(L_B)])
disp([' Stand. Band-RS-3;  NUMBER OF ACCEPTED SAMPLES in this run = ', num2str(Num_acc3)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% OPTIMAL BAND REJECTION - 4   %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4)
L_B=M2;
acc_samples_1=find(y<=Tar(x_pr));
acc_samples_2=find(y>L_B-Tar_band(x_pr));
rej_samples=find(y<=L_B-Tar_band(x_pr) & y>Tar(x_pr));
x_acc4=[x_pr(acc_samples_1) a-x_pr(acc_samples_2)];
%%%%
Num_acc4=length(x_acc4);
AR4=Num_acc4/N_proposed_samples;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(x_pr(acc_samples_1),y(acc_samples_1),'go')
hold on
plot(x_pr(acc_samples_2),y(acc_samples_2),'go')
plot(x_pr(rej_samples),y(rej_samples),'ro')
h(1)=plot(x,Tar(x),'LineWidth',3);
hold on
L_B=M2;
h(2)=plot(x,L_B-Tar_band(x),'m','LineWidth',3);
plot([0 a],[M M],'k--','LineWidth',3)
plot([0 a],[2*M 2*M],'k-','LineWidth',3)
set(gca,'FontWeight','Bold','FontSize',20)
legend(h,'p(x)','L_B-p(2-x)')
axis([0 2 0 1.8])
text(0.04,1.5,['AR at this run = ',num2str(AR4)],'FontWeight','Bold','FontSize',20)
title(['Optimal Band-RS; L_B = ',num2str(L_B)])
disp([' Optimal Band-RS-4; NUMBER OF ACCEPTED SAMPLES in this run = ', num2str(Num_acc4)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plot histograms %%%%
hfig=figure;
scrsz = get(0,'ScreenSize');
set(hfig,'OuterPosition',[scrsz(1)+400,scrsz(2)+200,1200,800])
%%%
subplot(2,2,1)
[e,b]=hist(x_acc1,15);
Zbar=sum(e*(b(2)-b(1)));
hold on
set(gca,'FontWeight','Bold','FontSize',20)
box on
bar(b,1/Zbar*e)
step1=0.001;
x1=0.01:step1:2;
Z=sum(Tar(x1)*step1);
plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
legend('Hist. of gen. samples','TARGET pdf')
axis([0 2 0 1.4])
title(['Trivial Band-RS; L_B = ',num2str(2*M)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2)
[e,b]=hist(x_acc2,15);
Zbar=sum(e*(b(2)-b(1)));
hold on
set(gca,'FontWeight','Bold','FontSize',20)
box on
bar(b,1/Zbar*e)
step1=0.001;
x1=0.01:step1:2;
Z=sum(Tar(x1)*step1);
plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
legend('Hist. of gen. samples','TARGET pdf')
axis([0 2 0 1.4])
title(['Trivial Band-RS; L_B = ',num2str(2*M)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,3)
[e,b]=hist(x_acc2,15);
Zbar=sum(e*(b(2)-b(1)));
hold on
set(gca,'FontWeight','Bold','FontSize',20)
box on
bar(b,1/Zbar*e)
step1=0.001;
x1=0.01:step1:2;
Z=sum(Tar(x1)*step1);
plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
legend('Hist. of gen. samples','TARGET pdf')
axis([0 2 0 1.4])
title(['Band-RS; L_B = ',num2str(M2+0.1)])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4)
[e,b]=hist(x_acc2,15);
Zbar=sum(e*(b(2)-b(1)));
hold on
set(gca,'FontWeight','Bold','FontSize',20)
box on
bar(b,1/Zbar*e)
step1=0.001;
x1=0.01:step1:2;
Z=sum(Tar(x1)*step1);
plot(x1,(1/Z)*Tar(x1),'r','LineWidth',4)
legend('Hist. of gen. samples','TARGET pdf')
axis([0 2 0 1.4])
title(['Optimal Band-RS; L_B = ',num2str(M2)])
disp(' ')
disp(' ')
disp(' Trivial BandRS-1 and Trivial BandRS-2 are equivalent (see repeating several runs) ')



