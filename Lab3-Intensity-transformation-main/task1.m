clear all
imfinfo('assets/breastXray.tif')
f = imread('assets/breastXray.tif');
imshow(f)

f(3,10)             % print the intensity of pixel(3,10)
imshow(f(1:241,:))  % display only top half of the image

[fmin, fmax] = bounds(f(:))% find the maximum and minimum intensity values of the image
%{ 
bounds returns the maximum and minimum values in the entire image f. 
The index ( : ) means every columns. If this is not specified, 
Matlab will return the max and min values for each column as 2 row vectors.
%}
imshow(f(:,241 : 482)) % Display the right half of the image.
