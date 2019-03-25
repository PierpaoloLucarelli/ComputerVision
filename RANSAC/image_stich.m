function img = image_stich(im1, im2)
    im1 = rgb2gray(imread('left.jpg'));
    im2 = rgb2gray(imread('right.jpg'));
    [trans, match1, match2] = imageAlign(im1, im2); 
end