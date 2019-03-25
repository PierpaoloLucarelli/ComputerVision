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
    [feat1, descriptor1] = vl_sift(single(im1));
    [feat2, descriptor2] = vl_sift(single(im2));
    matches = vl_ubcmatch(descriptor1, descriptor2);
    match1 = feat1(1:2,matches(1,:));
    match2 = feat2(1:2,matches(2,:));
    best_h = ransac_affine(match1, match2);
    affine_transform = [best_h(1) best_h(2) best_h(5) ; best_h(3) best_h(4) best_h(6) ; 0 0 1];
end
