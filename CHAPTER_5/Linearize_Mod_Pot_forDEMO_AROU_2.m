function [r]=Linearize_Mod_Pot_forDEMO_AROU_2(c,d,y,s,mui)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_check_yes=0;
%%%
if plot_check_yes==1
x=0.01:0.001:10;
plot(x,y+c*log(d*(x+1/d)))
hold on
plot(s,y+c*log(d*(s+1/d)),'ro')
plot(x,mui*ones(1,length(x)),'r--')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xpr=-1/d+(1/d)*exp((mui-y)/c);
if xpr<0
xpr=0;
end
%%%%
pos=find(s==xpr);
if isempty(pos)
s=[s xpr];
s=sort(s);
end
s=sort(s);
%%%%%%%%%%
if plot_check_yes==1
plot(s,y+c*log(d*(s+1/d)),'ro')
end
%%%%%%%%%
if isempty(find(s==Inf))
s=[-Inf s Inf];
end
%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(s)-1
   if s(i)<xpr 
       r{i}(1,1)=c/(s(i+1)+1/d);
       r{i}(1,2)=y+c*log(d*(s(i+1)+1/d))-r{i}(1,1)*s(i+1);
   else
       if i==length(s)-1
           r{i}(1,1)=0;
           r{i}(1,2)=y+c*log(d*(s(i)+1/d));
       else
           [r{i}(1,1),r{i}(1,2)]=St_Line_Between_2P(s(i),y+c*log(d*(s(i)+1/d)),s(i+1),y+c*log(d*(s(i+1)+1/d)));
       end
   end
%%%%%%%%%%%%%%   
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
%%%%%%%%%%%%%%   
end




