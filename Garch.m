function sigma_garch = Garch(u, alpha, beta, omega)

n = length(u) + 1;

sigma_sq = zeros(n, 1);
sigma_sq(3) = u(2)^2;

for i = 3:(n - 1)
    sigma_sq(i + 1) = omega + alpha * (u(i))^2 + beta * sigma_sq(i);
end

sigma_garch = sqrt(sigma_sq);

end



