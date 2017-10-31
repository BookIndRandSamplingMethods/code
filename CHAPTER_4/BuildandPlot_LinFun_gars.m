function r=BuildandPlot_LinFun_gars(s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% build and plot                 %
%%%% linear functions for GARS demo %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% simple estimates
xpr1=-2; %%% in this specific case
xpr2=2;  %%% in this specific case
%%%
s=sort(s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=-4:0.01:4;
cla
plot(x,4-x.^2) %%%% plot g1(x) of this example
hold on
text(-3,2.2,'g_1(x)=4-x^2','FontSize',15,'fontweight','bold')
text(3.3,1.6,'\mu_1','FontSize',15,'fontweight','bold')
plot(x,0*ones(1,length(x)),'r--','LineWidth',1)
plot(s,4-s.^2,'ko','MarkerFaceColor','r','Markersize',6)
plot(xpr1,4-xpr1.^2,'ks','MarkerFaceColor','g','Markersize',6)
plot(xpr2,4-xpr2.^2,'ks','MarkerFaceColor','g','Markersize',6)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(s)+1
    %%%%%
    %%%%%
    if i==length(s)+1
           m(i)=-2*s(i-1);
          b(i)=4-s(i-1)^2-m(i)*s(i-1);
          r(i,:)=[m(i) b(i)];
           x1=[s(i-1):0.01:4];  %%% just for plotting       
    %%%%
    elseif s(i)<= xpr1
    %%%%   
       m(i)=-2*s(i);
       b(i)=4-s(i)^2-m(i)*s(i);
       r(i,:)=[m(i) b(i)];
      %%%  
       if i==1
          x1=[-4:0.01:s(i)]; %%% just for plotting 
          
       else
           x1=[s(i-1):0.01:s(i)]; %%% just for plotting 
       end
      %%%
   %%%%    
   elseif s(i)>xpr1 & s(i)<=xpr2
   %%%% 
       [m(i),b(i)]=St_Line_Between_2P(s(i),4-s(i)^2,s(i-1),4-s(i-1)^2);
       r(i,:)=[m(i) b(i)];
       x1=[s(i-1):0.01:s(i)]; %%% just for plotting 
    %%%%
    elseif s(i)>xpr2
    %%%%
          m(i)=-2*s(i-1);
          b(i)=4-s(i-1)^2-m(i)*s(i-1);
          r(i,:)=[m(i) b(i)]; 
          x1=[s(i-1):0.01:s(i)]; %%% just for plotting 
    %%%
    end
%%%%%
   plot(x1,m(i)*x1+b(i),'r') %%% plot line
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
