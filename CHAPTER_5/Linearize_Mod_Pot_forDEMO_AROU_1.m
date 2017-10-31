function [r]=Linearize_Mod_Pot_forDEMO_AROU_1(a,b,y,s,mui)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_check_yes=0;
%%%%
if plot_check_yes==1
x=0.01:0.001:10;
plot(x,y+a*exp(-b*x))
hold on
plot(s,y+a*exp(-b*s),'ro')
plot(x,mui*ones(1,length(x)),'r--')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (mui-y)>=0
xpr=-(1/b)*log((mui-y)/a);
if xpr<0
xpr=0;
end
pos=find(s==xpr);
if isempty(pos)
s=[s xpr];
s=sort(s);   
end
else
    xpr=Inf;
end
%%%
s=sort(s);
%%%%
if plot_check_yes==1
plot(s,y+a*exp(-b*s),'ro')
end
%%%%
if isempty(find(s==Inf))
s=[-Inf s Inf];
end
%%%%
for i=1:length(s)-1
   if xpr==Inf
        if i~=length(s)-1
          r{i}(1,1)=-b*a*exp(-b*s(i+1));
          r{i}(1,2)=y+a*exp(-b*s(i+1))-r{i}(1,1)*s(i+1);
        else
           r{i}(1,1)=0;
           r{i}(1,2)=y;
        end
   else
    if s(i)<xpr 
       r{i}(1,1)=-b*a*exp(-b*s(i+1));
       r{i}(1,2)=y+a*exp(-b*s(i+1))-r{i}(1,1)*s(i+1);
    else
       if i==length(s)-1
           r{i}(1,1)=0;
           r{i}(1,2)=y+a*exp(-b*s(i));
       else
           [r{i}(1,1),r{i}(1,2)]=St_Line_Between_2P(s(i),y+a*exp(-b*s(i)),s(i+1),y+a*exp(-b*s(i+1)));
      end
    end
   end
%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 if plot_check_yes==1  
   if i==1
       x=0:0.001:s(i+1);
   elseif i==length(s)-1 
       x=s(i):0.001:10;
   else
       x=s(i):0.001:s(i+1);
   end
   plot(x,r{i}(1,1)*x+r{i}(1,2),'r')
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%   
end