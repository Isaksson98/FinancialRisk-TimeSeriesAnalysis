function gamma = calc_moment(u, sigma, k)

n = length(u);
sum = 0;

for i = 1:n
    sum = sum + (u(i) - mean(u))^k;
end

sum = (1 / n) * sum;

gamma = sum / (sigma^k);
end