function S = checkInitPoints(f,S)
% CHECKINITPOINTS: Make sure at least one point s' gives the target f(s')>0
% ( just to avoid numerical problems )
% and check if there are enough support points


L=length(S);

f_S = f(S);
pos = find(f_S > 10^(-7));


if isempty(pos)==1 & L>=2
    
    disp('the initial points in S were not suitable; looking for one that is ...');
    x=-1000:0.0001:1000;
    pos=find(f(x)>= 10^(-7));
    if isempty(pos)==0
      S=[S x(pos(1))];
    else
        disp(' could not find one ! ');
            S=[];
    end
    
elseif L<2
    
    disp('at least two initial support points! looking for ...');
    x=-1000:0.0001:1000;
    pos=find(f(x)>= 10^(-7));
    if isempty(pos)==0
      S=[S x(pos(1)) x(pos(1))+randn(1,2)];
    else
        disp(' could not find one ! ');
            S=[];
    end

    
end