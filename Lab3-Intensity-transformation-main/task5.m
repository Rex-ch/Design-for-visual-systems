clear all
close all
f = imread('assets/noisyPCB.jpg');
imshow(f)
g_median = medfilt2(f, [7 7], 'zero');
figure; montage({f, g_median})