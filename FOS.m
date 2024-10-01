classdef FOS
properties ( SetAccess = public )
    Selected_candidates = 0;
    z=0;
    K=0;
    L=0;
    N=0;
    a=0;
    Order=0;
    n_points = 0

    mse_1st_magnitude = 0;
    mse_1st_percent = 0;

    mse_2nd_magnitude = 0;
    mse_2nd_percent = 0;

    mse_3rd_magnitude = 0;
    mse_3rd_percent = 0;
end
    
methods

    function obj = FOS(x,y,Noise_percentage,K,L,Order, n_points)

    [obj.z, obj.Order, obj.Selected_candidates, obj.K, obj.L, obj.N,...
        obj.a, obj.mse_1st_magnitude, obj.mse_1st_percent,...
        obj.mse_2nd_magnitude, obj.mse_2nd_percent,...
        obj.mse_3rd_magnitude,obj.mse_3rd_percent]...
        = Fast_Orthogonal_Search(x, y, Noise_percentage, K, L, Order,...
        n_points);
    
    end

end
end
