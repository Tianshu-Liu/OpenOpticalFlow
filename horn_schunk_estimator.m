function [u,v] = horn_schunk_estimator(Ix, Iy, It, lambda, tol, maxnum)
%
% Ix: partial derivative for x-axis
% Iy: partial derivative for y-axis
% It: partial derivative for time t
% lambda: regularization parameter
% nb: the neighborhood information
%
%

[r,c]=size(Ix);

%------------------------------------------------------------------%
chorizontal = [3, ones(1, c-2)*8, 3];
cvertical = [3; ones(r-2,1)*8; 3];
cmtx = 8*ones(r,c); cmtx(1,:)=chorizontal;cmtx(r,:)=chorizontal;cmtx(:,1)=cvertical;cmtx(:,c)=cvertical;

uv = (Ix.*Iy)./(cmtx.*(Ix.^2+Iy.^2)+lambda*cmtx.^2);
u1 = (Iy.^2+lambda*cmtx)./(cmtx.*(Ix.^2+Iy.^2)+lambda*cmtx.^2);
u2 = (Ix.*It)./(Ix.^2+Iy.^2+lambda*cmtx);
v1 = (Ix.^2+lambda*cmtx)./(cmtx.*(Ix.^2+Iy.^2)+lambda*cmtx.^2);
v2 = (Iy.*It)./(Ix.^2+Iy.^2+lambda*cmtx);
%------------------------------------------------------------------%
%---------------- Initialize the parameters -----------------------%
k=0;
total_error=100000000;
u = zeros(r,c);
v = zeros(r,c);
%------------------------------------------------------------------%
while total_error > tol & k < maxnum
    total_error
    for n=1:c
        for m=1:r
            if n==1 
                if m==1
                    tmpu = u(m+1,n)+u(m,n+1)+u(m+1,n+1);
                    tmpv = v(m+1,n)+v(m,n+1)+v(m+1,n+1);
                elseif m==r
                    tmpu = u(m-1,n)+u(m,n+1)+u(m-1,n+1);
                    tmpv = v(m-1,n)+v(m,n+1)+v(m-1,n+1);
                else
                    tmpu = u(m-1,n)+u(m+1,n)+u(m-1,n+1)+u(m,n+1)+u(m+1,n+1);
                    tmpv = v(m-1,n)+v(m+1,n)+v(m-1,n+1)+v(m,n+1)+v(m+1,n+1);
                end
            elseif n==c
                if m==1
                    tmpu = u(m+1,n)+u(m,n-1)+u(m+1,n-1);
                    tmpv = v(m+1,n)+v(m,n-1)+v(m+1,n-1);
                elseif m==r
                    tmpu = u(m-1,n)+u(m,n-1)+u(m-1,n-1);
                    tmpv = v(m-1,n)+v(m,n-1)+v(m-1,n-1);
                else
                    tmpu = u(m-1,n)+u(m+1,n)+u(m-1,n-1)+u(m,n-1)+u(m+1,n-1);
                    tmpv = v(m-1,n)+v(m+1,n)+v(m-1,n-1)+v(m,n-1)+v(m+1,n-1);
                end
            else              
                 if m==1
                    tmpu = u(m,n-1)+u(m,n+1)+u(m+1,n-1)+u(m+1,n)+u(m+1,n+1);
                    tmpv = v(m,n-1)+v(m,n+1)+v(m+1,n-1)+v(m+1,n)+v(m+1,n+1);
                elseif m==r
                    tmpu = u(m,n-1)+u(m,n+1)+u(m-1,n-1)+u(m-1,n)+u(m-1,n+1);
                    tmpv = v(m,n-1)+v(m,n+1)+v(m-1,n-1)+v(m-1,n)+v(m-1,n+1);
                else
                    tmpu = u(m-1,n-1)+u(m-1,n)+u(m-1,n+1)+u(m,n-1)+u(m,n+1)+u(m+1,n-1)+u(m+1,n)+u(m+1,n+1);
                    tmpv = v(m-1,n-1)+v(m-1,n)+v(m-1,n+1)+v(m,n-1)+v(m,n+1)+v(m+1,n-1)+v(m+1,n)+v(m+1,n+1);
                end    
            end
            unew(m,n) = u1(m,n)*tmpu - uv(m,n)*tmpv - u2(m,n);
            vnew(m,n) = v1(m,n)*tmpv - uv(m,n)*tmpu - v2(m,n);       
        end  
    end
    total_error = (norm(unew-u,'fro')+norm(vnew-v,'fro'))/(r*c);
    u = unew;
    v = vnew;
    k=k+1  
end