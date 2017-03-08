function [I1,I2] = pre_processing_a(Im1,Im2,scale_im,size_filter)


Im1=double(Im1);
Im2=double(Im2);

I1=Im1;
I2=Im2;

I1=imresize(I1,scale_im);
I2=imresize(I2,scale_im);


% applying a Gaussian filter to images
mask_size=size_filter;
%mask_size=4;
std=mask_size*0.62;
H1=fspecial('gaussian',mask_size,std);
H2=fspecial('gaussian',mask_size,std);
I1=(imfilter(I1,H1)+imfilter(I1,H2))/2;
I2=(imfilter(I2,H1)+imfilter(I2,H2))/2;











