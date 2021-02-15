function f = MLE(x, data)

alpha = x(1);
beta = x(2);
VL = x(3);

gamma = 1 - alpha - beta;

n = length(data);
sigma_sq = zeros(n,1);
u_sq = zeros(n,1);

    for i = 2:n
        u_sq(i) = ( log(data(i) / data(i-1)) )^2;
    end
    
sigma_sq(3) = u_sq(2);
MLE = 0;

    for i = 3:n
        sigma_sq(i + 1) = gamma * VL + alpha * u_sq(i) + beta * sigma_sq(i);
        MLE = MLE + ( - log(sigma_sq(i)) - u_sq(i) / sigma_sq(i) ) ;
    end    
    
    f = -MLE;
end
