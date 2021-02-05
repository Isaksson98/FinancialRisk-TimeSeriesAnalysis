function sigma = EqWMA(u,m, trade_time)

sigma_sum = 0;
n = length(u);

for i = 1:m
    sigma_sum = sigma_sum + u(n-i)^2; 
end

sigma = (1/m) * sigma_sum * trade_time;

end

