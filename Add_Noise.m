% Adds noise to the output y[n], for the number of points n_points
function z = Add_Noise(y, P, n_points)
v = P*var(y)/100;
sigma = (v)^.5;
z = zeros(1,n_points);
noise = sigma*randn(1,n_points);

for n = 1:n_points
    z(n) = y(n)+noise(n);
end
