function qq_plot(returns, sigma)

n = length(returns);
norm = zeros(n,1);
u = zeros(n,1);

for i = 1:n 
    u(i) = normcdf( (returns(i) - sigma^2) / (sigma) );
    norm(i) = norminv( (i-0.5)/n );
end

u_tilde = sort( u );
u_tilde_norm = norminv(u_tilde);

scatter(norm, u_tilde_norm,'+')
hold on;
plot(norm, norm, 'LineWidth', 1);

end

