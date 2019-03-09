function imOut = gaussianConv(img, sigmax, sigmay)
    img = rgb2gray(img);
    sigmas = [sigmax, sigmay];
    for i=1:2
        gauss = gaussian(sigmas(i));
        s = size(gauss, 2);
        kernel = zeros(s, s);
        kernel(floor(s/2)+1, :) = gauss(:,:);
        if(i == 2)
            kernel = kernel.';
        end
        img = conv2(img, kernel);
    end
    imOut = uint8(img);
end