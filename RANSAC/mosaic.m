% Stitch multiple images in sequence
% Can be used as mosaic(im1,im2,im3,...);
% Input:
%       varargin - sequence of images to stitch
% Output:
%       imgout - stitched images
function imgout = mosaic(varargin)
    
    % Begin with first image
    imtarget = varargin{1};
    % Find the image corners
    w = size(imtarget,2);
    h = size(imtarget,1);
    corners = [1 1 1; w 1 1; 1 h 1; w h 1]';

    % First image is not transformed
    A        = zeros(3, 3, nargin);
    A(:,:,1) = eye(3);
    accA     = A;

    % For all other images
    for i = 2:nargin
        imnew = varargin{i};
        [best_h , ~, ~] = imageAlign(imnew, imtarget);
        A(:,:,i) = best_h;
        accA(:,:,i) = A(:,:,i) * accA(:,:,i-1);
    
        w = size(imnew,2);
        h = size(imnew,1);
        corners = [corners (accA(:,:,i))*[1 1 1; w 1 1; 1 h 1; w h 1]'];
        imtarget = imnew;
    end
    
    corners(1,:) = corners(1,:) + max(0, -min(corners(1,:)-1)); 
    corners(2,:) = corners(2,:) + max(0, -min(corners(2,:)-1)); 
    
    minx = min(corners(1, :));
    maxx = max(corners(1, :));
    miny = min(corners(2, :));
    maxy = max(corners(2, :));
   
    imgout = zeros(ceil(maxy-miny), ceil(maxx-minx), nargin);
    topleft = ceil(corners(1:2, 1:4:end));
    topright = ceil(corners(1:2, 2:4:end));
    bottomleft = ceil(corners(1:2, 3:4:end));
    
    for i=1:nargin
        y_offset = min(topleft(2, i), topright(2, i));
        x_offset = min(topleft(1, i), bottomleft(1, i));
        tform         = affine2d(accA(:,:,i)');
        newtimg       = imwarp(varargin{i}, tform, 'bicubic'); 
        imgout(y_offset:y_offset+size(newtimg,1)-1, x_offset:x_offset+size(newtimg, 2)-1, i) = newtimg;
    end
    imgout = nanmax(imgout,[], 3);
    figure; imshow(uint8(imgout));
end
