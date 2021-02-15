function sigma = calc_sigma(u,n,trade_time)

sigma_sum = 0;
m = n - 1;

for i = 1:m
    sigma_sum = sigma_sum + (u(i) - mean(u))^2; 
end

sigma = sqrt(1 / (m - 1) * sigma_sum );

end

