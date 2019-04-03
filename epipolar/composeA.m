% function A = composeA(x1, x2)
% Compose matrix A, given matched points (X1,X2) from two images
% Input: 
%   -normalized points: X1 and X2 
% Output: 
%   -matrix A
function A = composeA(x1, x2)
    n = size(x1, 2);
    A = zeros(n,9);
    for i=1:size(x1, 2)
        A(i,:) = [x1(1,i)*x2(1,i) x1(1,i)*x2(2,i) x1(1,i) x1(2,i)*x2(1,i) x1(2,i)*x2(2,i) x1(2,i) x2(1,i) x2(2,i) 1];
    end
end
