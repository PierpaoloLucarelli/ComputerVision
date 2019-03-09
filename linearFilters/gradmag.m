function [mag, or] = gradmag(img, sigma)
    img = rgb2gray(img);
    dgx = gaussianDer(gaussian(sigma), sigma);
    dgy = gaussianDer(gaussian(sigma), sigma);
    xkernel = zeros(length(dgx),length(dgy));
    xkernel(floor((length(dgx)/2)+1), :) = dgx;
    ykernel = xkernel.';
    xGrad = conv2(img, xkernel, 'same');
    yGrad = conv2(img, ykernel, 'same');
    mag = sqrt(xGrad.^2 + yGrad.^2);
    or = atan2(xGrad, yGrad);
end