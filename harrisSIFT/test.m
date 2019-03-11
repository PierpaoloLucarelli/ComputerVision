im = imread('landscape-a.jpg');
im2 = imread('landscape-b.jpg');
loc = DoG(im, 0.01);
% [r, c, sigmas] = harris(im, loc);
% figure;
% imshow(im);
% hold on;
% for k=1:length(sigmas)
%   plot(c(k), r(k), 'r*', 'LineWidth', 2, 'MarkerSize', sigmas(k));
% end

[m1, m2] = findMatches(im, im2, 0.8);
