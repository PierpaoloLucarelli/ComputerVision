% Ransac implementation to find the affine transformation between two images.
% Input:
%       match1 - set of point from image 1
%       match2 - set of corresponding points from image 2
%       im1    - the first image
%       im2    - the second image
% Output:
%       best_h - the affine affine transformation matrix

function best_h = ransac_affine(match1, match2, im1, im2)
    % Iterations is automatically changed during runtime
    % based on inlier-count. Set min-iterations (e.g. 5 iterations) to circumvent corner-cases
    iterations = 50 
    miniterations = 5 % Minimum iterations after which to stop, can be made larger

    % Threshold: the 10 pixels radius
    threshold = 10

    % The model needs at least ? point pairs (? equations) to form an affine transformation
    P = ...

    % Start the RANSAC loop
    bestinliers = 0;
    best_h      = zeros(?,1);

    i=1;
    while ((i<iterations) || (i<miniterations))
        % (1) Pick randomly P matches
        perm = ...
        seed = ...

        % (2) Construct matrices A, h, b    


        % (3) Fit model h over the matches


        % (4) Transform all points from image1 to their counterpart in image2. Plot these correspondences.
        figure; imshow([im1 im2]); hold on;

        match1transformed = ...

        line([match1(1,seed); size(im1,2)+match1t(1,:)],...
             [match1(2,seed);             match1t(2,:)]);
        title('Image 1 and 2 with the original points and their transformed counterparts in image 2');
    
        % (5) Determine inliers using the threshold and save the best model
        inliers = ...

        % (6) Save the best model and redefine the stopping iterations
        if size(bestinliers,1) < size(inliers,1)
            bestinliers = ...
            best_h = ...
        end    
        
        % Solve for i in the assignment description. 
        iterations = ...

        i = i+1;
    end
end
