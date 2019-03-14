% (1) Align two images using the Harris corner point detection and the sift match function.
% (2) Use RANSAC to get the affine transformation
% Input:
%       im1 - first image
%       im2 - second image
% Output:
%       affine_transform - the learned transformation between image 1 and image 2
%       match1           - the corner points in image 1
%       match2           - their corresponding matches in image 2
function [affine_transform, match1, match2] = imageAlign(im1, im2)

    % Load Images
    im1 = im2double(imread('boat/img1.pgm'));
    im2 = im2double(imread('boat/img2.pgm'));

    % Get the set of possible matches between descriptors from two image.
    matches = findMatches(im, im2, 0.8);
    % You can compare with your results with the custom sift implementation. 
    % You are advised to use this implementation for the final project, for more accurate results.
    % Note: You will get 1 bonus point for your own working implementation of the corner point detection and feature matching. 
    [feat1, descriptor1] = vl_sift(single(im1));
    [feat2, descriptor2] = vl_sift(single(im2));
    matches = vl_ubcmatch(descriptor1, descriptor2);

    % Find affine transformation using your own Ransac function
    match1 = feat1(1:2,matches(1,:));
    match2 = feat2(1:2,matches(2,:));
    best_h = ransac_affine(matches1, matches2, im1, im2);

    % Draw both original images with the other image transformed to the first
    % image below it
    figure;
    subplot(2,2,1); imshow(im1); title('Original Image 1');
    subplot(2,2,2); imshow(im2); title('Original Image 2');

    % Define the transformation matrix from 'best_h' (best affine parameters) 
    affine_transform = ...

    % First image transformed
    tform1 = ... 
    im1b   = ...
    subplot(2,2,4); imshow(im1b); title('Image 1 transformed to image 2')

    % Second image transformed
    tform2 = ...
    im2b   = ... 
    subplot(2,2,3); imshow(im2b); title('Image 2 transformed to image 1')
end
