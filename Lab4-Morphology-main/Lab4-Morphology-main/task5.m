t = imread('assets/text.png');
imshow(t)
CC = bwconncomp(t)

numPixels = cellfun(@numel, CC.PixelIdxList);
[biggest, idx] = max(numPixels);
t(CC.PixelIdxList{idx}) = 0;
figure
imshow(t)