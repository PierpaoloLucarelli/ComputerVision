% Function [bestF bestinliers] = estimateFundamentalMatrix(match1, match2)
% Estimate the fundamental matrix (F)
%
% Input: 
%           - match1: matched points from the first images
%           - match２: matched points from the second images
% Output: 
%           - bestF: estimated F 
%           - bestinliers: inliers found
          
function [bestF, bestinliers] = estimateFundamentalMatrix(match1, match2)

    % Set in homogenous coordinates
    match1 = [match1;ones(1,size(match1,2))];
    match2 = [match2;ones(1,size(match2,2))];

    % Initialize parameters
    bestcount = 0;
    bestinliers = [];

    % Initialize RANSAC parameters
    % Total iterations (e.g. 50)
    iterations = 50;

    % Minimum of iterations
    miniter = 5;

    % How many points are needed for the Fundamental matrix?
    p= 8;

    % Start iterations
    i=0;
    while i<iterations
        
        % Randomly select P points from two sets of matched points.
        % Keep only the first two dimensions: x, y.
        perm = randperm(size(match1, 2));
        seed = perm(1:p);
        points1 =   [   match1(1:2, seed(1)) match1(1:2, seed(2)) match1(1:2, seed(3)) ...
                        match1(1:2, seed(4)) match1(1:2, seed(5)) match1(1:2, seed(6)) ...
                        match1(1:2, seed(7)) match1(1:2, seed(8))
                    ];
                
        points2 =   [   match2(1:2, seed(1)) match2(1:2, seed(2)) match2(1:2, seed(3)) ...
                        match2(1:2, seed(4)) match2(1:2, seed(5)) match2(1:2, seed(6)) ...
                        match2(1:2, seed(7)) match2(1:2, seed(8))
                    ];        
        
        % Normalization
        [X1,T1] = normalize(points1);
        [X2,T2] = normalize(points2);
        
        % Compose matrix A, given matched points (X1,X2) from two images
        A = composeA(X1, X2);
        
        % Compute F given A, T1 and T2    
        F = computeF(A,T1,T2);
        
        % Find inliers by computing perpendicular errors between the points 
        % and the epipolar lines in each image
        inliers = computeInliers(F,match1,match2, 50);
        
        % Check if the number of inliers is larger than 8
        % If yes, use those inliners to re-estimate (re-fine) F.    
        if size(inliers,2)>=8
            % Normalize previously found inliers
            [X1,T1] = normalize(match1(1:2,inliers));
            [X2,T2] = normalize(match2(1:2,inliers));
            
            % Use inliers to re-estimate F
            A = composeA(X1, X2);
            F = computeF(A,T1,T2);
            
            % Find the final set of inliers
            inliers = computeInliers(F,match1,match2,50);
            
            % if number of inlier > the best so-far, use new F
            if size(inliers,2)>bestcount
                bestcount   = size(inliers, 2);
                bestF       = F;
                bestinliers = inliers;
            end
            
            % Calculate how many iterations we need by computing:
            % i=log(eps)/log(1-q^p),
            % where p=8 (the number of matches)
            % q= #inliers/#total_pairs (the proportion of inliers over total pairs)
            eps = 0.001;
            N1  = size(inliers,2);
            N   = size(match1, 2);
            q   = N1/N;
            it = log(eps)/log(1-q^p);
            % To prevent special cases, always run at least a couple of times
            iterations = max(miniter, ceil( it ));
            
        end
        i = i+1;
end
    
    disp(strcat(int2str(iterations), ' iterations used to estimate F'));
    pause(0.001);
    disp(strcat(int2str(size(bestinliers,2)), ' inliers found'));
end





