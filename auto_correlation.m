function var = auto_correlation(X, k, sigma)

n = length(X);
m=n-k;
u = mean(X);
sum = 0;
for i = 1:m
    sum = sum + (X(i)-u)*(X(i+k)-u);
end

var = ( 1/(m*sigma^2) )* sum;

end

