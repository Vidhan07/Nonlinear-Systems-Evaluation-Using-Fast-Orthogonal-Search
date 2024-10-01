function y = System_1(x, n_points)
% System 1 
y = zeros(1,n_points);
for n = 10:n_points
y(n)= 1.2 + 0.124*y(n-1) + 0.2*x(n-2)*x(n-3) - 0.26*x(n-1)*y(n-2) ...
    - 1.03*x(n) - 0.03*y(n-2)*y(n-1); 
end