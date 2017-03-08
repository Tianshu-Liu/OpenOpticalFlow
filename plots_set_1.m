

%% Show the pre-processed images in initial estimation
figure(1);
%clims=[1 250];
%imagesc(uint8(I_region1),clims);
imagesc(uint8(I_region1));
colormap('gray')
axis('image')
title('Downsampled Image 1');
xlabel('x (pixels)');
ylabel('y (pixels)');

figure(2);
%imagesc(uint8(I_region2),clims);
imagesc(uint8(I_region2));
colormap('gray')
axis('image')
title('Downsampled Image 2');
xlabel('x (pixels)');
ylabel('y (pixels)');


% plot initial velocity vector field and streamlines
figure(3);
gx=30; offset=1;
h = vis_flow (ux0, uy0, gx, offset, 3, 'm');
set(h, 'Color', 'red');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Coarse-Grained Velocity Field');


% plot streamlines 
figure(4);
[m,n]=size(ux0);
[x,y]=meshgrid(1:n,1:m);
dn=10;
dm=10;
[sx,sy]=meshgrid(1:dn:n,1:dm:m);
h=streamslice(x, y, ux0, uy0, 4);
set(h, 'Color', 'blue');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Coarse-Grained Streamlines');



%% Plot the original images
figure(10);
imagesc(Im1);
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
colormap('gray');
title('Image 1');
xlabel('x (pixels)');
ylabel('y (pixels)');

figure(11);
imagesc(Im2);
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
colormap('gray');
title('Image 2');
xlabel('x (pixels)');
ylabel('y (pixels)');

%% Plot  refined  velocity vector field
figure(12);
gx=50; offset=1;
h = vis_flow (ux, uy, gx, offset, 5, 'm');
set(h, 'Color', 'red');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Refined Velocity Field');


% plot streamlines
figure(13);
[m,n]=size(ux);
[x,y]=meshgrid(1:n,1:m);
dn=10;
dm=10;
[sx,sy]=meshgrid(1:dn:n,1:dm:m);
h=streamslice(x, y, ux, uy, 4);
set(h, 'Color', 'blue');
xlabel('x (pixels)');
ylabel('y (pixels)');
axis image;
set(gca,'YDir','reverse');
title('Refined Streamlines');















