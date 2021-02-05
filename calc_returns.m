function [u_yearly, u] = calc_returns(data,trade_time)


n = length(data(:,2));
u = zeros(n,1);

for i = 2:n
    u(i) = log(data(i,1)/data(i-1,1));
end

u_yearly = mean(u)*sqrt(trade_time);
end

