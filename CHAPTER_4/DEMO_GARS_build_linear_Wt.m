 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%   EXAMPLE OF CONSTRUCTION OF THE     %%
 %%%%%% MODIFIED POTENTIAL AND  V(x;r) and   %%
 %%%%%% THE PIECEWISE LINEAR FUNCTION Wt(x)  %%       
 %%%%%%      IN GARS METHOD                  %%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 clear all
 close all
 clc 
 %%%% 
 help('DEMO_GARS_build_linear_Wt.m') 
 %%%% title and functions %%%
 title('GARS method','FontSize',15,'FontWeight','Bold')
 hold on
 text(-3.7,100,'V(x;g)=V_1(g_1(x))=(4-x^2)^2','FontSize',15,'fontweight','bold')
 text(1,110,'V_1(\vartheta)=\vartheta^2','FontSize',15,'fontweight','bold')
 text(1,95,'g_1(x)=4-x^2','FontSize',15,'fontweight','bold')
%%%% plotting the potential function
x=-4:0.001:4;
plot(x,(4-x.^2).^2,'b')
hold on; box on
axis([-4 4 -30 150])
set(gca,'XTick',[ ]) 
set(gca,'YTick',[ ]) 
%%%% support points
s=[-2 0 2];
text(s(1),-38,'s_1','FontSize',15,'fontweight','bold')
text(s(2),-38,'s_2','FontSize',15,'fontweight','bold')
text(s(3),-38,'s_3','FontSize',15,'fontweight','bold')
s=sort(s);
for j=1:length(s)
    plot([s(j) s(j)], [-30 (4-s(j).^2).^2],'k--')
end
plot(s,(4-s.^2).^2,'ko','MarkerFaceColor','r','Markersize',6)
xpr1=-2;
xpr2=2;
%%%
disp(' with 3 support points s1, s2, s3 ')
disp(' ')
disp('press a key')
pause
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% plot modified potential V(x;r) and Wt %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(s)+1
%%%   
    if i==length(s)+1
           m(i)=-2*s(i-1);
          b(i)=4-s(i-1)^2-m(i)*s(i-1);
          r(i,:)=[m(i) b(i)];
           x1=[s(i-1):0.01:4];         
    elseif s(i)<= xpr1
       m(i)=-2*s(i);
       b(i)=4-s(i)^2-m(i)*s(i);
       r(i,:)=[m(i) b(i)];     
       if i==1
          x1=[-4:0.01:s(i)];    
       else
          x1=[s(i-1):0.01:s(i)];
       end     
   elseif s(i)>xpr1 & s(i)<=xpr2
       %%%% straight line between two points %%%%
       [m(i),b(i)]=St_Line_Between_2P(s(i),4-s(i)^2,s(i-1),4-s(i-1)^2);
        r(i,:)=[m(i) b(i)];
        x1=[s(i-1):0.01:s(i)];
   elseif s(i)>xpr2
            m(i)=-2*s(i-1);
          b(i)=4-s(i-1)^2-m(i)*s(i-1);
          r(i,:)=[m(i) b(i)]; 
           x1=[s(i-1):0.01:s(i)];
   end
%%% %%% %%% %%% %%% %%% %%% %%% %%%%%% %%% %%% %%% %%% %%% %%% %%% %%%%   
%%%% modified potential
 disp(['Modified potential V(x;r); piece number = ',num2str(i)])
 %%% %%% %%% %%% %%% %%% %%% %%% %%%%%% %%% %%% %%% %%% %%% %%% %%% %%%
 plot(x1,(r(i,1)*x1+r(i,2)).^2,'r--','LineWidth',1)
 if i==1
  text(-3.7,48,'V(x;r_0)','FontSize',15,'fontweight','bold')
 elseif i==2
     text(-2,10,'V(x;r_1)','FontSize',15,'fontweight','bold')
 elseif i==3
      text(0.5,10,'V(x;r_2)','FontSize',15,'fontweight','bold')
 elseif i==4
      text(2.7,50,'V(x;r_3)','FontSize',15,'fontweight','bold')
 end
 %%% %%% %%% %%% %%%
 disp('press a key')
 pause
%%%%%%% xo: point for computing the tagent line to V(x,r)
 if i==1
        xo=(-4+s(i))/2;  
    elseif i==length(s)+1
        xo=(4+s(i-1))/2;
    else 
        xo=(s(i)+s(i-1))/2;
    end 
 %%% %%% %%% %%% %%% %%% %%% %%% %%%
 %%%% tangent  %%%% %%%% %%%% %%%% %
  m(i)=2*r(i,1)*(r(i,1)*xo+r(i,2));
  b(i)=(r(i,1)*xo+r(i,2)).^2-m(i)*xo;
  %%% %%% %%% %%% %%% %%% %%% %%% %%%%%% %%% %%% %%% %%% %%% %%% %%% %%%
  %%%% plot a piece of Wt(x)    %%%%%%%% %%% %%% %%% %%% %%% %%% %%% %%%
 disp(['Function Wt(x); piece number = ',num2str(i)])
 plot(x1,m(i)*x1+b(i),'k','LineWidth',1)
 %%% %%% %%% %%% %%% %%% %%% %%% %%%%%% %%% %%% %%% %%% %%% %%% %%% %%%
  if i==1
  text(-3.7,6.9,'w_0(x)','FontSize',15,'fontweight','bold')
 elseif i==2
     text(-1,-5,'w_1(x)','FontSize',15,'fontweight','bold')
 elseif i==3
      text(0.5,-5.2,'w_2(x)','FontSize',15,'fontweight','bold')
 elseif i==4
      text(2.9,4.8,'w_3(x)','FontSize',15,'fontweight','bold')
  end
  %%% %%% %%% %%% %%%
  disp('press a key')
  pause
  %%% %%% %%% %%% %%%
end
%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%
%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%
  disp(' ')
  disp('---------------------------------------------------------- ')
  disp(' ')
  disp('Note that')
  disp(' ')
  disp(' Wt(x) <= V(x;r) <= V(x;g) ')
  disp('---------------------------------------------------------- ')
%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%
%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%%%% %%% %%% %%% %%%

 