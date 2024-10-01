function s= P_Candidates_Strings_nthOrder(k,l,Order)
N=k+l+1;
M=Number_of_Candidates_nthOrder(N,Order);
s=32*ones(M,2*Order);
r=1;
orderminus1=Order-1;

if Order==1
    s=P_Candidates_Strings_XandYterms(k,l);
else
    a=P_Candidates_Strings_XandYterms(k,l);
    b=P_Candidates_Strings_nthOrder(k,l,orderminus1);
    for i=1:N
        for o=(1+Number_of_Candidates_nthOrder(N,orderminus1)-Number_of_Candidates_nthOrder(N+1-i,orderminus1)):Number_of_Candidates_nthOrder(N,orderminus1)
            s(r,1:7)=a(i,1:7);
            s(r,8:7+size(b,2))=b(o,:);
            r=r+1;
        end;
    end;
end

