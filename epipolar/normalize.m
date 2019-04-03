% Function [Xout, T] = normalize( X )
% Normalize all the points in each image
% Input
%     -X: a matriX with 2D inhomogeneous X in each column.
% Output: 
%     -Xout: a matriX with (2+1)D homogeneous X in each column;
%     -matrix T: normalization matrix
function [Xout, T] = normalize( X )

    % Compute Xmean: normalize all X in each image to have 0-mean
    Xmean =  mean(X,2);

    % Compute d: scale all X so that the average distance to the mean is sqrt(2).
    % Check the lab file for details.
    d = 0;
    n = size(X, 2);
    for i=1:size(X, 2)
        d = d + sqrt((X(1,i)-Xmean(1))^2 + (X(2,i)-Xmean(2))^2);
    end

    % Compose matrix T
    sq2d = sqrt(2)/d;
    T = [   sq2d 0 -Xmean(1)*sq2d ; ...
            0 sq2d -Xmean(2)*sq2d ; ...
            0 0 1
        ];
		
    % Compute Xout using X^ = TX with one extra dimension (We are using homogenous coordinates)
    Xout = T * [X; ones(1,size(X,2))];
end
