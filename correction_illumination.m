function [I1,I2] = correction_illumination(Im1,Im2,window_shifting,size_average)


Im1=double(Im1);
Im2=double(Im2);

I1=Im1;
I2=Im2;

% adjusting the overall illumination change    
x3=window_shifting(1);
x4=window_shifting(2);
y3=window_shifting(3);
y4=window_shifting(4);

I1_mean=mean(mean(I1(y3:y4,x3:x4)));
I2_mean=mean(mean(I2(y3:y4,x3:x4)));
R12=I1_mean/I2_mean;
I2=R12*I2;            


% normalize the intensity for I2 to eliminate the local change of illumination light
if size_average>0
    N=size_average;
    %N=30; % size for averaging
    h=ones(N,N)/(N*N);
    I12F=filter2(h,I1)-filter2(h,I2);
    I2=I2+I12F;
elseif size_average==0
    I2=I2;
end
    








