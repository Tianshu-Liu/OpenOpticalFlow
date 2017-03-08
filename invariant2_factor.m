function [QQ]=invariant2_factor(Vx, Vy, factor_x, factor_y)
% factor_x: converting factor from pixel to m (m/pixel) in x
% factor_y: converting factor from pixel to m (m/pixel) in y

% Vx = imfilter(Vx, [1 1 1 1 1]'*[1 1 1 1 1]/25,'symmetric');
% Vy = imfilter(Vy, [1 1 1 1 1]'*[1,1 1 1,1]/25,'symmetric');

dx=1;
D = [0, -1, 0; 0,0,0; 0,1,0]/2; %%% partial derivative 
Vx_x = imfilter(Vx, D'/dx, 'symmetric',  'same')/factor_x; 
Vx_y = imfilter(Vx, D/dx, 'symmetric',  'same')/factor_y;

Vy_x = imfilter(Vy, D'/dx, 'symmetric',  'same')/factor_x; 
Vy_y = imfilter(Vy, D/dx, 'symmetric',  'same')/factor_y;


[M,N]=size(Vx);

for m=1:M
    for n=1:N        
        u(1,1)=Vx_x(m,n);
        u(1,2)=Vx_y(m,n);
        u(2,1)=Vy_x(m,n);
        u(2,2)=Vy_y(m,n);

        for i=1:2
            for j=1:2
                S(i,j)=(u(i,j)+u(j,i))/2;
                Q(i,j)=(u(i,j)-u(j,i))/2;
            end
        end
    
        QQ(m,n)=(trace(Q*Q')-trace(S*S'))/2;
        
       
%         lambda1(m,n)=max(d);
%         lambda2(m,n)=min(d);
    end
end























