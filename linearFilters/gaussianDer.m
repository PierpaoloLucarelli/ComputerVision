function f = gaussianDer(G, sigma)
    x = linspace(-floor(size(G, 2)/2),floor(size(G, 2)/2),size(G, 2));
    f = -(G.*(x./sigma^2));
end