function s = List_Order(K, L, Order)
M = factorial(K+L+1+Order)/(factorial(K+L+1)*factorial(Order));
s = -1*ones(floor(M),2*Order);
r=1;

for i = 1:Order
    s(r+1:r+Number_of_Candidates_nthOrder(K+L+1,i),1:(i*2))...
        = Candidates_of_nthOrder(K,L,i);
    
    r = r + Number_of_Candidates_nthOrder(K+L+1,i);
end

