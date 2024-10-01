function a = a_coeff(G,A)
s = size(G);
a(1:s(2)) = 0;

for m = 1:s(2)
    v(m) = 1;
    for i = m:s(2)
        
        if(i>m)
            v(i) = 0;
            v(i) = v(i)-A(i,m:i-1)*v(m:i-1)';
        end
        
        a(m) = a(m)+G(i)*v(i);
    end
end