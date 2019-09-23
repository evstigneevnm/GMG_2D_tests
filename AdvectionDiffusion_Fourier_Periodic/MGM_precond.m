function [ z_n_vec ] = MGM_precond(z_vec, b_vec, smoother_n, mu, it )
% MGM vector wrapper for MGM
    
    
    if (strcmp(smoother_n,'none')==1)
        z_n_vec = b_vec;
    else
        b = R2Ph(b_vec);
        z = R2Ph(z_vec);
        z_n=z;
        for ll = 1:1
            z_n = -MGM(it, z_n, b, smoother_n, mu);
        end
        z_n_vec = Ph2R(z_n);
    end
    

    

end

