im1 = rgb2gray(imread('left.jpg'));
im2 = rgb2gray(imread('right.jpg'));

% im1 = imread('./boat/img1.pgm');
% im2 = imread('./boat/img2.pgm');
% im3 = imread('./boat/img3.pgm');
% im4 = imread('./boat/img4.pgm');
% im5 = imread('./boat/img5.pgm');
% im6 = imread('./boat/img6.pgm');

im1 = imresize(rgb2gray(imread('./aula/1.JPG')), 0.25);
im2 = imresize(rgb2gray(imread('./aula/2.JPG')), 0.25);
im3 = imresize(rgb2gray(imread('./aula/3.JPG')), 0.25);
im4 = imresize(rgb2gray(imread('./aula/4.JPG')), 0.25);
im5 = imresize(rgb2gray(imread('./aula/5.JPG')), 0.25);

mosaic(im1, im2, im3, im4, im5);
% mosaic(im1, im2);
