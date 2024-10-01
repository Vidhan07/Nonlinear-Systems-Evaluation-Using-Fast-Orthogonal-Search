function y = System_2(x, n_points)
% System 2
y = zeros(1,n_points);
for n = 10:n_points
y(n)= -0.03 + 0.13*x(n-1) - 0.234*x(n) - 1.022*x(n-2)*x(n) - 1.13*y(n-2)...
    - 0.043*y(n-3) + 2.3*y(n-1)*x(n-2); 
end
