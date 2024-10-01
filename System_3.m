function y = System_3(x, n_points)
% System 3
y = zeros(1,n_points);
for n = 10:n_points
y(n)= 0.46 + 0.152*y(n-3) - 2.162*x(n-1) - 1.02*x(n-2)*x(n)*y(n-1) - 0.233*y(n-1);
end
