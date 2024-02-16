clear all
close all
f = imread('assets/fingerprint.tif');
f = imcomplement(f);
level = graythresh(f);
BW = imbinarize(f, level);

for n = 1:5
    % Apply thinning operation with n iterations
    g = bwmorph(BW, 'thick', n);
    
    % Create a subplot for each thinned image
    subplot(1, 5, n); % Arranges plots in 1 row, 5 columns
    imshow(g); % Display the thinned image
    title(['n = ', num2str(n)]); % Title each subplot with the iteration number
end

sgtitle('Thickening Operations with Different Iterations'); % Super title for the whole figure