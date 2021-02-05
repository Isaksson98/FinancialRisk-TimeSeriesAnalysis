function sigma = EWMA(u,m, trade_time, lambda)

sigma_sum = 0;
n = length(u);

for i = 1:m
    sigma_sum = (sigma_sum + (lambda^(i-1))*u(n-i)^2);
end

sigma = (1-lambda) * sigma_sum * trade_time;

end



