function p = Get_Candidate(x, z, t, N, N1, K, L, Order)

p = 1;
s = List_Order(K,L,Order);
i = s(t,:);
j = 1;

while (j <= Order*2 && i(j) ~= -1)
    
    if i(j) == 120
        p = p.*x(N+1-i(j+1):N1-i(j+1));
    else
        p = p.*z(N+1-i(j+1):N1-i(j+1));
    end
    
    j=j+2;
    
end

