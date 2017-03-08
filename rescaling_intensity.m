function [I1,I2] = rescaling_intensity(Im1,Im2,max_intensity_value)

Imax1=max(max(Im1));
Imin1=min(min(Im1));
Im1a=(Im1-Imin1)/(Imax1-Imin1);

Imax2=max(max(Im2));
Imin2=min(min(Im2));
Im2a=(Im2-Imin2)/(Imax2-Imin2);

Im1=Im1a*max_intensity_value;
Im2=Im2a*max_intensity_value;

I1=double(Im1);
I2=double(Im2);



