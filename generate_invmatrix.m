function [B11, B12, B22] = generate_invmatrix(I, alpha, h)

D = [0, -1, 0; 0,0,0; 0,1,0]/2; %%% partial derivative 
M = [1, 0, -1; 0,0,0;-1,0,1]/4; %%% mixed partial derivatives
F = [0, 0, 0; 0,1,1;0,1,1]/4; %%% average
D2 =  [0, 1, 0; 0,-2,0;0,1,0]; %%% partial derivative
H = [1, 1, 1; 1,0,1;1,1,1]; 

[r,c]=size(I);

cmtx = imfilter(ones(size(I)), H/(h*h), 'same');

A11 = I.*(imfilter(I, D2/(h*h), 'replicate',  'same')-2*I/(h*h)) - alpha*cmtx; 
A22 = I.*(imfilter(I, D2'/(h*h), 'replicate',  'same')-2*I/(h*h)) - alpha*cmtx; 
A12 = I.*imfilter(I, M/(h*h), 'replicate',  'same'); 
    
DetA = A11.*A22-A12.*A12;

B11 = A22./DetA;
B12 = -A12./DetA;
B22 = A11./DetA;





% D = [0, 0, 0; 0,-1,0;0,1,0]; %%% partial derivative 
% M = [0, 0, 0; 0,1,-1;0,-1,1]; %%% mixed partial derivatives
% F = [0, 0, 0; 0,1,1;0,1,1]/4; %%% average
% D2 =  [0, 1, 0; 0,-2,0;0,1,0]; %%% partial derivative
% H = [1, 1, 1; 1,0,1;1,1,1]; 
% 
% [r,c]=size(I);
% 
% cmtx = imfilter(ones(size(I)), H, 'same');
% 
% A11 = I.*(imfilter(I, D2, 'replicate',  'same') - ... 
%     2*imfilter(I, D, 'replicate',  'same') - 2*I) - alpha*cmtx;
% A22 = I.*(imfilter(I, D2', 'replicate',  'same') - ... 
%     2*imfilter(I, D', 'replicate',  'same') - 2*I) - alpha*cmtx;
% A12 = I.*(imfilter(I, M, 'replicate',  'same') - ... 
%     imfilter(I, D, 'replicate', 'same')-imfilter(I, D', 'replicate', 'same') + I);
% 
% DetA = A11.*A22-A12.*A12;
% 
% B11 = A22./DetA;
% B12 = -A12./DetA;
% B22 = A11./DetA;
% 
