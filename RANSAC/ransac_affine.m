% Ransac implementation to find the affine transformation between two images.
% Input:
%       match1 - set of point from image 1
%       match2 - set of corresponding points from image 2
%       im1    - the first image
%       im2    - the second image
% Output:
%       best_h - the affine affine transformation matrix

function best_h = ransac_affine(match1, match2)
    iterations = 100; 
    miniterations = 5;
    threshold = 10;
    P = 3;
    bestinliers = 0;
    best_h      = zeros(6,1);

    index=1;
    while ((index<iterations) || (index<miniterations))
        perm = randperm(size(match1, 2));
        seed = perm(1:P);
        points = [match1(:, seed(1)) match1(:, seed(2)) match1(:, seed(3))];
        A = [];
        for i=1:size(points, 2)
            x = [points(1,i) points(2,i) 0 0 1 0 ; 0 0 points(1,i) points(2,i) 0 1];
            A = [A ; x];
        end

        b = [ match2(1, seed(1)) match2(2, seed(1)) match2(1, seed(2)) match2(2, seed(2)) match2(1, seed(3)) match2(2, seed(3))];
        h = pinv(A)* b';
        A = [];
        for i=1:size(match1, 2)
            x = [match1(1,i) match1(2,i) 0 0 1 0 ; 0 0 match1(1,i) match1(2,i) 0 1];
            A = [A ; x];
        end
            
        bprime = A*h;
        bprime = reshape(bprime, [2, length(bprime)/2]);        
        
        distances = zeros(size(match1,2),1);
        for i=1:size(match1,2)
            distances(i) = sqrt( (bprime(1,i)-match2(1,i))^2 + (bprime(2,i) - match2(2,i))^2);
        end
        inliers = find(distances<threshold);
        
        if size(bestinliers,1) < size(inliers,1)
            bestinliers = inliers;
            best_h = h;
        end    
        index = index+1;
    end
end
