function s = x_and_y_terms(K,L)
r=0;
for i=1:K
    r=r+1;
    s(r,[1,2])=[121,i];
end
for i=1:L+1
    r=r+1;
    s(r,[1,2])=[120,i-1];
end


