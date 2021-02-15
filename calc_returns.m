function u = calc_returns(data)

n = length(data);
u = zeros(n,1);

for i = 2:n
    u(i) = log(data(i)/data(i-1));
end

end

