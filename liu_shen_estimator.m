function [u,v,error] = liu_shen_estimator(I0, I1, f, dx, dt, lambda, tol, maxnum, u0, v0)
% 
% I: intensity function
% Ix: partial derivative for x-axis
% Iy: partial derivative for y-axis
% It: partial derivative for time t
% f: related all boundary assumption
% lambda: regularization parameter
% nb: the neighborhood information
%
%-------------------------------------------------------------------%
D = [0, -1, 0; 0,0,0; 0,1,0]/2; %%% partial derivative 
M = [1, 0, -1; 0,0,0;-1,0,1]/4; %%% mixed partial derivatives
F = [0, 1, 0; 0,0,0;0,1,0]; %%% average
D2 =  [0, 1, 0; 0,-2,0;0,1,0]; %%% partial derivative
H = [1, 1, 1; 1,0,1;1,1,1]; 
%------------------------------------------------------------------%
%------------------------------------------------------------------%
IIx = I0.*imfilter(I0, D/dx, 'replicate',  'same');
IIy = I0.*imfilter(I0, D'/dx, 'replicate',  'same');
II = I0.*I0;
Ixt = I0.*imfilter((I1-I0)/dt-f, D/dx, 'replicate',  'same');
Iyt = I0.*imfilter((I1-I0)/dt-f, D'/dx, 'replicate',  'same');


%------------------------------------------------------------------%
%---------------- Initialize the parameters -----------------------%
k=0;
total_error=100000000;
u=u0;
v=v0;

[r,c]=size(I1);

%------------------------------------------------------------------%
[B11, B12, B22] = generate_invmatrix(I0, lambda, dx);
error=[];
while total_error > tol & k < maxnum
    total_error
    bu = 2*IIx.*imfilter(u, D/dx, 'replicate',  'same')+ ... 
        IIx.*imfilter(v, D'/dx, 'replicate',  'same')+ ...
        IIy.*imfilter(v, D/dx, 'replicate',  'same') + ... 
        II.*imfilter(u, F/(dx*dx), 'replicate',  'same')+ ... 
        II.*imfilter(v, M/(dx*dx), 'replicate',  'same') + ... 
        lambda*imfilter(u, H/(dx*dx), 'same')+Ixt;
    
    bv = IIy.*imfilter(u, D/dx, 'replicate',  'same') + ...
         IIx.*imfilter(u, D'/dx, 'replicate',  'same') + ...
         2*IIy.*imfilter(v, D'/dx, 'replicate',  'same')+ ...
         II.*imfilter(u, M/(dx*dx), 'replicate',  'same') + ...
         II.*imfilter(v, F'/(dx*dx), 'replicate',  'same')+ ... 
         lambda*imfilter(v, H/(dx*dx), 'same')+Iyt;
     
    unew = -(B11.*bu+B12.*bv);
    vnew = -(B12.*bu+B22.*bv);
    total_error = (norm(unew-u,'fro')+norm(vnew-v,'fro'))/(r*c)
    u = unew;
    v = vnew;
    error=[error; total_error];
    k=k+1  
end