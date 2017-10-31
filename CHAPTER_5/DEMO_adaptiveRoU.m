%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DEMO Adaptive Ratio-of-Uniforms    %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('---------------------------------------------------------------------------------')
disp(' DEMO Adaptive Ratio-of-Uniforms (A-RoU)  ')
disp('       (GARS within RoU) ')
disp(' The code is slowed down in order to allow a suitable graphical representation')
disp('---------------------------------------------------------------------------------')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% definition  of the target (posterior pdf)  %%%%% 
%%%%%%% (it depends on the inference problem)      %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% parameters %%%%
c=0.8;%%% must be always positive 
d=1.5;
a=2;%%% must be always positive
b=1.1;
mu=2;
%%%% observations 
y1=0.9;
y2=0.6;
y3=2;
%%%%%
step_x=0.001;
proposed_x_now=0:step_x:5;  %%% for plotting
%%%% log-likelihood
z1=y1+sqrt(2)+a*exp(-b*proposed_x_now);
z2=y2+1+c*log(d*(proposed_x_now+1/d));
z3=y3-(proposed_x_now-mu).^2;
V1=z1.^2-log(z1.^4);
V2=z2.^2-log(z2.^2);
V3=(z3).^2;
loglike=V1+V2+V3;
%%%%%%% unnormalized posterior pdf     %%%%
%%% with exponential prior= exp(-0.2*x) %%%
Target=exp(-loglike).*exp(-0.2*proposed_x_now); 
NormConstant=sum(0.001*Target);
%%%% plot normalized posterior %%%%
subplot(2,1,2)
axis([0 5 0 1])
plot(proposed_x_now,Target/NormConstant,'k','linewidth',2.5)
text(1.2,0.7,'p_o(x)','FontSize',15,'FontAngle','italic')
xlabel('x','FontSize',18,'FontWeight','Bold')
title('Target pdf and Histogram of the accepted samples  ---','FontSize',15,'FontWeight','Bold')
%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% plot acceptance area A of RoU          %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  subplot(2,1,1)
  ConstAUX=sqrt(60000); %%%%the area has been multiplied for this constant  
  %%%% only for avoiding numerical problems an plotting reasom
   %%%%% data for plotting the area A_g
   load area_x_forDemoARoU
   load area_y_forDemoARoU
   plot(paraCh1,paraCh2,'k.')
   xlabel('v','FontSize',18,'FontWeight','Bold')
   ylabel('u','FontSize',18,'FontWeight','Bold')
   set(gca,'YTick',[])
   set(gca,'XTick',[])
   axis([0 7.5 0 3.5])
   title('Generalized ARS (GARS) via RoU  ','FontSize',15,'FontWeight','Bold')
   text(2.2,3,'A','FontSize',18,'FontAngle','italic')
  disp('')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%% AUX VARIABLES FOR THE APPLICATION OF THE GARS METHOD           %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
mui=sqrt(2);
xpr(1)=0;
if (mui-y1-sqrt(2))>0
xpr(end+1)=-(1/b)*log((mui-y1-sqrt(2))/a);
end
%%%%
mui2=1;
%%%%
if -1/d+(1/d)*exp((mui-y2-1)/c)>0 
xpr(end+1)=-1/d+(1/d)*exp((mui-y2-1)/c);    
end
%%%%
if y3<0
y3=0;
end
if -sqrt(y3)+mu>0
    xpr(end+1)=-sqrt(y3)+mu;    
end
xpr(end+1)=sqrt(y3)+mu;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% initial set of support points %%%%
s0=[0.3 2 xpr 1]; 
s=s0;
s=sort(s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%% initializing variables
N=100; %%%% desired number of samples 
disp(' ')
disp(['desired number of samples = ',num2str(N)])
disp(' ')
accepted_samples=[];
count_accSam=0; %%%%  counting the number of accepted samples
count_iter=0;   %%%%  counting the number of iterations 
count_rejSam=0; %%%%  counting the number of rejected samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  disp(' press a key ')
  pause
  disp(' Recall that rhe code is slowed down ')
  disp(' ')
  disp(' start! ')
  disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% START - MAIN LOOP       %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while count_accSam<N
%%%%%
count_iter=count_iter+1; %%%% counting the iterations
%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%% for GARS method => linearizations 
[r]=Linearize_Mod_Pot_forDEMO_AROU_1(a,b,y1+sqrt(2),s,sqrt(2));
[r2]=Linearize_Mod_Pot_forDEMO_AROU_2(c,d,y2+1,s,1);
[r3]=Linearize_Mod_Pot_forDEMO_AROU_3(mu,y3,s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%
for i=2:length(s)+1
    if i==1     
    elseif i==length(s)+1
        proposed_x_now=s(i-1):0.001:7;
        sm=s(i-1)+0.5;
    else
        proposed_x_now=s(i-1):0.001:s(i);
        sm=(s(i-1)+s(i))/2;
    end
%%%%%%%%
 derVm1(i)=0.5*(2*r{i}(1,1)*(r{i}(1,2) + r{i}(1,1)*sm) - (2*r2{i}(1,1))/(r2{i}(1,2) + r2{i}(1,1)*sm) - (4*r{i}(1,1))/(r{i}(1,2) + r{i}(1,1)*sm) + 2*r2{i}(1,1)*(r2{i}(1,2) + r2{i}(1,1)*sm) + 2*r3{i}(1,1)*(r3{i}(1,2) + r3{i}(1,1)*sm - 2)+0.2);
 derVm2(i)=0.5*(2*r{i}(1,1)*(r{i}(1,2) + r{i}(1,1)*sm) - (2*r2{i}(1,1))/(r2{i}(1,2) + r2{i}(1,1)*sm) - (4*r{i}(1,1))/(r{i}(1,2) + r{i}(1,1)*sm) + 2*r2{i}(1,1)*(r2{i}(1,2) + r2{i}(1,1)*sm) + 2*r3{i}(1,1)*(r3{i}(1,2) + r3{i}(1,1)*sm - 2)+0.2)-1/sm;
 aux1=0.5*((r{i}(1,1)*sm+r{i}(1,2)).^+2-log((r{i}(1,1)*sm+r{i}(1,2)).^4)+(r2{i}(1,1)*sm+r2{i}(1,2)).^2-log((r2{i}(1,1)*sm+r2{i}(1,2)).^2)+(y3-r3{i}(1,1)*sm-r3{i}(1,2)).^2+0.2*sm);
 aux2=0.5*((r{i}(1,1)*sm+r{i}(1,2)).^+2-log((r{i}(1,1)*sm+r{i}(1,2)).^4)+(r2{i}(1,1)*sm+r2{i}(1,2)).^2-log((r2{i}(1,1)*sm+r2{i}(1,2)).^2)+(y3-r3{i}(1,1)*sm-r3{i}(1,2)).^2+0.2*sm)-log(sm);
%%%%%%%%%%
b_Vm1(i)=aux1-derVm1(i)*sm;
b_Vm2(i)=aux2-derVm2(i)*sm;
%%%%%%%%%%
 if derVm1(i)<0 
     area_below1(i)=derVm1(i)*s(i)+b_Vm1(i);   
 else
     area_below1(i)=derVm1(i)*s(i-1)+b_Vm1(i);
     if s(i-1)>=max(xpr)
      area_below1(i)=0.5*((y1+sqrt(2)+a*exp(-b*s(i-1))).^2-log((y1+sqrt(2)+a*exp(-b*s(i-1))).^4)+(y2+1+c*log(d*(s(i-1)+1/d))).^2-log((y2+1+c*log(d*(s(i-1)+1/d))).^2)+(y3-(s(i-1)-mu).^2).^2+0.2*s(i-1));
     end
 end
%%%%%%%%%% 
 if derVm2(i)<0
    area_below2(i)=derVm2(i)*s(i)+b_Vm2(i);   
 else
     area_below2(i)=derVm2(i)*s(i-1)+b_Vm2(i);
     if s(i-1)>=max(xpr)
        area_below2(i)=0.5*((y1+sqrt(2)+a*exp(-b*s(i-1))).^2-log((y1+sqrt(2)+a*exp(-b*s(i-1))).^4)+(y2+1+c*log(d*(s(i-1)+1/d))).^2-log((y2+1+c*log(d*(s(i-1)+1/d))).^2)+(y3-(s(i-1)-mu).^2).^2+0.2*s(i-1))-log(s(i-1));
     end
 end
%%%%%%%%%%
end
%%%%
area_below1=area_below1(2:end);
area_below2=area_below2(2:end);
%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% BUILDING TRIANGLES %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ConstAUX=sqrt(60000); %%%% only for avoiding numerical problems an plotting reasoh
Radio=sqrt((ConstAUX*exp(-area_below1)).^2+(ConstAUX*exp(-area_below2)).^2);
%%%% %%%%% %%%%
s_ext=[s Inf]; %%% extendend support points %%%%
angle=(atan(s_ext(1:end-1))+atan(s_ext(2:end)))/2;
sm=tan(angle);
PxTang=Radio.*sin(angle);
PyTang=Radio.*cos(angle);
b_PTang=PyTang+(sm).*PxTang;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% create and plot the triangles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
for i=1:length(s)
%%%%%  compute intersections between two straight lines %%%%%  
    if i~=1   
        [xint(i,1),yint(i,1)]=Inter_between_2Lines(-sm(i),b_PTang(i),1/s_ext(i),0);
    else
        xint(i,1)=0;
        yint(i,1)=b_PTang(i);
    end
%%%%%
   [xint(i,2),yint(i,2)]=Inter_between_2Lines(-sm(i),b_PTang(i),1/s_ext(i+1),0);
%%%%% computing area of the triangles
   area_triangle(i)=xint(i,2)*yint(i,1)-0.5*xint(i,2)*yint(i,2)-0.5*(xint(i,2)-xint(i,1))*(yint(i,1)-yint(i,2))-0.5*xint(i,1)*yint(i,1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%plot current triangle %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x_aux_forPlot=xint(i,1):0.01:xint(i,2);
subplot(2,1,1)
hold on
plot(x_aux_forPlot,-sm(i)*x_aux_forPlot+b_PTang(i),'r')
x_aux_forPlot=0:0.01:xint(i,1);
plot(x_aux_forPlot,1/s_ext(i)*x_aux_forPlot,'r')
x_aux_forPlot=0:0.01:xint(i,2);
plot(x_aux_forPlot,1/s_ext(i+1)*x_aux_forPlot,'r')
end %%% end loop ==> for i=1:length(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% pick a triangle according to its area
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wn=area_triangle./sum(area_triangle);
pos=randsrc(1,1,[1:length(wn);wn]);
%%%%%% %%%%%%%%%%%%% %%%%%%%%%%%%% %%%%%%%%%%%%%%%% %%%%%%%%%%
%%%% vertices of the chosen triangle; the other one is [0,0]
v1=[xint(pos,1) yint(pos,1)];
v2=[xint(pos,2) yint(pos,2)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% DRAW A POINT UNIFORMLY WITHIN THE CHOSEN TRIANGLE %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
proposed_point=Sampling_Uniform_in_Triangle(v1,v2,[0 0],1,0);
  sample_X=proposed_point(1,1);
  sample_Y=proposed_point(2,1);
  proposed_x_now=sample_X/sample_Y;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   z1=y1+sqrt(2)+a*exp(-b*proposed_x_now);
   z2=y2+1+c*log(d*(proposed_x_now+1/d));
   z3=y3-(proposed_x_now-mu).^2;
   V1=z1.^2-log(z1.^4);
   V2=z2.^2-log(z2.^2);
   V3=(z3).^2;
   loglike=V1+V2+V3; %%% at proposed_x_now
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
   Sqrt_Target_at_x=sqrt(60000*exp(-loglike).*exp(-0.2*proposed_x_now));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%% ACCEPT-REJECT TEST    %%% 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if sample_Y<=Sqrt_Target_at_x
     disp(['accepted; number ',num2str(count_accSam),' over ',num2str(N)])
        accepted_samples(end+1)=proposed_x_now; 
        count_accSam=count_accSam+1; %%% number of accepted samples
        plot(sample_X,sample_Y,'go','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',7)
        
   else
       disp(['rejected ',num2str(proposed_x_now)]) 
        s=[s proposed_x_now]; %%% set of support points
        s=sort(s);
        count_rejSam=count_rejSam+1;  %%% number of rejected samples
        plot(sample_X,sample_Y,'ro','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',7)
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% slowing down the code!!
%%%% for graphical reasons!
pause(0.1) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if count_accSam~=N
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%% plotting area A of RoU, triangle and samples  %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   subplot(2,1,1)
    cla
   load area_x_forDemoARoU
   load area_y_forDemoARoU
   plot(paraCh1,paraCh2,'k.')
   xlabel('v','FontSize',18,'FontWeight','Bold')
   ylabel('u','FontSize',18,'FontWeight','Bold')
   text(2.2,3,'A','FontSize',18,'FontAngle','italic')
   set(gca,'YTick',[])
   set(gca,'XTick',[])  
   title('Generalized ARS (GARS) via RoU  ','FontSize',15,'FontWeight','Bold')
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%% plotting normalized target and histogram   %%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   subplot(2,1,2)
   cla
   %%%% plotting normalized target
   axis([0 5 0 1])
   NormConstant=sum(0.001*Target);
   plot([0:0.001:5],Target/NormConstant,'k','linewidth',2.5)     
   text(1.2,0.7,'p_o(x)','FontSize',15,'FontAngle','italic')
   xlabel('x','FontSize',18,'FontWeight','Bold')
   hold on 
   %%%% histogram of accepted samples
   [freq_sam,aux_forbar]=hist(accepted_samples,18);
   norm_const_hist=abs(aux_forbar(2)-aux_forbar(1));
   norm_const_hist=sum(norm_const_hist*freq_sam);
   axis([0 5 0 1])
   bar(aux_forbar,freq_sam/norm_const_hist,'g')
   title('Target pdf and Histogram of the accepted samples  ---','FontSize',15,'FontWeight','Bold') 
end
%%%%%       
end  %%%end main while
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
disp(['Initial number of support points = ',num2str(length(s0))])
disp(['Final number of support points = ',num2str(length(s))])
disp('---------------------------------------------------------------------------------------------')
disp(['Acceptance Rate obtained at this run = N/T = ',num2str(N/count_iter)])
disp('---------------------------------------------------------------------------------------------')

