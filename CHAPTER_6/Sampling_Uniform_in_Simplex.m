%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%     POINTS UNIFORMLY DISTRIBUTED IN A SIMPLEX        %%%%
%%%%%     (SIMPLEX = GENERALIZATION OF A TRIANGLE)         %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all 
clc
disp('------------------------------------------------')
disp('    POINTS UNIFORMLY DISTRIBUTED IN A SIMPLEX   ')
disp('     (SIMPLEX = GENERALIZATION OF A TRIANGLE)   ')
disp('------------------------------------------------')
Nsamples=1000; %%%% number of samples
disp(' ')
disp(['Number of desired samples = ',num2str(Nsamples)])
DIM_space=3;   %%%% dimension of the space 
disp(['Dimension  = ',num2str(DIM_space)])
N=DIM_space+1; %%%% number of vertices
%%%% choosing vertices 
if DIM_space==2
   vertices=[0 0; 1 2 ; 5 1]; 
else 
  vertices=[zeros(1,DIM_space); eye(DIM_space)];
end
disp([' Vertices :'])
disp(vertices)
disp(' ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% START GENERATION  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:Nsamples
%%%%%%%%%%%%%%%%%%    
    U(1)=0;
    U(2:N)=rand(1,N-1);
    U(N+1)=1;
%%%%%%%%%%%%%%%%%%   
Un=sort(U); %%% sorting in ascending order
s=Un(2:N+1)-Un(1:N); %%% uniform spacings %%%sum(s) %%% must be one
%%% convex combination of the vertices given s
Generated_samples(i,:)=sum(repmat(s',1,DIM_space).*vertices);
%%%
end %%%% end generation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% plotting
figure
%%%
if DIM_space==2
plot(Generated_samples(:,1),Generated_samples(:,2),'r.')
hold on
plot([vertices(1,1) vertices(2,1)],[vertices(1,2) vertices(2,2)],'k','LineWidth',4)
plot([vertices(3,1) vertices(2,1)],[vertices(3,2) vertices(2,2)],'k','LineWidth',4)
plot([vertices(1,1) vertices(3,1)],[vertices(1,2) vertices(3,2)],'k','LineWidth',4)
%%%
plot(vertices(:,1),vertices(:,2),'bs','MarkerEdgeColor','k',...
                       'MarkerFaceColor','g',...
                       'MarkerSize',15)                  
%%%       
elseif DIM_space==3
%%%    
    plot3(Generated_samples(:,1),Generated_samples(:,2),Generated_samples(:,3),'r.')
    hold on                     
    plot3([0 0],[0 0 ],[0 1],'k','LineWidth',4)
    plot3([0 0],[0 1 ],[0 0],'k','LineWidth',4)
    plot3([1 0],[0 0 ],[0 0],'k','LineWidth',4)
    plot3([1 0],[0 1 ],[0 0],'k','LineWidth',4)
    plot3([1 0],[0 0 ],[0 1],'k','LineWidth',4)
    plot3([0 0],[1 0 ],[0 1],'k','LineWidth',4)
    %%%%
    plot3(vertices(:,1),vertices(:,2),vertices(:,3),'bs','MarkerEdgeColor','k',...
                         'MarkerFaceColor','g',...
                           'MarkerSize',15)
    %%%                  
    grid on
    %view(52,26) 
    view(55,20) 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

