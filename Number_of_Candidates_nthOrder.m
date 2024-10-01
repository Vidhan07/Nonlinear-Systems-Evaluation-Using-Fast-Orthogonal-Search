function M = Number_of_Candidates_nthOrder(N,Order)
M = factorial(N+Order-1)/(factorial(N-1)*factorial(Order));
