function [z, Order, Selected_candidates, K, L, N, a, ...
    mse_1st_magnitude, mse_1st_percent, mse_2nd_magnitude,...
    mse_2nd_percent, mse_3rd_magnitude, mse_3rd_percent]=...
    Fast_Orthogonal_Search(x, y, Noise_percentage, K, L, Order, n_points)

z = Add_Noise(y, Noise_percentage, n_points);

N = max([K;L]);
M = factorial(K+L+1+Order)/(factorial(K+L+1)*factorial(Order));
Candidates = transpose(1:M);
E(1) = 1;
G(1) = sum(z(N+1:1000))/(1000-N);
Selected_candidates(1) = Candidates(1);
A = 0;
M_S_E = sum(z(N+1:1000).^2)/(1000-N)-G(1)^2*E(1);

for m = 2:M 
    Alpha = 0;
    position = size(Selected_candidates,2)+1;
    
    for j = 2:M
        if Candidates(j,1) > -1
            P_m = Get_Candidate(x, z, j, N, 1000, K, L, Order);
            d(j,1) = sum(P_m)/(1000-N);
            
            for r = 1:position-1
                Alpha(j,r) = d(j,r)/E(1,r);
                
                if r+1 < position
                    P_rplus1 = Get_Candidate(x, z, ...
                        Selected_candidates(r+1), N, 1000, ...
                        K, L, Order);
                    
                    d(j,r+1) = sum(P_m.*P_rplus1)/...
                        (1000-N)-d(j,1:r)*A(r+1,1:r)';
                else
                    d(j,position) = sum(P_m.*P_m)/...
                        (1000-N)-Alpha(j,1:position-1).^2*...
                        (E(1,1:position-1)');
                    
                    c = sum(P_m.*z(N+1:1000))/(1000-N)-...
                        Alpha(j,1:position-1)*(E(1,1:position-1)...
                        .*G(1,1:position-1))';
                    
                    g(j)=c/d(j,position);
                end
                
            end
            
        end
        
    end
    
    Q = g.^2.*d(:,position)';
    [Q_M,sorted] = sort(Q,'descend');
    next_candidate = sorted(1,1);
    
    if (Q_M(1,1) > (4/(1000-N))*M_S_E)
        G(1,position) = g(next_candidate);
        E(1,position) = d(next_candidate,position);
        Selected_candidates(position) = next_candidate;
        A(position,1:position-1) = Alpha(next_candidate,1:position-1);
        M_S_E = M_S_E-Q_M(1,1);
    end
    
    Candidates(next_candidate,:)=-1;
end

a = A_Cof(G,A);

v1 = Model_Output(a,Selected_candidates,x(1,1:1000),K,L,N,Order);
mse_1st_magnitude = (sum((v1(N+1:1000)-z(N+1:1000)).^2))/(1000-N);
mse_1st_percent = (100*sum((v1(N+1:1000)-z(N+1:1000)).^2))/...
    ((1000-N)*var(z(N+1:1000)));

v2 = Model_Output(a,Selected_candidates,x(1,1001:2000),K,L,N,Order);
mse_2nd_magnitude = (sum((v2(N+1:1000)-z(N+1001:2000)).^2))/(1000-N);
mse_2nd_percent = (100*sum((v2(N+1:1000)-z(N+1001:2000)).^2))/...
    ((1000-N)*var(z(N+1001:2000)));

v3 = Model_Output(a,Selected_candidates,x(1,2001:3000),K,L,N,Order);
mse_3rd_magnitude = (sum((v3(N+1:1000)-z(N+2001:3000)).^2))/(1000-N);
mse_3rd_percent = (100*sum((v3(N+1:1000)-z(N+2001:3000)).^2))/...
    ((1000-N)*var(z(N+2001:3000)));
