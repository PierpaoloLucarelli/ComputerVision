imIn = imread('zebra.png');
imOut = gaussianConv(imIn, 3, 3);
imshow(imOut);