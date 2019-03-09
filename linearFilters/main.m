imIn = imread('zebra.png');
imOut = gaussianConv(imIn, 3, 3);
imshow(imOut);

%%
[mag, orientation]= gradmag(imIn, 2);
i = rescale(mag, 0, 255);
imshow(uint8(i));
imshow(orientation , [-pi,pi]);
colormap(hsv);
colorbar;