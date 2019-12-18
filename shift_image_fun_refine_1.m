function [Im1_shift,uxI,uyI]=shift_image_fun_refine_1(ux,uy,Im1,Im2)

% ux and uy are the initial velocity fields in pixels/unit time in coarse image
% Im1 and Im2 are finer images at the times 1 and 2
% uxI and uyI are the interpolated velocity fields in pixels/unit time in finer image
% cut_vaule is the value of displacement between uses of the direct shift
% method and optical flow shift method (such as 5 pixels) 
% Im1_shite is the shifted image from Im1 based on uxI and uyI

Im1=double(Im1);
Im2=double(Im2);
ux=double(ux);
uy=double(uy);


[m0,n0]=size(ux);
% normalized size of coarse image
x0_normalized=[1:n0]/n0;
y0_normalized=[1:m0]/m0;
[X,Y] = meshgrid(x0_normalized,y0_normalized);

[m1,n1]=size(Im1);
% normalized size of finer image
x1_normalized=[1:n1]/n1;
y1_normalized=[1:m1]/m1;

% obtain interpolated velocity field in the finer image
[XI,YI] = meshgrid(x1_normalized,y1_normalized);
% uxI = (n1/n0)*interp2(X,Y,ux,XI,YI); % pixels/unit time in finer image
% uyI = (m1/m0)*interp2(X,Y,uy,XI,YI); % pixels/unit time in finer image

uxI = (n1/n0)*imresize(ux,[length(y1_normalized) length(x1_normalized)]); % pixels/unit time in finer image
uyI = (m1/m0)*imresize(uy,[length(y1_normalized) length(x1_normalized)]); % pixels/unit time in finer image


% generate a shifted image from Im1 based on the velocity field that is
% rounded

Im1_shift0=Im2;
for i=1:m1
    for j=1:n1
        i_shift=i+round(uyI(i,j));
        j_shift=j+round(uxI(i,j));
        if (i_shift<=m1) && (i_shift >=1) && (j_shift<=n1) && (j_shift>=1)
            Im1_shift0(i_shift,j_shift)=Im1(i,j);           
        else
            Im1_shift0(i,j)=Im1(i,j);
        end
    end
end


Im3=Im1_shift0;
Im1_shift1=Im3;
duxI=uxI-round(uxI);
duyI=uyI-round(uyI);

mask_size=10;
std=0.6*mask_size;
H1=fspecial('gaussian',mask_size,std);
duxI=imfilter(duxI,H1);
duyI=imfilter(duyI,H1);


dx=1;
dy=1;
dt=1;

for i=1:(m1-1)
    for j=1:(n1-1)
          term1(i,j)=(Im3(i,j+dx)*duxI(i,j+dx)-Im3(i,j)*duxI(i,j))/dx;
          term2(i,j)=(Im3(i+dy,j)*duyI(i+dy,j)-Im3(i,j)*duyI(i,j))/dy;   
          Im1_shift1(i,j)=Im3(i,j)-(term1(i,j)+term2(i,j))*dt;
    end
end


Im1_shift=uint8(Im1_shift1);





