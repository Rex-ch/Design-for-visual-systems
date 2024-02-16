%{
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
%}

%{
g1 = imadjust(f, [0 1], [1 0])
figure                          % open a new figure window
imshowpair(f, g1, 'montage')
%}

%{ 
The 2nd parameter of imadjust is in the form of [low_in high_in], 
where the values are between 0 and 1. 
[0 1] means that the input image is to be adjusted to within 1% 
of the bottom and top pixel values.
This of course means that all intensities are inverted, producing the negative image.
%}
%{
g2 = imadjust(f, [0.5 0.75], [0 1]);
g3 = imadjust(f, [ ], [ ], 2);
figure
montage({g2,g3})% function montage stitches together images in the list specified within { }.
% g2 has the gray scale range between 0.5 and 0.75 mapped to the full range.
% g3 uses gamma correct with gamma = 2.0 as shown in the diagram below. [ ] is the same as [0 1] by default.
%}
%{
clear all       % clear all variables
close all       % close all figure windows
f = imread('assets/bonescan-front.tif');
r = double(f);  % uint8 to double conversion
k = mean2(r);   % find mean intensity of image
E = 0.9;
s = 1 ./ (1.0 + (k ./ (r + eps)) .^ E);% compute the contrast stretched image by applying the stretch function element-by-element
% result is tored in s, intensity values of s are normalized to the range of [0.0 1.0] and is in type double
g = uint8(255*s); % scale this back to the range [0 255] and covert back to uint8.
imshowpair(f, g, "montage")
%}
clear all       % clear all variable in workspace
close all       % close all figure windows
f=imread('assets/pollen.tif');
imshow(f)
figure          % open a new figure window
imhist(f);      % calculate and plot the histogram

close all
g=imadjust(f,[0.3 0.55]);
montage({f, g})     % display list of images side-by-side
figure
imhist(g);

g_pdf = imhist(g) ./ numel(g);  % compute PDF
g_cdf = cumsum(g_pdf);          % compute CDF
close all                       % close all figure windows
imshow(g);
subplot(1,2,1)                  % plot 1 in a 1x2 subplot
plot(g_pdf)
subplot(1,2,2)                  % plot 2 in a 1x2 subplot
plot(g_cdf)

x = linspace(0, 1, 256);    % x has 256 values equally spaced
                            %  .... between 0 and 1
figure
plot(x, g_cdf)
axis([0 1 0 1])             % graph x and y range is 0 to 1
set(gca, 'xtick', 0:0.2:1)  % x tick marks are in steps of 0.2
set(gca, 'ytick', 0:0.2:1)
xlabel('Input intensity values', 'fontsize', 9)
ylabel('Output intensity values', 'fontsize', 9)
title('Transformation function', 'fontsize', 12)

h = histeq(g,256);              % histogram equalize g
close all
montage({f, g, h})
figure;
subplot(1,3,1); imhist(f);
subplot(1,3,2); imhist(g);
subplot(1,3,3); imhist(h);