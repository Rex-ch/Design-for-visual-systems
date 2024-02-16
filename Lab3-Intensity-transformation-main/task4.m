clear all
close all
f = imread('assets/noisyPCB.jpg');
imshow(f)

w_box = fspecial('average', [9 9])
w_gauss = fspecial('Gaussian', [7 7], 1.0)
g_box = imfilter(f, w_box, 0);
g_gauss = imfilter(f, w_gauss, 0);
figure
montage({f, g_box, g_gauss})
%{
% Averaging Filters with Different Kernel Sizes
w_box_small = fspecial('average', [3 3]);
w_box_medium = fspecial('average', [5 5]);
w_box_large = fspecial('average', [15 15]);

% Applying averaging filters to the image
g_box_small = imfilter(f, w_box_small, 0);
g_box_medium = imfilter(f, w_box_medium, 0);
g_box_large = imfilter(f, w_box_large, 0);

% Displaying the original and averaging filtered images
figure;
montage({f, g_box_small, g_box_medium, g_box_large}, 'Size', [1 4]);
title('Original and Averaging Filtered Images');

% Gaussian Filters with Different Sigma Values
w_gauss_small = fspecial('Gaussian', [7 7], 0.5);
w_gauss_medium = fspecial('Gaussian', [7 7], 1.5);
w_gauss_large = fspecial('Gaussian', [7 7], 3.0);

% Applying Gaussian filters to the image
g_gauss_small = imfilter(f, w_gauss_small, 0);
g_gauss_medium = imfilter(f, w_gauss_medium, 0);
g_gauss_large = imfilter(f, w_gauss_large, 0);

% Displaying the original and Gaussian filtered images
figure;
montage({f, g_gauss_small, g_gauss_medium, g_gauss_large}, 'Size', [1 4]);
title('Original and Gaussian Filtered Images');
%}
