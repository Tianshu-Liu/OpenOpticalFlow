
% calculate the velocity magnitude
u_mag=(ux.^2+uy.^2).^0.5;
u_max=max(max(u_mag));
u_mag=u_mag/u_max;

% calculate vorticity
vor=vorticity(ux, uy);
vor_max=max(max(abs(vor)));
vor=vor/vor_max;


% calculate the 2nd invariant
Q=invariant2_factor(ux, uy, 1, 1);


% plot velocity magnitude field
figure(20);
ulims=[0, 1];
imagesc(u_mag,ulims);
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Velocity Magnitude Field');
colorbar;
hold on;

% plot streamlines
figure(20);
[m,n]=size(ux);
[x,y]=meshgrid(1:n,1:m);
dn=10;
dm=10;
[sx,sy]=meshgrid(1:dn:n,1:dm:m);
h=streamslice(x, y, ux, uy, 4);
set(h, 'Color', 'yellow');
hold off;


% plot Vorticity field
figure(21);
vlims=[-1, 1];
imagesc(vor,vlims);
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Vorticity Field');
colorbar;
hold on;

% plot streamlines
figure(21);
[m,n]=size(ux);
[x,y]=meshgrid(1:n,1:m);
dn=10;
dm=10;
[sx,sy]=meshgrid(1:dn:n,1:dm:m);
h=streamslice(x, y, ux, uy, 4);
set(h, 'Color', 'blue');
hold off;


% plot Vorticity field
figure(22);
vlims=[-1, 1];
imagesc(vor,vlims);
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Vorticity Field');
colorbar;
hold on;

% Plot  refined  velocity vector field
figure(22);
gx=50; offset=1;
h = vis_flow (ux, uy, gx, offset, 3, 'm');
set(h, 'Color', 'black');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
hold off;

% plot Vorticity field
figure(23);
vlims=[0, 1];
imagesc(u_mag,vlims);
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Velocity Magnitue Field');
colorbar;
hold on;

% Plot  refined  velocity vector field
figure(23);
gx=50; offset=1;
h = vis_flow (ux, uy, gx, offset, 3, 'm');
set(h, 'Color', 'black');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
hold off;


% plot Q field
figure(24);
Qlims=[0, 0.1];
imagesc(Q,Qlims);
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Q Field');
colorbar;








