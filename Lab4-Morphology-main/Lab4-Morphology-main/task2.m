clear all
close all
f = imread('assets/fingerprint-noisy.tif');
SE = strel("square",3);
fe = imerode(f,SE);
fed = imdilate(fe, SE);
fo = imopen(f,SE);
montage({f,fe,fed,fo},'Size', [1 4]);
fo_ = imclose(fo,SE);
imshow(fo_);

w_gauss = fspecial('Gaussian', [7 7], 1.0);
g_gauss = imfilter(f, w_gauss, 0);
figure
imshow(g_gauss)