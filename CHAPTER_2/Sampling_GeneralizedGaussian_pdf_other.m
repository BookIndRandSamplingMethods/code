%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%% GENERALIZED GAUSSIAN PDF                  %%
%%%% p_o(x) \propto \exp(-|x|^rho)             %%
%%%%                                           %%
%%%% Example 2.7;  second method               %%
%%%%    SCALE TRANSFORMATION                   %%
%%%%         X=UY^(1/rho)                      %%
%%%% X\sim p_o(x)                              %% 
%%%% U\sum U([-1,1])                           %%
%%%% Y\sim Gamma(1+1/rho,1)                    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ')
disp('       GENERALIZED GAUSSIAN PDF ')
disp('     p_o(x) \propto \exp(-|x|^rho) ')
disp('    ')
disp('     Example 2.7;  second method')
disp('    ')
disp('        SCALE TRANSFORMATION  ')
disp('           X=UY^(1/rho)          ')
disp(' X\sim p_o(x)  ')
disp(' U\sum \{-1,1\} with prob. 0.5, 0.5 ')
disp(' Y\sim Gamma(1/rho,1) ')
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ')
rho=0.8; %%%%
disp(' ')
disp(['rho = ',num2str(rho)])
alpha=1/rho;
theta=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_samples=10000;  %%% number of generated samples
y_s = gamrnd(alpha,theta,1,N_samples);
z_s=y_s.^(1/rho);
S_s=randsrc(1,N_samples,[-1 1;0.5 0.5]);
x_s=S_s.*z_s;  %%% scale transformation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% PLOTS %%%% 
    PDF_GAMMA=@(x) x.^(alpha-1).*exp(-x/theta);
    hold on
    [e,b]=hist(y_s,30);
    Zbar=sum(e*(b(2)-b(1)));
    hold on
    set(gca,'FontWeight','Bold','FontSize',20)
    box on
    bar(b,1/Zbar*e)
    step1=0.01;
    x1=0.01:step1:max(y_s)+2;
    Z=sum(PDF_GAMMA(x1)*step1);
    plot(x1,(1/Z)*PDF_GAMMA(x1),'r','LineWidth',4) 
    title('PDF of Y')
    xlabel('y')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    PDF_GEN_GAUSS=@(x) exp(-abs(x).^rho); 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    figure 
    [e,b]=hist(x_s,30);
    Zbar=sum(e*(b(2)-b(1)));
    hold on
    set(gca,'FontWeight','Bold','FontSize',20)
    box on
    bar(b,1/Zbar*e)
    step1=0.01;
    x1=min(x_s)-2:step1:max(x_s)+2;
    Z=sum(PDF_GEN_GAUSS(x1)*step1);
    plot(x1,(1/Z)*PDF_GEN_GAUSS(x1),'r','LineWidth',4)
    title('PDF of X with Gen. Gauss. pdf')
    xlabel('x')
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   