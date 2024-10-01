function y = Systems(system, x, n_points)
%Function to choose system.
y = zeros(1,n_points);

if system == 1 % System 1
    
    for n = 10:n_points
        y(n)= 1.142 - 1.0013*x(n) + 0.18*x(n-1)*x(n-2)...
            - 0.205*x(n-2)*y(n-1) + 0.00597*y(n-1) - 0.0423*y(n-1)*y(n-3);  
    end
    
elseif system == 2 % System 2
    
    for n = 10:n_points
        y(n)= -0.02 - 0.2034*x(n) + 0.013*x(n-1) - 0.082*x(n-2)*x(n)...
             + 0.0401*x(n-2)*x(n-2) + 0.3*x(n-2)*y(n-1)...
             - 0.0002413*y(n-2) - 0.0423*y(n-3) - 0.254*y(n-2)*y(n-4);
             
    end
    
elseif system == 3 % System 3
    
    for n = 10:n_points
        y(n)= 0.645 - 0.72*x(n-1) - 0.02*x(n)*x(n-5)...
            - 0.1233*y(n-1) + 0.352*y(n-3);
    end

end
