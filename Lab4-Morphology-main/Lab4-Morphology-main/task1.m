A = imread('assets/text-broken.tif');
B1 = [0 1 0;
     1 1 1;
     0 1 0];    % create structuring element
B2 = ones(3,3);     % generate a 3x3 matrix of 1's
Bx = [1 0 1;
      0 1 0;
      1 0 1]; %Try to make the SE diagonal cross
A1 = imdilate(A, B1);
A2 = imdilate(A, B2);
A3 = imdilate(A, Bx);
A4 = imdilate(A1, B1);%dilate twice
montage({A,A1,A2,A3},'Size', [1 4])
%montage({A1,A4})
