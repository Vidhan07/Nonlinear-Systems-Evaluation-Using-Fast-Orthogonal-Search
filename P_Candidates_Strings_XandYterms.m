function s=P_Candidates_Strings_XandYterms(k,l)
j=k+(l+1);
s=32*ones(j,7);
r=0;
for i=1:k
    r=r+1;
    if floor (i/10)>0
        s(r,5)=48+floor(i/10);
    else
        s(r,5)=32;
    end;
    s(r,[1,2,3,4,6,7])=[121,91,110,45,(48+i-(floor(i/10)*10)),93];
end;
r=r+1;
s(r,[1,2,5,7])=[120,91,110,93];

for i=1:l
    r=r+1;
    if floor (i/10)>0
        s(r,5)=48+floor(i/10);
    else
        s(r,5)=32;
    end;
    s(r,[1,2,3,4,6,7])=[120,91,110,45,(48+i-(floor(i/10)*10)),93];
    
end;

