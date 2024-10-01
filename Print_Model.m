% Prints Best Model to Command Window
function Print_Model(sp,a,k,l,percentage,Order, modelnum)
disp('-------------------------------------------------------------------------------------------------');
disp(['         ','Best Model ' num2str(modelnum) ' (when Noise is ',num2str(percentage),'%)  ']);
disp('-------------------------------------------------------------------------------------------------');
M = size(a,2);
c = P_Candidates_Strings(k,l,Order);
disp(['y[n]=',num2str(a(1,1))]);
for n=2:M
    disp(['     ','+','(',num2str(a(1,n)),')',char(c(sp(1,n),:))]);
end
disp('-----------------------------------------------------------------------');

