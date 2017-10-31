function [r]=Linearize_Mod_Pot_forDEMO_AROU_3(mu,y,s)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_check_yes=0;
%%%
if plot_check_yes==1
x=0.01:0.001:10;
plot(x,(x-mu).^2)
hold on
plot(s,(s-mu).^2,'ro')
plot(x,y*ones(1,length(x)),'r--')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if y<0
y=0;
end
%%%%%
xpr(1)=-sqrt(y)+mu;
if xpr(1)<0
xpr(1)=0;
end
xpr(2)=sqrt(y)+mu;
%%%
pos=find(s==xpr(1));
if isempty(pos)
if xpr(1)==xpr(2) %% y=0
    s=[s xpr(1)];
else
    s=[s xpr];
end
s=sort(s);
end
s=sort(s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%
if plot_check_yes==1
plot(s,(s-mu).^2,'ro')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%
if isempty(find(s==Inf))
s=[-Inf s Inf];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(s)-1
     if s(i)<xpr(1) 
         r{i}(1,1)=2*(s(i+1)-mu);
         r{i}(1,2)=(s(i+1)-mu).^2-r{i}(1,1)*s(i+1);
     elseif s(i)>=xpr(1) & s(i+1)<=xpr(2)
        [r{i}(1,1),r{i}(1,2)]=St_Line_Between_2P(s(i),(s(i)-mu).^2,s(i+1),(s(i+1)-mu).^2);
     elseif s(i)>=xpr(2) 
         r{i}(1,1)=2*(s(i)-mu);
         r{i}(1,2)=(s(i)-mu).^2-r{i}(1,1)*s(i);
     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
end
