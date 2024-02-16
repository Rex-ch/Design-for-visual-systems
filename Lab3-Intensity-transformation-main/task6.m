clear all
close all
I = imread('assets/moon.tif');

%----Laplacian filter
w_laplacian = fspecial('laplacian', 0.1)
g_laplacian = imfilter(I, w_laplacian, 0);
Limage = I + g_laplacian
figure

%----Sober filter
% Create Sobel filter for horizontal and vertical edge detection
SH = fspecial('sobel'); % Detects horizontal edges
SV = SH'; % Detects vertical edges

% Apply the Sobel filter to the grayscale image
horizontalEdges = imfilter(double(I), SH, 'replicate');
verticalEdges = imfilter(double(I), SV, 'replicate');

% Combine the horizontal and vertical edges
edges = sqrt(horizontalEdges.^2 + verticalEdges.^2);

% Convert edges to uint8 for montage display if needed
edges = im2uint8(mat2gray(edges));


%----Unsharp filter 
% Create an unsharp masking filter
unsharpFilter = fspecial('unsharp');

% Apply the unsharp filter to the image
sharpenedImage = imfilter(I, unsharpFilter, 'replicate');

montage({I, Limage, edges, sharpenedImage}, "size", [1 4]);


