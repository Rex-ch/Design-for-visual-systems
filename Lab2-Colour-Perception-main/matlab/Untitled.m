I = rgb2gray(RGB);
figure              % start a new figure window
imshowpair(RGB, I, 'montage')
title('Original colour image (left) grayscale image (right)');
[R,G,B] = imsplit(RGB);
montage({R, G, B},'Size',[1 3])

HSV = rgb2hsv(RGB);
[HSV] = imsplit(HSV);
montage({H,S,V}, 'Size', [1 3])

XYZ = rgb2xyz(RGB);

{[X,Y,Z] = imsplit(XYZ);
montage({X,Y,Z}, 'Size', [1 3])