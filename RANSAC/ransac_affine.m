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
    iterations = 50; 
    miniterations = 5; % Minimum iterations after which to stop, can be made larger

    % Threshold: the 10 pixels radius
    threshold = 10;

    % The model needs at least ? point pairs (? equations) to form an affine transformation
    P = 3;

    % Start the RANSAC loop
    bestinliers = 0;
    best_h      = zeros(6,1);

    index=1;
    while ((i<iterations) || (i<miniterations))
        % (1) Pick randomly P match1
        perm = randperm(size(match1, 2));
        seed = perm(1:P);
%         points = [match1(:, seed(1)) match1(:, seed(2)) match1(:, seed(3)) match1(:, seed(4)) match1(:, seed(5)) match1(:, seed(6)) match1(:, seed(7)) match1(:, seed(8))];
        points = [match1(:, seed(1)) match1(:, seed(2)) match1(:, seed(3))];
        % (2) Construct matrices A, h, b
        A = [];
        for i=1:size(points, 2)
            x = [points(1,i) points(2,i) 0 0 1 0 ; 0 0 points(1,i) points(2,i) 0 1];
            A = [A ; x];
        end

        b = [ match2(1, seed(1)) match2(2, seed(1)) match2(1, seed(2)) match2(2, seed(2)) match2(1, seed(3)) match2(2, seed(3))];
        
        % (3) Fit model h over the match1
        h = pinv(A)* b';

        % (4) Transform all points from image1 to their counterpart in image2. Plot these correspondences.
        A = [];
        for i=1:size(match1, 2)
            x = [match1(1,i) match1(2,i) 0 0 1 0 ; 0 0 match1(1,i) match1(2,i) 0 1];
            A = [A ; x];
        end
            
        bprime = A*h;
        bprime = reshape(bprime, [2, length(bprime)/2]);        
        % (5) Determine inliers using the threshold and save the best model
        distances = zeros(size(match1,2),1);
        for i=1:size(match1,2)
            distances(i) = sqrt((bprime(1,i)-match2(1,i))^2 + (bprime(2,i) - match2(2,i))^2);
        end
        inliers = find(distances<threshold);

        % (6) Save the best model and redefine the stopping iterations
        if size(bestinliers,1) < size(inliers,1)
            disp("Found better h");
            bestinliers = inliers;
            best_h = h;
        end    
        
        % Solve for i in the assignment description. 
        iterations = 1000;

        index = index+1
    end
end
