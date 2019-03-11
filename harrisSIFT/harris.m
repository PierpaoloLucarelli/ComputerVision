function [r, c, sigmas] = harris(im, loc)
    % inputs: 
    % im: double grayscale image
    % loc: list of interest points from the Laplacian approximation
    % outputs:
    % [r,c,sigmas]: The row and column of each point is returned in r and c
    %              and the sigmas 'scale' at which they were found
    
    % Calculate Gaussian Derivatives at derivative-scale. 
    % NOTE: The sigma is independent of the window size (which dependes on the Laplacian responses).
    % Hint: use your previously implemented function in assignment 1 
    s = 1;
    im = rgb2gray(im);
    G = gaussian(1);
    Ix =  conv2(im, gaussianDer(G, s), 'same'); 
    Iy =  conv2(im, gaussianDer(G, s)', 'same'); 

    % Allocate an 3-channel image to hold the 3 parameters for each pixel
    init_M = zeros(size(Ix,1), size(Ix,2), 3);

    % Calculate M for each pixel
    init_M(:,:,1) = Ix.^2;
    init_M(:,:,2) = Iy.^2;
    init_M(:,:,3) = Ix.*Iy;

    % Allocate the size of R 
    R = zeros(size(im, 1), size(im, 2));

    % Smooth M with a gaussian at the integration scale sigma.
    % Keep only points from the list 'loc' that are coreners. 
    for l = 1 : size(loc,1)
        sigma = loc(l,3); % The sigma at which we found this point	

	% The response accumulation over a window of size 'sigma'
        if ((l>1) && sigma~=loc(l-1,3)) || (l==1)
            M = imfilter(init_M, fspecial('gaussian', ceil(sigma*6+1), sigma), 'replicate', 'same');
        end
        m = [M(loc(l, 2), loc(l,1),1) M(loc(l, 2), loc(l,1),3) ; M(loc(l, 2), loc(l,1),3) M(loc(l, 2), loc(l,1),2)];
        % Compute the cornerness R at the current location location
        trace_l = trace(m);
        det_l = det(m);
        R(loc(l,2), loc(l,1), 1) = det_l-(0.04*(trace_l)^2);

    	% Store current sigma as well
        R(loc(l,2), loc(l,1), 2) = sigma;

    end
    % Display corners
%     figure
%     imshow(R(:,:,1),[0,1]);

    % Set the threshold 
    threshold = max(max(R(:,:,1)))*0.01;

    % Find local maxima
    % Dilation will alter every pixel except local maxima in a 3x3 square area.
    % Also checks if R is above threshold
    R(:,:,1) = ((R(:,:,1)>threshold) & ((imdilate(R(:,:,1), strel('square', 3))==R(:,:,1)))); 
       
    % Return the coordinates r, c and sigmas
    r = []
    c = []
    sigmas = []
    for i=1:size(R,1)
        for j=1:size(R,2)
            if(R(i,j,1) == 1)
                r = [r i];
                c = [c j];
                sigmas = [sigmas R(i,j,2)];
        end
    end
    
end
