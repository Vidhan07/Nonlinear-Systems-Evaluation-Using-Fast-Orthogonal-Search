function s = Candidates_of_nthOrder(K,L,Order)
N = K+L+1;
M = Number_of_Candidates_nthOrder(N,Order);
s = -1*ones(M,2*Order);
r = 1;
Order2 = Order-1;

if Order == 1
    s = x_and_y_terms(K,L);
else
    a = x_and_y_terms(K,L);
    b = Candidates_of_nthOrder(K,L,Order-1);
    
    for i = 1:N
        for o = (1+floor(Number_of_Candidates_nthOrder(N,Order2))...
                -floor(Number_of_Candidates_nthOrder(N+1-i,Order2)))...
                :floor(Number_of_Candidates_nthOrder(N,Order2))
            
            s(r,1:2) = a(i,1:2);
            s(r,3:2*Order) = b(o,:);
            r = r+1;
        end
    end
    
end

