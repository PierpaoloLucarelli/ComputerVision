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
        % Load next image
        imnew = ...
    
        % Get transformation of this new image to previous image
	best_h = ...
	
	% Define the transformation matrix from 'best_h' (best affine parameters) 	
        A(:,:,i) = ...
    
        % Combine the affine transformation with all previous matrices
        % to get the transformation to the first image
        accA(:,:,i) = A(:,:,i) * accA(:,:,i-1);
    
        % Add the corners of this image
        w = size(imnew,2);
        h = size(imnew,1);
        corners = [corners (accA(:,:,i))*[1 1 1; w 1 1; 1 h 1; w h 1]'];
    end

    % Find size of output image
    minx = ...
    maxx = ...
    miny = ...
    maxy = ...

    % Output image
    imgout = zeros(maxy-miny+1, maxx-minx+1, nargin);

    % Output image coordinate system
    xdata = [minx, maxx];
    ydata = [miny, maxy];

    % Transform each image to the coordinate system
    for i=1:nargin
        tform         = ...
        newtimg       = imtransform(...
        imgout(:,:,i) = newtimg;
    end

    % Blending methods to combine: nanmedian (stable for longer sequences of images)
    imgout = nanmean();

    % Show stitched image
    figure; imshow(imgout);
end
