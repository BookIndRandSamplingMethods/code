function [sample,fp]=Sample_Eval_Proposal(f,m,b,S,type,w)
	% S		set of N points
	
    N=length(S);
 	xa=[-Inf S +Inf];
%     
%     
%    area(1)=(1/m(1)).*exp(m(1)*xa(2)+b(1))-(1/m(1)).*exp(m(1)*xa(1)+b(1));
%    area(N+1)=(1/m(N+1)).*exp(m(N+1)*xa(N+2)+b(N+1))-(1/m(N+1)).*exp(m(N+1)*xa(N+1)+b(N+1));
%    
%     
%     if type == 0 | type~=1
%         %
% %        for i=1:length(xa)-1
% %            if i==1 | i==length(xa)-1
% %                area(i)=(1/m(i)).*exp(m(i)*xa(i+1)+b(i))-(1/m(i)).*exp(m(i)*xa(i)+b(i));
% %            else
% %                area(i)=(xa(i+1)-xa(i))*exp(b(i));
% %            end
% %             
% %        end       
%        area(2:N)=(xa(3:end-1)-xa(2:end-2)).*exp(b(2:end-1));
%         
%     elseif type ==1
%         %
% %         for i=1:length(xa)-1
% %             if i==1 | i==length(xa)-1
% %                 area(i)=(1/m(i))*exp(m(i)*xa(i+1)+b(i))-(1/m(i))*exp(m(i)*xa(i)+b(i));
% %             else
% %                 fs1=m(i)*xa(i)+b(i);
% %                 fs2=m(i)*xa(i+1)+b(i);  
% %                 area(i)=((fs1+fs2)*abs(xa(i+1)-xa(i)))/2;  %%% no need abs
% %             end
% %         end   
%          fs1=m(2:end-1).*xa(2:end-2)+b(2:end-1);
%          fs2=m(2:end-1).*xa(3:end-1)+b(2:end-1);  
%          area(2:N)= ((fs1+fs2).*(xa(3:end-1)-xa(2:end-2)))/2;
%    
%     end
%        
%     
%     w=area./sum(area);
    
    
   
   %%%%%%%%% piece=randsrc(1,1,[1:N+1;w]); %%%%%%% do not use that 
    piece=mnrnd(1,w)*[1:N+1]';
    
    if piece==1
        y=exp(m(1)*xa(2)+b(1))*rand(1,1);
        sample=(log(y)-b(1))/m(1);
         fp=exp(m(1)*sample+b(1));
         
         
    elseif piece==N+1
         y=exp(m(N+1)*xa(N+1)+b(N+1))-exp(m(N+1)*xa(N+1)+b(N+1))*rand(1,1);
        sample=(log(y)-b(N+1))/m(N+1);
         fp=exp(m(N+1)*sample+b(N+1));
    else
        if type == 0 | type~=1
             sample=xa(piece)+(xa(piece+1)-xa(piece))*rand(1,1);
            fp=exp(b(piece)); 
             
        elseif type == 1
             %sample=xa(piece)+(xa(piece+1)-xa(piece))*rand(1,1);
             u=xa(piece)+(xa(piece+1)-xa(piece))*rand(1,1); 
             v=xa(piece)+(xa(piece+1)-xa(piece))*rand(1,1); 
             fs1=f(xa(piece));
             fs2=f(xa(piece+1));
             auxvar=fs1/(fs1+fs2);
             %sample=randsrc(1,1,[min([u,v]) max([u,v]);auxvar 1-auxvar]);
             sample=mnrnd(1,[auxvar 1-auxvar])*[min([u,v]) max([u,v])]';
             fp=m(piece)*sample+b(piece); 
             
        end
    end
    

	

