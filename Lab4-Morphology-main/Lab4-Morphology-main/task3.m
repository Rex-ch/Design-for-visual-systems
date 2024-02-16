clear all
close all
I = imread('assets/blobs.tif');
I = imcomplement(I);
level = graythresh(I);
A = ones(3,3);     % generate a 3x3 matrix of 1's
BW = imbinarize(I, level);

BWeroded = imerode(BW,A);
boundary = BW - BWeroded
montage({I,BW,BWeroded,boundary},'Size', [1 4]);

BW_o = imopen(BW,A);
boundary2 = BW_o - BWeroded
montage({I,BW,BWeroded,boundary,boundary2},'Size', [1 5]);