function s=P_Candidates_Strings(K,L,Order)
j=factorial(K+L+1+Order)/(factorial(K+L+1)*factorial(Order));
s=32*ones(j,7*Order);

r=1;
s(1,1)=49;
for i=1:Order
    s(r+1:r+Number_of_Candidates_nthOrder(K+L+1,i),1:(i*7))=P_Candidates_Strings_nthOrder(K,L,i);
    r=r+Number_of_Candidates_nthOrder(K+L+1,i);
end