im = imread('landscape-a.jpg');
loc = DoG(im, 0.01);
[r, c, sigmas] = harris(im, loc);
figure;
imshow(im);
hold on;
for k=1:length(sigmas)
  plot(c(k), r(k), 'r*', 'LineWidth', 2, 'MarkerSize', sigmas(k));
end