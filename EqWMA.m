function sigmas = EqWMA(u,k,trade_time)

n = length(u);
sigmas = zeros(n + 1, 1);

%sum = 0;

%for i = (t-k):(t-1)
%    sum = sum + u(i)^2;
%    sigmas(i - t + k + 1) = sqrt(1/k * sum * trade_time)*100;
%end

for t = k:n
    
    sum = 0;
    
    for i = (t - (k - 1)):t
        sum = sum + u(i)^2;
    end
    
    sigmas(t + 1) = sqrt(1/k * sum * trade_time)*100;
end

end

