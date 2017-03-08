function delu = laplacian(u,h)
%
% u: Given image
% h: step size
%

H = [1, 1, 1; 1,0,1;1,1,1]; 
%You could also choose (which seems more natural)
% H = [0, 1, 0; 1,0,1;0,1,0]; 
delu = -u.*imfilter(ones(size(u)), H/(h*h), 'same') + imfilter(u, H/(h*h), 'same');