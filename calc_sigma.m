function sigma = calc_sigma(u,m,n,trade_time)

sigma_sum = 0;

for i = 1:m
    sigma_sum = sigma_sum + (u(n-i)-mean(u) )^2; 
end

sigma = sqrt(1/(m-1) * sigma_sum ) * sqrt(trade_time);

end

