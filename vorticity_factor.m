function [omega]=vorticity_factor(Vx, Vy, factor_x, factor_y)
% factor_x: converting factor from pixel to m (m/pixel) in x
% factor_y: converting factor from pixel to m (m/pixel) in y

% Vx = imfilter(Vx, [1 1 1 1 1]'*[1 1 1 1 1]/25,'symmetric');
% Vy = imfilter(Vy, [1 1 1 1 1]'*[1,1 1 1,1]/25,'symmetric');

dx=1;
D = [0, -1, 0; 0,0,0; 0,1,0]/2; %%% partial derivative 
Vy_x = imfilter(Vy, D'/dx, 'symmetric',  'same'); 
Vx_y = imfilter(Vx, D/dx, 'symmetric',  'same');
omega=(Vy_x/factor_x-Vx_y/factor_y);




















