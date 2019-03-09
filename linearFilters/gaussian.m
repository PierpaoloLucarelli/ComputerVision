function f = gaussian(sigma)
    x = linspace(-3*sigma, 3*sigma, 6*sigma+1);
    f = (1/(sigma*sqrt(2*pi))) * exp((-x.^2)/(2*sigma^2));
    f = f/sum(f);
end