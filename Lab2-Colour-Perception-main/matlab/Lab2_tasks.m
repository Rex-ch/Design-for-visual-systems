imfinfo('peppers.png')

%display RGB
RGB = imread('peppers.png');  
imshow(RGB)



%convert the RGB image into a grayscale image
I = rgb2gray(RGB);
figure              % start a new figure window
imshowpair(RGB, I, 'montage')
title('Original colour image (left) grayscale image (right)');

%Splitting an RGB image into separate channels
[R,G,B] = imsplit(RGB);
montage({R, G, B},'Size',[1 3]);

%Map RGB image to HSV space and into separate channels
HSV = rgb2hsv(RGB);
[H,S,V] = imsplit(HSV);
montage({H,S,V}, 'Size', [1 3]);

%Map RGB image to XYZ space
XYZ = rgb2xyz(RGB);
[X,Y,Z] = imsplit(XYZ);
imshowpair(RGB, XYZ, 'montage')
montage({X,Y,Z}, 'Size', [1 3]);

